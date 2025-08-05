import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TravelBooking extends StatelessWidget {
  const TravelBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(20),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Color(0xFFEAEAD2),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.4),
                    blurRadius: 4,
                    spreadRadius: .02,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'One Way',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFEAEAD2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Round Trip',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(20)),
            Container(
              padding: EdgeInsets.all(20),
              width: double.maxFinite,
              height: 130,
              decoration: BoxDecoration(
                color: Color(0xFFEAEAD2),
                borderRadius: BorderRadiusDirectional.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'USA',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Chicago',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(
                        4,
                            (i) =>
                            Container(
                              width: 4,
                              height: 2,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadiusDirectional.circular(
                                    20),
                              ),
                            ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadiusDirectional.circular(20),
                        ),
                        child: Icon(
                          CupertinoIcons.airplane,
                          color: Colors.white,
                        ),
                      ),
                      ...List.generate(
                        4,
                            (i) =>
                            Container(
                              width: 4,
                              height: 2,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadiusDirectional.circular(
                                    20),
                              ),
                            ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'VIE',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'TanSonNhat',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Search'),
                              SizedBox(width: 3),
                              Icon(Icons.search),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          child: Text('Change'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(48)
                  ),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.calendar, color: Colors.black),
                      SizedBox(width: 10,),
                      Text('Today', style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black
                      ),)
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(48)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Text('June, 2025', style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black
                      ),)
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(48)
                  ),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.group_solid, color: Colors.black),
                      SizedBox(width: 10,),
                      Text('8/10', style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black
                      ),)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  final String weekDay;
  final String day;
  final bool isSelected;

  const DayWidget(
      {super.key, required this.weekDay, required this.day, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: Column(
      children: [
        Text(weekDay, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500
        ),)
      ],
    ),);
  }

}
