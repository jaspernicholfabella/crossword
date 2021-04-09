import 'package:flutter/material.dart';


class ResultsDisplay extends StatelessWidget {
  const ResultsDisplay({
    Key key,
    @required this.child,
    this.level_select_data,
    this.level_data,
    this.title,
    this.home_button_on_tap,
    this.restart_button_on_tap,
    this.init,
  }) : super(key: key);

  final Widget child;
  final level_data;
  final level_select_data;
  final String title;
  final home_button_on_tap;
  final restart_button_on_tap;
  final init;

  @override
  void initState(){
    init;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          Container(
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
            height:MediaQuery.of(context).size.height/2,
            width:MediaQuery.of(context).size.width/2,
            child:
            Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  Container(
                    child: child
                  ),
              SizedBox(
                height:13.0
              ),
              Container(
                width:double.infinity,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      padding:EdgeInsets.all(16.0),
                      shape: CircleBorder(), 
                      primary: Colors.blueGrey
                    ),
                    onPressed: restart_button_on_tap,
                    child:Icon(Icons.replay)
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      padding:EdgeInsets.all(16.0),
                      shape: CircleBorder(), 
                      primary: Colors.blueGrey
                    ),
                    onPressed: home_button_on_tap,
                    child:Icon(Icons.home)
                  ),

                ],),
              )
              
            ]
            ),
          ),

        ],),
    );
  }
}
