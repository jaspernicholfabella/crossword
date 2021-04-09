import '../models/level_select_model.dart';
import 'levels_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


List<LevelSelectModel> GenerateLevelSelectData({
  rate_lv1,rate_lv2,rate_lv3,rate_lv4,rate_lv5,rate_lv6,rate_lv7,rate_lv8,
  is_locked_lv2,is_locked_lv3,is_locked_lv4,is_locked_lv5,is_locked_lv6,is_locked_lv7,is_locked_lv8,

}){
  List<LevelSelectModel> level_select_data;

  return level_select_data = [
          LevelSelectModel(
            id: 1,
            title:'Level one',
            description:'space',
            level_data:level_data[7],
            rate:rate_lv1,
            is_locked:false,
          ),
          LevelSelectModel(
            id: 2,
            title:'Level two',
            description:'english',
            level_data:level_data[6],
            rate:rate_lv2,
            is_locked:is_locked_lv2,
          ),
          LevelSelectModel(
            id: 3,
            title:'Level three',
            description:'computer',
            level_data:level_data[5],
            rate:rate_lv3,
            is_locked: is_locked_lv3,
          ),
          LevelSelectModel(
            id: 4,
            title:'Level four',
            description:'Sports',
            level_data:level_data[4],
            rate:rate_lv4,
            is_locked: is_locked_lv4,
          ),
          LevelSelectModel(
            id: 5,
            title:'Level five',
            description:'law',
            level_data:level_data[3],
            rate:rate_lv5,
            is_locked: is_locked_lv5,
          ),
          LevelSelectModel(
            id: 6,
            title:'Level six',
            description:'PH',
            level_data:level_data[2],
            rate:rate_lv6,
            is_locked: is_locked_lv6,
          ),
          LevelSelectModel(
            id: 7,
            title: 'Level seven',
            description:'country',
            level_data:level_data[1],
            rate:rate_lv7,
            is_locked:is_locked_lv7,
          ),
          LevelSelectModel(
            id: 8,
            title:'Level eight',
            description:'Science',
            level_data:level_data[0],
            rate:rate_lv8,
            is_locked:is_locked_lv8,
          )
    ];
}



