
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flagsmith/flagsmith.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final flagsmithClient = FlagsmithClient(
        apiKey: '6JBm2Yy8AUQsjwBru8QtCL',
       
        seeds: [
            Flag.seed('feature', enabled: true),
        ],
    );

  
  bool isButtonEnableTrue=false;
  bool isFirstName = false;
  bool isLastName = false;

  @override
  void initState() {
    super.initState();
    log("The init state");
    listenMethod();
    callFlagsSmitApi();
  } 
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          if(isFirstName) const  TextField(
              decoration:  InputDecoration(
                hintText: "First Name "
              ),
             ),
        if(isLastName)  const   TextField(
              decoration: InputDecoration(
                hintText: "Last Name"
              ),
             ),
              if(isButtonEnableTrue) ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Want to Make a Chat",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void callFlagsSmitApi() async{
    await flagsmithClient.getFeatureFlags(reload: true);
    final v1 = await flagsmithClient.getFeatureFlags(reload: true);
     setState(() {
       isButtonEnableTrue=v1[0].enabled!;
       isFirstName = v1[1].enabled!;
       isLastName = v1[2].enabled!;
     });
  
  }
  
  void listenMethod() {
    flagsmithClient.loading.listen((event) {
      log("The event Listener is Working >>> ${event.toString()}");
    });
  }
}
