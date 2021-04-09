import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/level_select_model.dart';
import '../widgets/stars.dart';
import 'package:geopattern_flutter/geopattern_flutter.dart';
import 'package:geopattern_flutter/patterns/squares.dart';
import '../screens/level_screen.dart';
import 'package:toast/toast.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>  {
  final hash = sha1.convert(utf8.encode("flutter")).toString();
  int hint_price = 80;int refresh_time_price = 700;
  int score;
  int hint_count;
  int time_restart_count;
  @override
  void initState(){
    ReadShopPrefsData();
  }

  Future ReadShopPrefsData() async{
    final prefs = await SharedPreferences.getInstance();
    final int _score = prefs.getInt('score') ?? 0;
    final int _hint_count = prefs.getInt('hint_count') ?? 3;
    final int _time_restart_count = prefs.getInt('time_restart_count') ?? 1;

    setState((){
      score = _score;
      hint_count = _hint_count;
      time_restart_count = _time_restart_count;
    });
  }

  Future SaveShopPrefsData({cur_score,score_loss,cur_hint_count,hint_count_gain,cur_time_restart_count,time_restart_count_gain}) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('score',cur_score - score_loss);
    prefs.setInt('hint_count',cur_hint_count + hint_count_gain);
    prefs.setInt('time_restart_count',cur_time_restart_count + time_restart_count_gain);

    setState((){
      score = cur_score - score_loss;
      hint_count = cur_hint_count + hint_count_gain;
      time_restart_count = cur_time_restart_count + time_restart_count_gain;
    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color:Colors.white)
                  
                  ),
                Text('Shop'.toUpperCase(),
                style: TextStyle(
                        // fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3
                )
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text('$score',
                    style: TextStyle(
                            // fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3
                    )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.casino_rounded,color:Colors.white,size:30.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text('$hint_count',
                    style: TextStyle(
                            // fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3
                    )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.lightbulb,color:Colors.white,size:30.0),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text('$time_restart_count',
                    style: TextStyle(
                            // fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3
                    )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.timelapse,color:Colors.white,size:30.0),
                    ),
                  ],
                ),
                
              ],
            ), backgroundColor: Colors.black45),
            body:Stack(
              children: [
                Container(
                  height:MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: LayoutBuilder(builder: (context, constraints) {
                  final pattern = Squares.fromHash(hash);
                  return CustomPaint(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      painter: FullPainter(pattern: pattern, background: Colors.blueGrey));
                }),
                ),
                      

                Container(
                width:MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height,
                child:GridView.count(
                padding:EdgeInsets.all(10.0),
                crossAxisCount: 2,
                children: [
                  ShopCard(
                    onPressed:(){
                      if(score > hint_price){
                        SaveShopPrefsData(
                          cur_score:score,
                          score_loss:hint_price,
                          cur_hint_count:hint_count,
                          hint_count_gain:1,
                          cur_time_restart_count:time_restart_count,
                          time_restart_count_gain:0,
                        );
                        Toast.show("Hint Bought", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

                      }else{
                        Toast.show("Insufficient Points Amount", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      }
                    },
                    leading_icon:Icon(Icons.lightbulb,color:Colors.white),title:'Hint',description: 'show correct answer on cell',price:hint_price),
                  ShopCard(
                    onPressed:(){
                      if(score > refresh_time_price){
                        SaveShopPrefsData(
                          cur_score:score,
                          score_loss:refresh_time_price,
                          cur_hint_count:hint_count,
                          hint_count_gain:0,
                          cur_time_restart_count:time_restart_count,
                          time_restart_count_gain:1,
                        );
                        Toast.show("Refresh Time Bought", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      }else{
                        Toast.show("Insufficient Points Amount", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      }
                    },
                    leading_icon:Icon(Icons.timelapse_outlined,color:Colors.white),title:'Refresh Time',description: 'Refresh the time on the timer',price:refresh_time_price)
                ]
                )
                ),
              ])

      );
        
}
}

class ShopCard extends StatelessWidget {
  const ShopCard({
    this.title,
    this.description,
    this.onPressed,
    this.price,
    this.leading_icon,
    Key key,
  }) : super(key: key);

  final String title;
  final String description;
  final onPressed;
  final int price;
  final leading_icon;


  @override
  Widget build(BuildContext context) {
    return Card(
    margin: EdgeInsets.all(10.0),
    color:Colors.white,
    clipBehavior: Clip.antiAlias,
    child: Column(
            children: [
              ListTile(
                tileColor: Colors.black54,
                leading: leading_icon,
                title: Text("$title",
                textAlign: TextAlign.center,
                style:TextStyle(
                  color:Colors.white,
                  fontFamily:'Scramble'
                )
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "$description",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontFamily:'Scramble'
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color:Colors.black87,
                      textColor: Colors.white,
                      onPressed: onPressed,
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Icon(Icons.casino_rounded,color:Colors.white),
                          Text('$price')
                          ]),
                      ),
                    )
                ],
              ),
            ],
          ),
        );
  }
}