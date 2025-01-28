// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flood_monitor/utils/color.dart';
import 'package:flood_monitor/utils/constant.dart';
import 'package:flood_monitor/views/component/login/animations/animations.dart';
import 'package:flood_monitor/views/component/login/signup_screen.dart';
import 'package:flood_monitor/views/homePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final feature = ["Login"];

  int i = 0;

/*
Instagram: @CodeWithFlexz
Github: AmirBayat0
Youtube: Programming with Flexz
*/
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Color(0xfffdfdfdf),
            body: i == 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(25),
                          child: Column(
                            children: [
                              Row(
                                  // TabBar Code
                                  children: [
                                    Container(
                                      height: height / 19,
                                      width: width / 2,
                                      child: TopAnime(
                                        2,
                                        5,
                                        child: ListView.builder(
                                          itemCount: feature.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  i = index;
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20),
                                                    child: Text(
                                                      feature[index],
                                                      style: TextStyle(
                                                        color: i == index
                                                            ? Colors.black
                                                            : Colors.grey,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  i == index
                                                      ? Container(
                                                          height: 3,
                                                          width: width / 9,
                                                          color: Colors.black,
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                  ]),

                              SizedBox(
                                height: 50,
                              ),

                              // Top Text
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                width: width,
                                child: TopAnime(
                                  1,
                                  20,
                                  curve: Curves.fastOutSlowIn,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Welcome back in,",
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w300,
                                          )),
                                      Text(
                                        "FloodSenseAI",
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: height / 14,
                              ),

                              // TextFiled
                              Column(
                                children: [
                                  Container(
                                    width: width / 1.2,
                                    height: height / 3.10,
                                    //  color: Colors.red,
                                    child: TopAnime(
                                      1,
                                      15,
                                      curve: Curves.easeInExpo,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            // readOnly: true, // * Just for Debug
                                            cursorColor: Colors.black,
                                            style:
                                                TextStyle(color: Colors.black),
                                            showCursor: true,
                                            //cursorColor: mainColor,
                                            decoration:
                                                kTextFiledInputDecoration,
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          TextField(
                                              // readOnly: true, // * Just for Debug
                                              cursorColor: Colors.black,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              showCursor: true,
                                              //cursorColor: mainColor,
                                              decoration:
                                                  kTextFiledInputDecoration
                                                      .copyWith(
                                                          labelText:
                                                              "Password")),

                                          SizedBox(
                                            height: 5,
                                          ),

                                          // FaceBook and Google ICon
                                          TopAnime(
                                            1,
                                            10,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.facebookF,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                IconButton(
                                                  icon: FaIcon(
                                                      FontAwesomeIcons
                                                          .googlePlusG,
                                                      size: 35),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        // Bottom
                        i == 0
                            ? TopAnime(
                                2,
                                42,
                                curve: Curves.fastOutSlowIn,
                                child: Container(
                                  height: height / 6,
                                  // color: Colors.red,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 43),
                                        child: Container(
                                            height: height / 9,
                                            color:
                                                Colors.grey.withOpacity(0.4)),
                                      ),
                                      Positioned(
                                        left: 280,
                                        top: 10,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        homePage()));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: kprimarySecond,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            width: width / 4,
                                            height: height / 12,
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 35,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SignUPScreen()
                      ],
                    ),
                  )
                : SignUPScreen()),
      ),
    );
  }
}
