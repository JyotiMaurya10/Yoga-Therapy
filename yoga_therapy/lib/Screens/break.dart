// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/model.dart';
import 'workout.dart';

class BreakTime extends StatelessWidget {
  List<Yoga> ListOfYoga;
  int yogaindex;
  BreakTime({required this.ListOfYoga, required this.yogaindex});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>(
      create: (context) => TimerModelSec(context, ListOfYoga, yogaindex),
      child: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1558017487-06bf9f82613a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=470&q=80"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "Break Time",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Consumer<TimerModelSec>(
              builder: (context, myModel, child) {
                return Text(
                  myModel.countdown.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55, color: Colors.black),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<TimerModelSec>(builder: (context, myModel, child) {
              return ElevatedButton(
                  onPressed: () {
                    myModel.skip();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                    child: Text(
                      "SKIP",
                      style: TextStyle(fontSize: 19),
                    ),
                  ));
            }),
            Spacer(),
             Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        yogaindex != 0
                            ? Consumer<TimerModelSec>(builder: (context, myModel, child) {
                                return TextButton(
                                    onPressed: () async{
                                      myModel.Pass();
                                        await Future.delayed(const Duration(seconds: 1));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BreakTime(
                                                  ListOfYoga: ListOfYoga,
                                                  yogaindex: yogaindex - 1)));
                                    },
                                    child: const Text(
                                      "Previous",
                                      style: TextStyle(fontSize: 16),
                                    ));
                              })
                            : Container(),
                        yogaindex != ListOfYoga.length - 1
                            ? Consumer<TimerModelSec>(
                                builder: (context, myModel, child) {
                                  return TextButton(
                                      onPressed: ()  async{
                                        myModel.Pass();
                                        await Future.delayed(const Duration(seconds: 1));
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => BreakTime(
                                                    ListOfYoga: ListOfYoga,
                                                    yogaindex: yogaindex + 1)));
                                      },
                                      child: const Text("Next", style: TextStyle(fontSize: 16)));
                                },
                              )
                            : Container()
                      ],
                    ),
                  ),
            Divider(
              thickness: 2,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    "Next: ${yogaindex >= ListOfYoga.length - 1 ? "FINISH" : ListOfYoga[yogaindex].YogaTitle}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}

class TimerModelSec with ChangeNotifier {
  TimerModelSec(context, List<Yoga> ListOfYoga, int yogaindex) {
    MyTimerSec(context, ListOfYoga, yogaindex);
  }
  int countdown = 25;
  bool Isskip = false;
     bool isPassed = false;
  MyTimerSec(context, List<Yoga> ListOfYoga, int yogaindex) async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if (countdown == 0 || Isskip) {
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WorkOut(
                      ListOfYoga: ListOfYoga,
                      yogaindex: yogaindex,
                    )));
      }
      if (isPassed) {
        timer.cancel();
      }
    });
  }

  void skip() {
    Isskip = true;
    notifyListeners();
  }

   void Pass() {
    isPassed = true;
    notifyListeners();
  }
}

// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'workout.dart';

// class BreakScreen extends StatelessWidget {
//   const BreakScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<TimerModelSec>(
//         create: (context) => TimerModelSec(context),
//         child: Scaffold(
//             body: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: NetworkImage(
//                       "https://th.bing.com/th/id/OIP.-jGBzb-5Zq5t5duEbuqNdwHaEo?w=263&h=180&c=7&r=0&o=5&dpr=1.2&pid=1.7"),
//                   fit: BoxFit.cover)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Spacer(),
//               Text("Break Time",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold,shadows: [
//       Shadow(
//         color: Colors.black,
//         offset: Offset(2, 2),
//         blurRadius: 3,
//       ),
//     ],),),
//     // Spacer(),
//     Consumer<TimerModelSec>(
//                       builder: (context, myModel, child) {
//                         return Text(
//                           myModel.countdown.toString().length == 1
//                               ? "0${myModel.countdown}"
//                               : myModel.countdown.toString(),
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize:60,
//                               color: Colors.black,  shadows: [
//       Shadow(
//         color: Colors.white,
//         offset: Offset(2, 2),
//         blurRadius: 3,
//       ),
//     ],),
//                         );
//                       },
//                     ),
//     SizedBox(height: 20,),
//      ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//                 backgroundColor: Colors.black,
//               ),
//               onPressed: () {},
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
//                 child: Text(
//                   'SKIP',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             //  Spacer(flex:2),
//             // ElevatedButton(
//             //   style: ElevatedButton.styleFrom(
//             //     shape: RoundedRectangleBorder(
//             //         borderRadius: BorderRadius.circular(8)),
//             //     backgroundColor: Colors.blue,
//             //   ),
//             //   onPressed: () {},
//             //   child: Padding(
//             //     padding:
//             //         const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
//             //     child: Text(
//             //       'PAUSE',
//             //       style: TextStyle(color: Colors.white, fontSize: 20),
//             //       textAlign: TextAlign.center,
//             //     ),
//             //   ),
//             // ),
//              Spacer(),
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
//             // Spacer(flex:2),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     children: [
//             //       TextButton(
//             //           onPressed: () {},
//             //           child: Text("Previous",
//             //               style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold))),
//             //       TextButton(
//             //           onPressed: () {},
//             //           child: Text("Next",
//             //               style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold))),
//             //     ],
//             //   ),
//             // ),
//             ],
//           ),
//         )));
//   }
// }

// class TimerModelSec with ChangeNotifier {
//   TimerModelSec(context) {
//     MyTimer(context);
//   }
//   int countdown = 20;

//   MyTimer(context) async {
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       countdown--;
//       notifyListeners();
//       if (countdown == 0) {
//         timer.cancel();
//         // Navigator.push(
//         //     context, MaterialPageRoute(builder: (context) => WorkOut()));
//       }
//     });
//   }
// }
