import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:geopattern_flutter/geopattern_flutter.dart';
import 'package:geopattern_flutter/patterns/squares.dart';
import 'package:bordered_text/bordered_text.dart';
import 'level_select_screen.dart';
import '../data/levels_data.dart';
import '../data/level_select_data.dart';
import '../models/level_select_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoadingHomeScreen extends StatefulWidget {
  @override
  _LoadingHomeScreenState createState() => _LoadingHomeScreenState();
}

class _LoadingHomeScreenState extends State<LoadingHomeScreen> {
    bool is_locked_lv2;bool is_locked_lv3;bool is_locked_lv4;
    bool is_locked_lv5;bool is_locked_lv6;bool is_locked_lv7;
    bool is_locked_lv8;int rate_lv1;int rate_lv2;
    int rate_lv3;int rate_lv4;int rate_lv5;int rate_lv6;
    int rate_lv7;int rate_lv8;
    @override
    void initState() {
      ReadLevelSelectPrefsData();
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
  

  @override
  Widget build(BuildContext context) {
    List<LevelSelectModel> level_select_data = GenerateLevelSelectData(
    rate_lv1:rate_lv1,rate_lv2:rate_lv2,rate_lv3:rate_lv3,rate_lv4:rate_lv4,rate_lv5:rate_lv5,rate_lv6:rate_lv6,
    rate_lv7:rate_lv7,rate_lv8:rate_lv8,is_locked_lv2:is_locked_lv2,is_locked_lv3:is_locked_lv3,is_locked_lv4:is_locked_lv4,
    is_locked_lv5:is_locked_lv5,is_locked_lv6:is_locked_lv6,is_locked_lv7:is_locked_lv7,is_locked_lv8:is_locked_lv8);
    
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LevelSelectScreen(level_select_data: level_select_data),),
    );
    return Container(
      
    );
  }
}