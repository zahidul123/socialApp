import 'dart:async';

import 'package:custom_tinder/BubbleUpAnimation/BubbleUp.dart';
import 'package:custom_tinder/BubbleUpAnimation/FacebookReaction.dart';
import 'package:custom_tinder/JsonAndData/explore_json.dart';
import 'package:custom_tinder/JsonAndData/icons.dart';
import 'package:custom_tinder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:explode_view/explode_view.dart';


class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  CardController controller;

  bool showbubble=true;
  List itemsTemp = [];
  int itemLength = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemsTemp = explore_json;
      itemLength = explore_json.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
      bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    setState(() {
      if(showbubble==false){
        Timer(Duration(seconds: 3), () {
         showbubble=true;
        });
      }
    });
    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: Container(
        height: size.height,
        child: ListView(
          shrinkWrap: false,
          children: [
            Container(
              height:MediaQuery.of(context).size.height * 0.75,
              child:TinderSwapCard(
                totalNum: itemLength,
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height * 0.75,
                minWidth: MediaQuery.of(context).size.width * 0.75,
                minHeight: MediaQuery.of(context).size.height * 0.6,
                cardBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: grey.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 2),
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(itemsTemp[index]['img']),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    black.withOpacity(0.25),
                                    black.withOpacity(0),
                                  ],
                                  end: Alignment.topCenter,
                                  begin: Alignment.bottomCenter)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: size.width * 0.72,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                itemsTemp[index]['name'],
                                                style: TextStyle(
                                                    color: white,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                itemsTemp[index]['age'],
                                                style: TextStyle(
                                                  color: white,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                    color: green,
                                                    shape: BoxShape.circle),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Recently Active",
                                                style: TextStyle(
                                                  color: white,
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: List.generate(
                                                itemsTemp[index]['likes'].length,
                                                    (indexLikes) {
                                                  if (indexLikes == 0) {
                                                    return Padding(
                                                      padding:
                                                      const EdgeInsets.only(right: 8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: white, width: 2),
                                                            borderRadius:
                                                            BorderRadius.circular(30),
                                                            color:
                                                            white.withOpacity(0.4)),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(
                                                              top: 3,
                                                              bottom: 3,
                                                              left: 10,
                                                              right: 10),
                                                          child: Text(
                                                            itemsTemp[index]['likes']
                                                            [indexLikes],
                                                            style:
                                                            TextStyle(color: white),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.only(right: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(30),
                                                          color: white.withOpacity(0.2)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 3,
                                                            bottom: 3,
                                                            left: 10,
                                                            right: 10),
                                                        child: Text(
                                                          itemsTemp[index]['likes']
                                                          [indexLikes],
                                                          style: TextStyle(color: white),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: size.width * 0.2,
                                        child: Center(
                                          child: Icon(
                                            Icons.info,
                                            color: white,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                cardController: controller = CardController(),
                swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    //Card is LEFT swiping
                  } else if (align.x > 0) {
                    //Card is RIGHT swiping
                  }
                  // print(itemsTemp.length);
                },
                swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
                  /// Get orientation & index of swiped card!
                  if (index == (itemsTemp.length - 1)) {
                    setState(() {
                      itemLength = itemsTemp.length - 1;
                    });
                  }
                },
              ) ,
            ),
            Container(height:100,child:showbubble?Container():MybubbleHome() ,),
            Container(child: FbReaction(),)

        ],),
      ),
    );
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(color: white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: item_icons[0]['size'],
              height: item_icons[0]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[0]['icon'],
                  width: item_icons[0]['icon_size'],
                ),
              ),
            ),
            Container(
              width: item_icons[1]['size'],
              height: item_icons[1]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
              child: Center(
               child: ExplodeView(
                    imagePath: "assets/images/close_icon_1.jpg",
                    imagePosFromLeft: 50.0,
                    imagePosFromTop: 200.0)
              ),
            ),
            GestureDetector(child:Container(
              width: item_icons[2]['size'],
              height: item_icons[2]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[2]['icon'],
                  width: item_icons[2]['icon_size'],
                ),
              ),
            ) ,
            onTap: (){
              setState(() {
                showbubble=false;
              });
            },)
            ,
            Container(
              width: item_icons[3]['size'],
              height: item_icons[3]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[3]['icon'],
                  width: item_icons[3]['icon_size'],
                ),
              ),
            ),
            Container(
              width: item_icons[4]['size'],
              height: item_icons[4]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[4]['icon'],
                  width: item_icons[4]['icon_size'],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
