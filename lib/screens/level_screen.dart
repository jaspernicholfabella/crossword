import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../movement.dart';
import 'dart:math';
import 'package:timer_count_down/timer_count_down.dart';
import 'level_select_screen.dart';
import '../data/level_select_data.dart';
import 'package:flutter/foundation.dart';
import '../widgets/stars.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/level_select_model.dart';
import '../widgets/circle_button.dart';
import '../widgets/results_display.dart';
import './loading_home_screen.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:toast/toast.dart';
import '../keyboard.dart';


class LevelScreen extends StatefulWidget {
  final level_data;
  final String title;
  final int id;
  LevelScreen({this.id,this.level_data,this.title});

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  //level_select
  final CountdownController _controller = new CountdownController();
  List<LevelSelectModel> level_select_data;
  bool is_locked_lv2;bool is_locked_lv3;bool is_locked_lv4;
  bool is_locked_lv5;bool is_locked_lv6;bool is_locked_lv7;
  bool is_locked_lv8;int rate_lv1;int rate_lv2;
  int rate_lv3;int rate_lv4;int rate_lv5;int rate_lv6;
  int rate_lv7;int rate_lv8;

  //powerups
  int hint_count;
  int time_restart_count;

  //level_screen
  int id;int first_index;int last_index_hor;int current_grid_size;Color random_color;
  int current_selected_index;double border_width ;double selected_border_width;
  var input_cell;var qa;String question = '';Map correct_answer_dict = new Map();
  Map current_answer_dict = new Map();bool is_hor=true; bool is_hint = false;
  bool is_game_done = false;
  bool is_crossword_checking = false;
  bool  is_win = false;
  int score;
  int current_time = 0;
  int seconds;

