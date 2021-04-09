import 'package:flutter/material.dart';
import '../models/level_model.dart';
import '../models/qa.dart';
import 'input_cell.dart';


final List<LevelModel> level_data = [

//Level 8
LevelModel(
  first_index: 5,
  last_index_hor : 138,
  current_grid_size: 12,
  input_cell:l8,
  time:300,
  qa: <List,QA>{
    l8[0]: QA(id:1,qid:61,question: 'H: The resistance to motion of one object moving relative to another \nV: A push or pull that acts upon an object ',answer:'friction'),
    l8[1]: QA(id:2,qid:5,question:'V: The force acting on an object due to gravity',answer:'weight'),
    l8[2]: QA(id:3,qid:8,question: 'V: Any substance that cannot be decomposed into simpler substances by ordinary chemical processes', answer: 'element'),
    l8[3]: QA(id:4, qid:31, question: 'H: The unit of force', answer: 'newton'),
    l8[4]: QA(id:5, qid:23, question: 'V: A unit of mass', answer: 'pound'),
    l8[5]: QA(id:6, qid:39, question: 'V: A 3-dimensional shape with two identical faces reflecting light in a special way', answer: 'prism'),
    l8[6]: QA(id:7, qid:61, question: 'A push or pull that acts upon an object', answer: 'force'),
    l8[7]: QA(id:8, qid: 87, question: 'H: The amount of matter in an object', answer: 'mass'),
    l8[8]: QA(id:9, qid:90, question: 'V: A sample of matter that retains its shape and density when not confined.', answer: 'solid'),
    l8[9]: QA(id:10, qid:125, question: 'H: A state of matter that has the ability to flow and fill taking the shape of the container', answer: 'liquid'),
  },
),
//Level 7
LevelModel(
  first_index: 8,
  last_index_hor : 167,
  current_grid_size: 13,
  input_cell:l7,
  time:300,
  qa: <List,QA>{
    l7[0]: QA(id:1,qid:27,question: 'H: The capital of Sri Lanka \nV: The capital of Egypt',answer:'colombo'),
    l7[1]: QA(id:2,qid:27,question:'The capital of Egypt',answer:'cairo'),
    l7[2]: QA(id:3,qid:53,question: 'H: A small country in Western Europe', answer: 'luxembourg'),
    l7[3]: QA(id:4, qid:92, question: 'H: The Capital of China', answer: 'beijing'),
    l7[4]: QA(id:5, qid:9, question: 'V: The Coldest continent', answer: 'antarctica'),
    l7[5]: QA(id:6, qid:8, question: 'H: The capital of France', answer: 'paris'),
    l7[6]: QA(id:7, qid:35, question: 'H: The capital of Japan', answer: 'tokyo'),
    l7[7]: QA(id:8, qid:160, question: 'H: The capital of Australia', answer: 'canberra'),
    l7[8]: QA(id:9, qid:123, question: 'H: The capital of Canada', answer: 'ottawa'),
    l7[9]: QA(id:10, qid:128, question: 'V: The largest continent ', answer: 'asia'),

  },
),

//Level 6
LevelModel(
  first_index: 3,
  last_index_hor : 173,
  current_grid_size: 15,
  input_cell:l6,
  time:400,
  qa: <List,QA>{
    l6[0]: QA(id:1,qid:91,question:'Who was the first president of the Third Republic of the Philippines',answer:'emilioaguinaldo'),
    l6[1]: QA(id:2,qid:3,question:'Which religion is widely practiced in Philippines',answer:'christianity'),
    l6[2]: QA(id:3,qid:9,question: 'The Walled City', answer: 'intramuros'),
    l6[3]: QA(id:4, qid:20, question: 'Which country occupied the Philippines during World War I', answer: 'japan'),
    l6[4]: QA(id:5, qid:57, question: 'Mayon Volcano is located in which province', answer: 'albay'),
    l6[5]: QA(id:6, qid:90, question: 'Which of the following sports inventions is credited to Pedro Flores', answer: 'yoyo'),
    l6[6]: QA(id:7, qid:68, question: 'What is the Capital of the Philippines', answer: 'manila'),
    l6[7]: QA(id:8, qid: 51, question: 'What is the currency of Philippines', answer: 'peso'),
    l6[8]: QA(id:9, qid:136, question: 'Which severe typhoon struck Philippines in 2013?', answer: 'haiyan'),
  },
),

//Level 5
LevelModel(
  first_index: 11,
  last_index_hor : 195,
  current_grid_size: 15,
  input_cell:l5,
  time:500,
  qa: <List,QA>{
    l5[0]: QA(id:1,qid:22,question:'The supreme and absolute authority within territorial boundaries',answer:'sovereignty'),
    l5[1]: QA(id:2,qid:33,question:'Controlling all aspects of citizens economic, political, and social lives',answer:'authoritarian'),
    l5[2]: QA(id:3, qid:15, question: 'A plan that provides the rules for government ', answer: 'constitution'),
    l5[3]: QA(id:4, qid:13, question: 'a system of government in which a small group holds power', answer: 'oligarchy'),
    l5[4]: QA(id:5, qid:11, question: 'A state without government and laws', answer: 'anarchy'),
    l5[5]: QA(id:6, qid:31, question: 'A loose union of independent states ', answer: 'confederacy'),
    l5[6]: QA(id:7, qid:166, question: 'A political community that occupies a definite territory and has an organized government', answer: 'country'),
    l5[7]: QA(id:8, qid: 80, question: 'A political community that occupies a definite territory and has an organized government', answer: 'state'),
    l5[8]: QA(id:9, qid:109, question: 'A group of people united by bonds of race, language, custom, tradition, and sometimes religion', answer: 'nation'),

  },
),
//Level 4
LevelModel(
  first_index: 5,
  last_index_hor : 217,
  current_grid_size: 15,
  input_cell:l4,
  time:500,
  qa: <List,QA>{
    l4[0]: QA(id:1,qid:199,question:'Machine that allows you to run whilst staying in the same place ',answer:'treadmill'),
    l4[1]: QA(id:2,qid:157,question:'What you win if you come 1st, 2nd or 3rd in a race ',answer:'medal'),
    l4[2]: QA(id:3, qid:114, question: 'Used in hockey to pass the ball ', answer: 'stick'),
    l4[3]: QA(id:4, qid:126, question: 'An assistant to a sports announcer who helps identify the players for the announcer', answer: 'spotter'),
    l4[4]: QA(id:5, qid:71, question: 'In which sport might you do a lay-up?', answer: 'basketball'),
    l4[5]: QA(id:6, qid:101, question: 'How you start a game of badminton, volleyball and table tennis', answer: 'serve'),
    l4[6]: QA(id:7, qid:104, question: 'A skill in volleyball', answer: 'volley'),
    l4[7]: QA(id:8, qid:31, question: 'Most important skill in dodgeball ', answer: 'catching'),
    l4[8]: QA(id:9, qid:31, question: 'Name a sport that takes place in a velodrome', answer: 'cycling'),
    l4[9]: QA(id:10, qid:5, question: 'Which sport would you find backstroke and butterfly?', answer: 'swimming'),
  },
),

//Level 3
LevelModel(
  first_index: 20,
  last_index_hor : 209,
  current_grid_size: 15,
  input_cell:l3,
  time:600,
  qa: <List,QA>{
    l3[0]: QA(id:1,qid:76,question:'Data expressed as a series of 1s and 0s electronically',answer:'digital'),
    l3[1]: QA(id:2,qid:67,question:'A flexible, removable, magnetic, memory disk',answer:'floppydisk'),
    l3[2]: QA(id:3, qid:202, question: 'An input device used on laptops and desktops', answer: 'keyboard'),
    l3[3]: QA(id:4, qid:172, question: 'A device which lets you interact with the computer', answer: 'interface'),
    l3[4]: QA(id:5, qid:77, question: 'To provide or give something to the computer', answer: 'input'),
    l3[5]: QA(id:6, qid:20, question: 'An input device that is a column used for control', answer: 'joystick'),
    l3[6]: QA(id:7, qid:97, question: 'A digital information a computer gives or produces', answer: 'output'),
    l3[7]: QA(id:8, qid:57, question: 'It helps you connect multiple devices to the internet and connect to each other', answer: 'router'),
    l3[8]: QA(id:9, qid:130, question: 'To place documents in a particular order ', answer: 'file'),
    l3[9]: QA(id:10, qid:144, question: 'Smallest unit a computer can work with', answer: 'bit'),
  },
),

//Level 2
LevelModel(
  first_index: 5,
  last_index_hor : 209,
  current_grid_size: 15,
  input_cell:l2,
  time:600,
  qa: <List,QA>{
    l2[0]: QA(id:1,qid:181,question:'The comparative degree of the word clever',answer:'cleverer'),
    l2[1]: QA(id:2,qid:123,question:'What type of noun is Villa Isabel?',answer:'proper'),
    l2[2]: QA(id:3, qid:155, question: 'A type of word giving directions', answer: 'preposition'),
    l2[3]: QA(id:4, qid:204, question: 'Superlative of the word wise', answer: 'wisest'),
    l2[4]: QA(id:5, qid:87, question: 'A word describing a noun and a pronoun', answer: 'adjective'),
    l2[5]: QA(id:6, qid:135, question: 'Past tense of the word ring', answer: 'rang'),
    l2[6]: QA(id:7, qid:9, question: 'A word that shows emotion', answer: 'interjection'),
    l2[7]: QA(id:8, qid:5, question: 'Plural of library', answer: 'libraries'),
    l2[8]: QA(id:9, qid:65, question: 'A word describing a verb', answer: 'adverb'),
    l2[9]: QA(id:10, qid:78, question: 'An adverb used to measure a period of time', answer: 'for'),
  },
),

//Level 1
LevelModel(
  first_index: 5,
  last_index_hor : 149,
  current_grid_size: 13,
  input_cell:l1,
  time: 600,
  qa: <List,QA>{
    l1[0]: QA(id:1,qid:53,question:'the first person to walk on the moon',answer:'armstrong'),
    l1[1]: QA(id:2,qid:5,question:'A meteor with a tail of ice',answer:'comet'),
    l1[2]: QA(id:3, qid:16, question: 'The satelite of Earth', answer: 'moon'),
    l1[3]: QA(id:4, qid:55, question: 'Our galaxy', answer: 'milkyway'),
    l1[4]: QA(id:5, qid:132, question: 'A planet with a ring', answer: 'saturn'),
    l1[5]: QA(id:6, qid:33, question: 'A flying object that is unknown', answer: 'ufo'),
    l1[6]: QA(id:7, qid:35, question: 'A motor vehicle with an open top', answer: 'buggies'),
    l1[7]: QA(id:8, qid:100, question: 'Our planet', answer: 'earth'),
    l1[8]: QA(id:9, qid:63, question: 'Dots of light we see in the night sky', answer: 'stars'),
    l1[9]: QA(id:10, qid:110, question: 'The red planet', answer: 'mars'),
  },
),

];