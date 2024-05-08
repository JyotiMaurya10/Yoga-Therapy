// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/model.dart';
import '../Services/yogadb.dart';
import 'workout.dart';

class rUready extends StatelessWidget {
  String YogaTableName;
  rUready({required this.YogaTableName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModel>(
      create: (context) => TimerModel(context, YogaTableName: YogaTableName),
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                ),
                const Text(
                  "ARE YOU READY?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Consumer<TimerModel>(builder: (context, myModel, child) {
                  return Text(
                    myModel.countdown.toString(),
                    style: const TextStyle(fontSize: 48),
                  );
                }),
                const Spacer(),
                const Divider(thickness: 2),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Text(
                        "Tip: Breath Slowly While Doing Streching Yoga",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerModel with ChangeNotifier {
  String YogaTableName;
  TimerModel(context, {required this.YogaTableName}) {
    FetchAllYoga(YogaTableName);
    MyTimer(context);
  }
  int countdown = 5;
  late List<Yoga> AllYoga;
  MyTimer(context) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      countdown--;
      if (countdown == 0) {
        timer.cancel();
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WorkOut(
                      ListOfYoga: AllYoga,
                      yogaindex: 0,
                    )));
      }
      notifyListeners();
    });
  }

  Future<List<Yoga>> FetchAllYoga(String yogaTableName) async {
    await YogaDatabase.instance.readAllYogaSum();
    AllYoga = await YogaDatabase.instance.readAllYoga(yogaTableName);
    print(AllYoga.length);
    notifyListeners();
    return AllYoga;
  }
}






// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:yoga_therapy/Screens/workout.dart';

// class rUready extends StatelessWidget {
//   const rUready({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<TimerModel>(
//         create: (context) => TimerModel(context),
//         child: Scaffold(
//           body: Center(
//             child: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 2 - 100,
//                   ),
//                   Text("ARE YOU READY?",
//                       style:
//                           TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 50),
//                   Consumer<TimerModel>(builder: (context, myModel, child) {
//                     return Text("${myModel.countdown}",
//                         style: TextStyle(
//                             fontSize: 50, fontWeight: FontWeight.bold));
//                   }),
//                   Spacer(),
//                   Divider(thickness: 2),
//                   Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 15),
//                         child: Text("NEXT: Anulom Vilom",
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold)),
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }

// class TimerModel with ChangeNotifier {
//   TimerModel(context) {
//     MyTimer(context);
//   }
//   int countdown = 5;

//   MyTimer(context) async {
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       countdown--;
//       notifyListeners();
//       if (countdown == 0) {
//         timer.cancel();
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => WorkOut()));
//       }
//     });
//   }
// }
