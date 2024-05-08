// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FinishScreen extends StatelessWidget {
  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                    "https://cdn.dribbble.com/users/731566/screenshots/3187347/winner.gif"),
                Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                      Column(children: [
                        Text("125",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
                        Text("kCal",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))
                      ]),
                      Column(children: [
                        Text("12",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
                        Text("Minutes",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))
                      ])
                    ])),
                   Spacer(),
                Container(
                    child: Column(children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.blue.shade600,
                      ),
                      onPressed: () {},
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 60),
                          child: Text(
                            'HomeScreen',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          )))
                ])),
                Spacer(),
                 Container(
                      height: 250,
                      width: 300,
                      child: Image.network("https://th.bing.com/th/id/OIP.c0DF_Ie-M_b2kZ-H4CIGzwHaG3?w=202&h=187&c=7&r=0&o=5&dpr=1.2&pid=1.7")),
                 
                Spacer(),
                Divider(thickness: 2),
                Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 18),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Text("DO IT AGAIN",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                      Text("SHARE",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500))
                    ])),
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
