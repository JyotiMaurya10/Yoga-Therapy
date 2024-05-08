import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_therapy/Screens/finish.dart';
import 'package:yoga_therapy/Screens/ruReady.dart';

import '../Model/model.dart';
import 'break.dart';

class WorkOut extends StatelessWidget {
  List<Yoga> ListOfYoga;
  int yogaindex;
  WorkOut({required this.ListOfYoga, required this.yogaindex});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>(
      create: (context) =>
          TimerModelSec(context, ListOfYoga, yogaindex + 1, ListOfYoga[yogaindex].SecondsOrTimes),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(ListOfYoga[yogaindex].YogaImgUrl))),
                  ),
                  const Spacer(),
                  Text(
                    ListOfYoga[yogaindex].YogaTitle,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 80),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent, borderRadius: BorderRadius.circular(50)),
                      child: ListOfYoga[yogaindex].Seconds
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "00",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                                const Text(
                                  " : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                                Consumer<TimerModelSec>(
                                  builder: (context, myModel, child) {
                                    return Text(
                                      myModel.countdown.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Colors.white),
                                    );
                                  },
                                )
                              ],
                            )
                          : Text(
                              "x${ListOfYoga[yogaindex].SecondsOrTimes}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                            )),
                  const Spacer(),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<TimerModelSec>(
                    builder: (context, myModel, child) {
                      return ElevatedButton(
                          onPressed: () {
                            myModel.show();
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              child: const Text(
                                "PAUSE",
                                style: TextStyle(fontSize: 20),
                              )));
                    },
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        yogaindex != 0
                            ? Consumer<TimerModelSec>(builder: (context, myModel, child) {
                                return TextButton(
                                    onPressed: () async {
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
                                      onPressed: () async {
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
                  const Divider(
                    thickness: 2,
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          "Next: ${yogaindex >= ListOfYoga.length - 1 ? "FINISH" : ListOfYoga[yogaindex + 1].YogaTitle}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ),
            Consumer<TimerModelSec>(
              builder: (context, myModel, child) {
                return Visibility(
                    visible: myModel.visible,
                    child: Container(
                      color: Colors.blueAccent.withOpacity(0.9),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Pause",
                            style: TextStyle(
                                fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Yoga feels better",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorkOut(
                                              ListOfYoga: ListOfYoga,
                                              yogaindex: 0,
                                            )));
                              },
                              child: Container(
                                width: 180,
                                child: const Text(
                                  "Restart",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 180,
                                child: const Text(
                                  "Quit",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          OutlinedButton(
                            onPressed: () {
                              myModel.hide();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white)),
                            child: Container(
                              width: 180,
                              child: const Text(
                                "RESUME",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}

class TimerModelSec with ChangeNotifier {
  TimerModelSec(context, List<Yoga> ListOfYoga, int yogaindex, countdown) {
    setCDownValue(int.parse(countdown), ListOfYoga[yogaindex - 1].Seconds);
    checkIfLast(yogaindex >= ListOfYoga.length - 1);
    MyTimerSec(context, ListOfYoga, yogaindex);
  }
  int countdown = 0;
  void setCDownValue(int count, bool isSec) {
    countdown = isSec ? count : 1000;
  }

  bool visible = false;
  bool isPassed = false;
  bool isLast = false;

  MyTimerSec(context, List<Yoga> ListOfYoga, int yogaindex) async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      visible ? countdown + 0 : countdown--;
      notifyListeners();
      if (countdown == 0) {
        timer.cancel();
        isLast?Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FinishScreen())):
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BreakTime(ListOfYoga: ListOfYoga, yogaindex: yogaindex)));
      }
      if (isPassed) {
        timer.cancel();
      }
    });
  }

  void checkIfLast(bool ans) {
    isLast = ans;
  }

  void show() {
    visible = true;
    notifyListeners();
  }

  void hide() {
    visible = false;
    notifyListeners();
  }

  void Pass() {
    isPassed = true;
    notifyListeners();
  }
}


// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Model/model.dart';
// import 'break.dart';

// class WorkOut extends StatelessWidget {
//  List<Yoga> ListOfYoga;
//   int yogaindex;
//    WorkOut({
//     required this.ListOfYoga,
//      required this.yogaindex
// });
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<TimerModelSec>(
//         create: (context) => TimerModelSec(context),
//         child: Scaffold(
//             body: Stack(
//           children: [
//             Container(
//               child: Column(
//                 children: [
//                   Container(
//                       height: 350,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: NetworkImage(ListOfYoga[yogaindex].YogaImgUrl)
//                       ))),
//                   Spacer(),
//                   Text(ListOfYoga[yogaindex].YogaTitle,
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
//                   Spacer(),
//                   Container(
//                       margin: EdgeInsets.symmetric(horizontal: 80),
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//                       decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(50)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("00",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 30,
//                                   color: Colors.white)),
//                           const Text(" : ",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 30,
//                                   color: Colors.white)),
//                           Consumer<TimerModelSec>(
//                             builder: (context, myModel, child) {
//                               return Text(
//                                 myModel.countdown.toString().length == 1
//                                     ? "0${myModel.countdown}"
//                                     : myModel.countdown.toString(),
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 30,
//                                     color: Colors.white),
//                               );
//                             },
//                           )
//                         ],
//                       )),
//                   // SizedBox(height: 20),
//                   Spacer(),
//                   Consumer<TimerModelSec>(builder: (context, myModel, child) {
//                     return ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                         backgroundColor: Colors.blue,
//                       ),
//                       onPressed: () {
//                         myModel.show();
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 18),
//                         child: Text(
//                           'PAUSE',
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     );
//                   }),

//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                             onPressed: () {},
//                             child: Text("Previous",
//                                 style: TextStyle(
//                                     color: Colors.blue, fontSize: 20))),
//                         TextButton(
//                             onPressed: () {},
//                             child: Text("Next",
//                                 style: TextStyle(
//                                     color: Colors.blue, fontSize: 20))),
//                       ],
//                     ),
//                   ),
//                   // SizedBox(height: 10),

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
//             Consumer<TimerModelSec>(builder: (context, myModel, child) {
//               return Visibility(
//                   visible: myModel.visible,
//                   child: Container(
//                     color: Colors.blue.withOpacity(0.8),
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 50),
//                           child: Text("Pause",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 50)),
//                         ),
//                         OutlinedButton(
//                           onPressed: () {},
//                           child: Container(
//                             margin: EdgeInsets.all(10),
//                             width: 100,
//                             child: Text(
//                               "RESTART",
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.white),
//                             side: MaterialStateProperty.all<BorderSide>(
//                                 BorderSide(color: Colors.white)),
//                           ),
//                         ),
//                         SizedBox(height: 30),
//                         OutlinedButton(
//                           onPressed: () {},
//                           child: Container(
//                             margin: EdgeInsets.all(10),
//                             width: 100,
//                             child: Text(
//                               "QUIT",
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.white),
//                             side: MaterialStateProperty.all<BorderSide>(
//                                 BorderSide(color: Colors.white)),
//                           ),
//                         ),
//                         SizedBox(height: 30),
//                         OutlinedButton(
//                           onPressed: () {
//                             myModel.hide();
//                           },
//                           child: Container(
//                             margin: EdgeInsets.all(10),
//                             width: 100,
//                             child: Text(
//                               "RESUME",
//                               style: TextStyle(
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all(Colors.white),
//                             side: MaterialStateProperty.all<BorderSide>(
//                                 BorderSide(color: Colors.white)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ));
//             }),
//           ],
//         )));
//   }
// }

// class TimerModelSec extends ChangeNotifier {
//   TimerModelSec(context) {
//     MyTimerSec(context);
//   }
//   int countdown = 30;
//   bool visible = false;
//   MyTimerSec(context) async {
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       countdown--;
//       notifyListeners();
//       if (countdown == 0) {
//         timer.cancel();
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => BreakScreen()));
//       }
//     });
//   }

//   void show() {
//     visible = true;
//     notifyListeners();
//   }

//   void hide() {
//     visible = false;
//     notifyListeners();
//   }
// }
