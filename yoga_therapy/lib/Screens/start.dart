// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../Model/model.dart';
import '../Services/yogadb.dart';
import 'ruReady.dart';

class Startup extends StatefulWidget {
  String Yogakey;
  YogaSummary yogaSum;
  Startup({required this.Yogakey, required this.yogaSum});

  @override
  _StartupState createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadAllYoga();
  }

  late List<Yoga> AllYogaWorkOuts;
  bool isLoading = true;
  Future ReadAllYoga() async {
    this.AllYogaWorkOuts =
        await YogaDatabase.instance.readAllYoga(widget.yogaSum.YogaWorkOutName);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Container(),
          )
        : Scaffold(
            floatingActionButton: ElevatedButton(
               style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => rUready(
                              YogaTableName: widget.yogaSum.YogaWorkOutName,
                            )));
              },
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: Text(
              'START',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    title: Text(widget.yogaSum.YogaWorkOutName),
                    background: Image.network(
                      widget.yogaSum.BackImg.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.thumb_up_alt_rounded))
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "${widget.yogaSum.TimeTaken} Mins || ${widget.yogaSum.TotalNoOfWork} Workouts",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                        Divider(thickness: 2),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => Divider(
                                  thickness: 2,
                                ),
                            itemBuilder: (context, index) => ListTile(
                                  leading: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Image.network(
                                        AllYogaWorkOuts[index].YogaImgUrl,
                                        fit: BoxFit.cover,
                                      )),
                                  title: Text(
                                    AllYogaWorkOuts[index].YogaTitle,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    AllYogaWorkOuts[index].Seconds
                                        ? "00:${AllYogaWorkOuts[index].SecondsOrTimes}"
                                        : "x${AllYogaWorkOuts[index].SecondsOrTimes}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                            itemCount: AllYogaWorkOuts.length)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

// import 'package:flutter/material.dart';
// import 'package:yoga_therapy/Screens/ruReady.dart';

// class StartUp extends StatelessWidget {
//   const StartUp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue,
//           ),
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => rUready()));
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
//             child: Text(
//               'START',
//               style: TextStyle(color: Colors.white, fontSize: 18),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         body: CustomScrollView(slivers: [
//           SliverAppBar(
//               backgroundColor: Colors.blue,
//               expandedHeight: 300,
//               pinned: true,
//               actions: [
//                 Icon(
//                   Icons.thumb_up_alt,
//                   color: Colors.white,
//                 ),
//                 SizedBox(
//                   width: 20,
//                 )
//               ],
//               flexibleSpace: FlexibleSpaceBar(
//                 centerTitle: false,
//                 collapseMode: CollapseMode.parallax,
//                 title: Text(
//                   "Yoga",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 background: Image.network(
//                   "https://th.bing.com/th/id/R.6dd8faa73b3614e77d82b4e328374e72?rik=HQMe3HTAy1Y9%2bg&riu=http%3a%2f%2fhavingtime.com%2fwp-content%2fuploads%2f2014%2f01%2fyoga-mindfulness.jpg&ehk=h1n2Ol32%2bf%2fdBUA9Ib3PH30CT2L0yFKYvjuOrnJBBCU%3d&risl=&pid=ImgRaw&r=0",
//                   fit: BoxFit.cover,
//                 ),
//               )),
//           SliverToBoxAdapter(
//             child: Container(
//               child: Column(
//                 children: [
//                   SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Center(
//                         child: Text("16 Mins !! 26 Workouts",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 18)),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Divider(
//                     thickness: 2,
//                     indent: 20,
//                     endIndent: 20,
//                   ),
//                   SizedBox(height: 5),
//                   ListView.separated(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: 20,
//                       separatorBuilder: (context, index) => Divider(),
//                       itemBuilder: (context, index) => ListTile(
//                             leading: Container(
//                               margin: EdgeInsets.only(right: 20),
//                               child: Image.network(
//                                   "https://mindbodygreen-res.cloudinary.com/image/upload/w_767,q_auto:eco,f_auto,fl_lossy/ftr/sequence1.gif",
//                                   fit: BoxFit.cover),
//                             ),
//                             title: Text(
//                               "Yoga $index",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18),
//                             ),
//                             subtitle: Text(
//                               (index % 2 == 0) ? "00:20" : "x20",
//                               style: TextStyle(fontSize: 15),
//                             ),
//                           ))
//                 ],
//               ),
//             ),
//           ),
//         ]));
//   }
// }