  @override
  void initState(){
    ReadLevelSelectPrefsData();
    ReadScoreCount();
    ReadPowerupCount();
    id = widget.id;
    random_color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.6);
    first_index = widget.level_data.first_index;
    last_index_hor = widget.level_data.last_index_hor;
    current_grid_size = widget.level_data.current_grid_size;
    current_selected_index = widget.level_data.first_index;
    input_cell = widget.level_data.input_cell;
    qa = widget.level_data.qa;
    correct_answer_dict = checkAnswer(qa);
    current_answer_dict = currentAnswer(qa);
    border_width = 1.0;
    selected_border_width= 1.0;
    seconds = widget.level_data.time;
  }

  Future ReadLevelSelectPrefsData() async{
    final prefs = await SharedPreferences.getInstance();
    final bool _is_locked_lv2 = prefs.getBool('is_locked_lv2') ?? true;
    final bool _is_locked_lv3 = prefs.getBool('is_locked_lv3') ?? true;
    final bool _is_locked_lv4 = prefs.getBool('is_locked_lv4') ?? true;
    final bool _is_locked_lv5 = prefs.getBool('is_locked_lv5') ?? true;
    final bool _is_locked_lv6 = prefs.getBool('is_locked_lv6') ?? true;
    final bool _is_locked_lv7 = prefs.getBool('is_locked_lv7') ?? true;
    final bool _is_locked_lv8 = prefs.getBool('is_locked_lv8') ?? true;
    final int _rate_lv1 = prefs.getInt('rate_lv1') ?? 0;
    final int _rate_lv2 = prefs.getInt('rate_lv2') ?? 0;
    final int _rate_lv3 = prefs.getInt('rate_lv3') ?? 0;
    final int _rate_lv4 = prefs.getInt('rate_lv4') ?? 0;
    final int _rate_lv5 = prefs.getInt('rate_lv5') ?? 0;
    final int _rate_lv6 = prefs.getInt('rate_lv6') ?? 0;
    final int _rate_lv7 = prefs.getInt('rate_lv7') ?? 0;
    final int _rate_lv8 = prefs.getInt('rate_lv8') ?? 0;
    setState((){
      is_locked_lv2 = _is_locked_lv2;is_locked_lv3 = _is_locked_lv3;is_locked_lv4 = _is_locked_lv4;
      is_locked_lv5 = _is_locked_lv5;is_locked_lv6 = _is_locked_lv6;is_locked_lv7 = _is_locked_lv7;
      is_locked_lv8 = _is_locked_lv8;rate_lv1=_rate_lv1;rate_lv2=_rate_lv2;rate_lv3=_rate_lv3;rate_lv4=_rate_lv4;
      rate_lv5=_rate_lv5;rate_lv6=_rate_lv6;rate_lv7=_rate_lv7;rate_lv8=_rate_lv8;
    });
  }

  Future ReadScoreCount() async{
    final prefs = await SharedPreferences.getInstance();
    final _score = prefs.getInt('score') ?? 0;
    setState((){
      score = _score;
    });
  }

  Future ReadPowerupCount() async{
    final prefs = await SharedPreferences.getInstance();
    final int _hint_count = prefs.getInt('hint_count') ?? 3;
    final int _time_restart_count = prefs.getInt('time_restart_count') ?? 1;
    setState((){
      hint_count = _hint_count;
      time_restart_count = _time_restart_count;
    });
  }

  Future SavePowerupCount({cur_hint_count,hint_count_loss,cur_time_restart_count,time_restart_count_loss}) async{
    final prefs = await SharedPreferences.getInstance();
    if (hint_count > 0){
      prefs.setInt('hint_count',cur_hint_count - hint_count_loss);

      setState((){
        hint_count = cur_hint_count - hint_count_loss;
      });
    }
    if (time_restart_count > 0){
      prefs.setInt('time_restart_count',cur_time_restart_count - time_restart_count_loss);

      setState((){
        time_restart_count = cur_time_restart_count - time_restart_count_loss;
      });
    }
  }

  Future SaveScore({cur_score,score_gain}) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('score',cur_score + score_gain);
  }


  Future SaveLevelSelectPrefsData(id,rate) async{
    final prefs = await SharedPreferences.getInstance();
    switch(id){
      case 1:{
      if (rate > rate_lv1){
        prefs.setInt('rate_lv1',rate);
      }
      prefs.setBool('is_locked_lv2',false);
      setState((){
        if (rate > rate_lv1){
          rate_lv1=rate;
        }
        is_locked_lv2 = false;
        level_select_data = GenerateLevelSelectData(
        rate_lv1:rate_lv1,rate_lv2:rate_lv2,rate_lv3:rate_lv3,rate_lv4:rate_lv4,rate_lv5:rate_lv5,rate_lv6:rate_lv6,
        rate_lv7:rate_lv7,rate_lv8:rate_lv8,is_locked_lv2:is_locked_lv2,is_locked_lv3:is_locked_lv3,is_locked_lv4:is_locked_lv4,
        is_locked_lv5:is_locked_lv5,is_locked_lv6:is_locked_lv6,is_locked_lv7:is_locked_lv7,is_locked_lv8:is_locked_lv8);

      });
      }break;
      case 2:{
      if (rate > rate_lv2){
        prefs.setInt('rate_lv2',rate);
      }
      prefs.setBool('is_locked_lv3',false); 
      setState((){
        if (rate > rate_lv2){
          rate_lv2=rate;
        }
        is_locked_lv3 = false;
        level_select_data = GenerateLevelSelectData(
        rate_lv1:rate_lv1,rate_lv2:rate_lv2,rate_lv3:rate_lv3,rate_lv4:rate_lv4,rate_lv5:rate_lv5,rate_lv6:rate_lv6,
        rate_lv7:rate_lv7,rate_lv8:rate_lv8,is_locked_lv2:is_locked_lv2,is_locked_lv3:is_locked_lv3,is_locked_lv4:is_locked_lv4,
        is_locked_lv5:is_locked_lv5,is_locked_lv6:is_locked_lv6,is_locked_lv7:is_locked_lv7,is_locked_lv8:is_locked_lv8);

      });
      }break;
      case 3:{
      if(rate > rate_lv3){
        prefs.setInt('rate_lv3',rate);
      }
      
      prefs.setBool('is_locked_lv4',false); 
      setState((){
        if(rate > rate_lv3){
          rate_lv3=rate;
        }
        is_locked_lv4 = false;
        level_select_data = GenerateLevelSelectData(
        rate_lv1:rate_lv1,rate_lv2:rate_lv2,rate_lv3:rate_lv3,rate_lv4:rate_lv4,rate_lv5:rate_lv5,rate_lv6:rate_lv6,
        rate_lv7:rate_lv7,rate_lv8:rate_lv8,is_locked_lv2:is_locked_lv2,is_locked_lv3:is_locked_lv3,is_locked_lv4:is_locked_lv4,
        is_locked_lv5:is_locked_lv5,is_locked_lv6:is_locked_lv6,is_locked_lv7:is_locked_lv7,is_locked_lv8:is_locked_lv8);

      });
      }break;
      case 4:{
      if(rate > rate_lv4){
        prefs.setInt('rate_lv4',rate);
      }
      
      prefs.setBool('is_locked_lv5',false);
      setState((){
        if(rate > rate_lv4){
          rate_lv4=rate;
        }
        is_locked_lv5 = false;
        level_select_data = GenerateLevelSelectData(
        rate_lv1:rate_lv1,rate_lv2:rate_lv2,rate_lv3:rate_lv3,rate_lv4:rate_lv4,rate_lv5:rate_lv5,rate_lv6:rate_lv6,
        rate_lv7:rate_lv7,rate_lv8:rate_lv8,is_locked_lv2:is_locked_lv2,is_locked_lv3:is_locked_lv3,is_locked_lv4:is_locked_lv4,
        is_locked_lv5:is_locked_lv5,is_locked_lv6:is_locked_lv6,is_locked_lv7:is_locked_lv7,is_locked_lv8:is_locked_lv8);
      }); 
      }break;
      case 5:{
      if(rate > rate_lv5){
        prefs.setInt('rate_lv5',rate);
      }
      
      prefs.setBool('is_locked_lv6',false);
      setState((){
        if(rate > rate_lv5){
          rate_lv5=rate;
        }
        is_locked_lv6 = false;
        level_select_data = GenerateLevelSelectData(
        rate_lv1:rate_lv1,rate_lv2:rate_lv2,rate_lv3:rate_lv3,rate_lv4:rate_lv4,rate_lv5:rate_lv5,rate_lv6:rate_lv6,
        rate_lv7:rate_lv7,rate_lv8:rate_lv8,is_locked_lv2:is_locked_lv2,is_locked_lv3:is_locked_lv3,is_locked_lv4:is_locked_lv4,
        is_locked_lv5:is_locked_lv5,is_locked_lv6:is_locked_lv6,is_locked_lv7:is_locked_lv7,is_locked_lv8:is_locked_lv8);

      });  
      }break;
      case 6:{
      if(rate > rate_lv6){
        prefs.setInt('rate_lv6',rate);
      }
      
      prefs.setBool('is_locked_lv7',false); 
      setState((){
        if(rate > rate_lv6){
          rate_lv6=rate;
        }
        is_locked_lv7 = false;
        level_select_data = GenerateLevelSelectData(
        rate_lv1:rate_lv1,rate_lv2:rate_lv2,rate_lv3:rate_lv3,rate_lv4:rate_lv4,rate_lv5:rate_lv5,rate_lv6:rate_lv6,
        rate_lv7:rate_lv7,rate_lv8:rate_lv8,is_locked_lv2:is_locked_lv2,is_locked_lv3:is_locked_lv3,is_locked_lv4:is_locked_lv4,
        is_locked_lv5:is_locked_lv5,is_locked_lv6:is_locked_lv6,is_locked_lv7:is_locked_lv7,is_locked_lv8:is_locked_lv8);
      }); 
      }break;
      case 7:{
        if(rate > rate_lv7){
          prefs.setInt('rate_lv7',rate);
        }
      
      prefs.setBool('is_locked_lv8',false);  
      setState((){
        rate_lv7=rate;
        is_locked_lv8 = false;
        level_select_data = GenerateLevelSelectData(
        rate_lv1:rate_lv1,rate_lv2:rate_lv2,rate_lv3:rate_lv3,rate_lv4:rate_lv4,rate_lv5:rate_lv5,rate_lv6:rate_lv6,
        rate_lv7:rate_lv7,rate_lv8:rate_lv8,is_locked_lv2:is_locked_lv2,is_locked_lv3:is_locked_lv3,is_locked_lv4:is_locked_lv4,
        is_locked_lv5:is_locked_lv5,is_locked_lv6:is_locked_lv6,is_locked_lv7:is_locked_lv7,is_locked_lv8:is_locked_lv8);

      }); 
      }break;
      case 8:{
      if (rate>rate_lv8){
        prefs.setInt('rate_lv8',rate);
      }
      
      setState((){
        if(rate > rate_lv8){
          rate_lv8=rate;
        }
        
        level_select_data = GenerateLevelSelectData(
        rate_lv1:rate_lv1,rate_lv2:rate_lv2,rate_lv3:rate_lv3,rate_lv4:rate_lv4,rate_lv5:rate_lv5,rate_lv6:rate_lv6,
        rate_lv7:rate_lv7,rate_lv8:rate_lv8,is_locked_lv2:is_locked_lv2,is_locked_lv3:is_locked_lv3,is_locked_lv4:is_locked_lv4,
        is_locked_lv5:is_locked_lv5,is_locked_lv6:is_locked_lv6,is_locked_lv7:is_locked_lv7,is_locked_lv8:is_locked_lv8);

      });
      }break;
    }


  }

  Map checkAnswer(qa){
    Map map = qa;
    Map map2 = new Map();
    Map map3 = new Map();
    map.forEach((k, v) {
      map2[k] = v.answer;
    } );
    map2.forEach((k,v) {
      for(var i=0;i < v.length;i++ ){
        map3[k[i]]=v[i].toUpperCase();
      }
    });
  return map3;
  }

  Map currentAnswer(qa){
    Map map = qa;
    Map map2 = new Map();
    Map map3 = new Map();
    map.forEach((k, v) {
      map2[k] = v.answer;
    } );
    map2.forEach((k,v) {
      for(var i=0;i < v.length;i++ ){
        map3[k[i]]='';
      }
    });
  return map3;
  }



  letterCell(context,{int grid_size,int index,int selected_index}){
    Color border_color;
    Color primary_color = Colors.white;
    bool is_disabled = true;
    String qid = '';
    String temp_question = '';
    String current_letter = '';

    for(var cell in input_cell){
      if(cell.contains(index)){
        try{
          is_disabled = false;
          if (index == qa[cell].qid){
            qid = (qa[cell].id).toString();
            temp_question = (qa[cell].question);
            break;
          }
        }catch(e){
          print(e);
        }
      }
    }
    if(selected_index == index){
      border_color = Colors.orange;
      primary_color = Color(0xFAFAD2.toInt()).withOpacity(1);
      border_width = selected_border_width;
      setState((){
        question = temp_question;
      });
    }
    else{
      border_color = Colors.black;
    }
    if(mapEquals(current_answer_dict,correct_answer_dict)){
      is_game_done = true;
      is_win = true;
    }
    if (is_crossword_checking){
      if(!is_disabled){
            if (current_answer_dict[index].toUpperCase() == correct_answer_dict[index].toUpperCase() && correct_answer_dict[index] != ''){
              border_color = Colors.green;
              primary_color = Color(0xC4F1BC.toInt()).withOpacity(1);
              border_width = selected_border_width;
            }
            else if(current_answer_dict[index].toUpperCase() != correct_answer_dict[index].toUpperCase() && correct_answer_dict[index] != ''){
              border_color = Colors.red;
              primary_color = Color(0xF09595.toInt()).withOpacity(1);
              border_width = selected_border_width;
            }
      }
    }
    current_answer_dict.forEach((k,v){
      if(index == k){
          current_letter = v.toUpperCase();
      }
    });

    if(is_hint){
      print('is_hint');
      print(selected_index);
      print(correct_answer_dict[selected_index]);
      current_answer_dict[selected_index] = correct_answer_dict[selected_index];
      is_hint = false;
    }



    return GestureDetector(
    onDoubleTap:(){
      setState((){
        is_hor=!is_hor;
        Toast.show(is_hor?"HORIZONTAL":"VERTICAL", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
      });
    },
    onTap:(){
      setState((){
        is_crossword_checking = false;
        if(checkInputCell(input_cell,index)){
          current_selected_index = index;
        }
      });
    },
    child: Container(
          height: (MediaQuery.of(context).size.width-10) / grid_size,
          width: (MediaQuery.of(context).size.width-10) / grid_size,
          decoration:
              BoxDecoration(
                color: !is_disabled ? primary_color : random_color,
                border: Border.all(
                  color: border_color,
                  width: border_width,
                  )
              ),
          child:Stack(
            children: [
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1),
              child: Text('$qid',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0
              )
              ),
            ),
            Container(
              width:(MediaQuery.of(context).size.width-10) / grid_size,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text(!is_disabled ?'$current_letter' : '',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0
                )
              )],)
            )

            ],)
          // child: Text('$index')
        ),
      );
  }

  generateMatrix(context,grid_size,{selected_index}){
    List<Widget> rows = [];
    int adder = 0;
    for (int i = 1; i <= grid_size; i++){
      rows.add(Row(children: generateRow(context,grid_size,adder:adder,selected_index:selected_index)));
      adder += grid_size;
    }
    return rows;
  }

  generateRow(context,grid_size,{adder:0,selected_index}){

    List<Widget> cells = [];
    for (int i = 1; i <= grid_size;i++){
      cells.add(letterCell(context,grid_size:grid_size,index:i + adder,selected_index:selected_index));
    }
    return cells;
  }
  
  
  Function onTextInput(String text){
    if(text != ''){
    setState((){
      if(is_hor){
        current_answer_dict[current_selected_index] = text.toUpperCase();
        if(current_selected_index < last_index_hor ){
          current_selected_index = moveRightCondition(current_selected_index,input_cell);
        }
        else{
          current_selected_index = first_index;
        }
      }else{
        current_answer_dict[current_selected_index] = text.toUpperCase();
        int last_index = current_grid_size * current_grid_size;
        current_selected_index = moveDownCondition(current_selected_index,input_cell,last_index,current_grid_size);
      }
      });
    }
  }
  



  @override
  Widget build(BuildContext context) {
    
    level_select_data = GenerateLevelSelectData(
    rate_lv1:rate_lv1,rate_lv2:rate_lv2,rate_lv3:rate_lv3,rate_lv4:rate_lv4,rate_lv5:rate_lv5,rate_lv6:rate_lv6,
    rate_lv7:rate_lv7,rate_lv8:rate_lv8,is_locked_lv2:is_locked_lv2,is_locked_lv3:is_locked_lv3,is_locked_lv4:is_locked_lv4,
    is_locked_lv5:is_locked_lv5,is_locked_lv6:is_locked_lv6,is_locked_lv7:is_locked_lv7,is_locked_lv8:is_locked_lv8);

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LevelSelectScreen(level_select_data: level_select_data),),
                                  );
                      },

                      child: Icon(Icons.home_outlined,
                      color:Colors.white,
                      ),
                    ),
                    SizedBox(width:7.0),

                    Text(widget.title.toUpperCase(),
                    style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3
                    )
                    ),
                  ],
                ),
                Row(
                    children: [
                    Icon(Icons.hourglass_empty,color:Colors.white),
                    !is_game_done?
                    Countdown(
                    controller: _controller,
                    seconds:seconds,
                    build: (BuildContext context, double time) { 
                      current_time = time.toInt();
                      return Text(time.toString(),
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              decorationColor: Colors.red,
                              color:Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                              height: 1.3
                            )
                      );
                    },
                    interval: Duration(seconds:1),
                    onFinished:(){
                      setState((){
                        is_game_done = true;
                        is_win = false;
                      });
                      print('Timer is done!');
                    }
                  ):Text('0',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              decorationColor: Colors.red,
                              color:Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                              height: 1.3
                            )
                  )
                  
                  ,]
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleButton(
                      onTap: (){
                        setState((){
                          is_hor = !is_hor;
                          Toast.show(is_hor?"HORIZONTAL":"VERTICAL", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                        });
                      },
                      child: is_hor ?Icon(Icons.arrow_forward,color:Colors.black):Icon(Icons.arrow_downward,color:Colors.black)
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    CircleButton(
                      onTap: (){
                        setState((){
                          is_crossword_checking = true;
                        });
                      },
                      child: Icon(Icons.check,color:Colors.black)
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    CircleButton(
                      onTap: (){
                        setState((){
                          if(hint_count > 0){
                            is_hint =true;
                            SavePowerupCount(
                              cur_hint_count : hint_count,
                              hint_count_loss : 1,
                              cur_time_restart_count : time_restart_count,
                              time_restart_count_loss: 0,
                            );
                          }else{
                            Toast.show("No more hint powerup", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                          }

                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.lightbulb,color:Colors.black,size:15.0),
                          Text('$hint_count',
                            textAlign:TextAlign.center,
                            style:TextStyle(
                              color:Colors.black,
                              fontSize:15.0,
                              fontWeight:FontWeight.bold,
                            )
                          )
                          ]
                        ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    CircleButton(
                      onTap: (){
                        setState((){
                          if(time_restart_count > 0){
                          _controller.restart();
                          SavePowerupCount(
                            cur_hint_count : hint_count,
                            hint_count_loss : 0,
                            cur_time_restart_count : time_restart_count,
                            time_restart_count_loss: 1,
                          );
                        }else{
                          Toast.show("No more time restart powerup", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                        }
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.timelapse,color:Colors.black,size:15.0),
                          Text('$time_restart_count',
                            textAlign:TextAlign.center,
                            style:TextStyle(
                              color:Colors.black,
                              fontSize:15.0,
                              fontWeight:FontWeight.bold,
                            )
                          )
                          ]
                        ),
                    ),
                  ],
                ),
              ],
            ), backgroundColor: Colors.black45),
        body:!is_game_done ? Column(
              children: [
              RawKeyboardListener(
              focusNode: FocusNode(),
              autofocus: true,
              onKey:(RawKeyEvent event){
                setState((){
                if(is_hor){
                  if (event.isKeyPressed(LogicalKeyboardKey.backspace)){
                    current_answer_dict[current_selected_index]='';
                    if(current_selected_index > first_index){
                      current_selected_index= moveLeftCondition(current_selected_index,input_cell);
                    }
                  }
                  else if(event.runtimeType == RawKeyDownEvent){
                    current_answer_dict[current_selected_index] = event.logicalKey.keyLabel.toString().toUpperCase();
                    if(current_selected_index < last_index_hor ){
                      current_selected_index = moveRightCondition(current_selected_index,input_cell);
                    }
                    else{
                      current_selected_index = first_index;
                    }
                  }
                }else{
                  if (event.isKeyPressed(LogicalKeyboardKey.backspace)){
                    current_answer_dict[current_selected_index]='';
                    int last_index = current_grid_size * current_grid_size;
                    current_selected_index = moveUpCondition(current_selected_index,input_cell,last_index,current_grid_size);
                  }
                  else  if(event.runtimeType == RawKeyDownEvent){
                    current_answer_dict[current_selected_index] = event.logicalKey.keyLabel.toString().toUpperCase();
                    int last_index = current_grid_size * current_grid_size;
                    current_selected_index = moveDownCondition(current_selected_index,input_cell,last_index,current_grid_size);
                  }
                }
                });
                
              },
              child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.0,horizontal:5.0),
              child: Column(
                children: generateMatrix(context,current_grid_size,selected_index: current_selected_index),
              )
            ),
          ),
          Expanded(
              flex:1,
              child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 3,
                    blurRadius: 0,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              alignment:Alignment.center,
              padding:EdgeInsets.symmetric(horizontal:2.0),
              height: 15.0,
              width: MediaQuery.of(context).size.width/1.3,
              child:Text(question.toUpperCase(),
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2
                  )
                  ),
            ),
          ),
          Container(
            height: 20.0
          ),
          CustomKeyboard(
            onTextInput:(String text){onTextInput(text);},
            )
          
        ],
        )
        :!is_win ? ResultsDisplay(
          init:(){},
          level_select_data:level_select_data,
          level_data: widget.level_data,
          title:widget.title,
          restart_button_on_tap:(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LevelScreen(level_data:widget.level_data,title:widget.title)),
          );},
          home_button_on_tap:(){
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LevelSelectScreen(level_select_data: level_select_data),),
            );
          },
          child: Text('game over'.toUpperCase(),
            textAlign:TextAlign.center,
            style: TextStyle(
              fontFamily:'Scramble',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2
            )
        ),)
        :ResultsDisplay(
          init:SaveScore(
          cur_score:score,
          score_gain: ((current_time /(seconds.toInt() / 5).toInt()).toInt() *60) * id),
          level_select_data:level_select_data,
          level_data: widget.level_data,
          title:widget.title,
          restart_button_on_tap:(){
          SaveLevelSelectPrefsData(id, (current_time /(seconds.toInt() / 5).toInt()).toInt());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LevelScreen(level_data:widget.level_data,title:widget.title)),
          );},
          home_button_on_tap:(){
          SaveLevelSelectPrefsData(id, (current_time /(seconds.toInt() / 5).toInt()).toInt());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>LevelSelectScreen(level_select_data: level_select_data),),
            );
          },
          child: Column(
            children: [Text('You Win! Gained  '+(((current_time /(seconds.toInt() / 5).toInt()).toInt() *60) * id).toString()+' points',
              textAlign:TextAlign.center,
              style: TextStyle(
                fontFamily:'Scramble',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2
              )
        ),
          StarDisplayWidget(  value: (current_time /(seconds.toInt() / 5).toInt()).toInt(),
          filledStar: Icon(Icons.star, color: Colors.yellow, size: 32),
          unfilledStar: Icon(Icons.star, color: Colors.grey),)
        ]
          ),)


        )
        
        
        ;
  }
}

