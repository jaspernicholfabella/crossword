import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomKeyboard extends StatefulWidget {
  CustomKeyboard({this.onTextInput,this.onBackSpace});
  final onTextInput;
  final onBackSpace;

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: Colors.grey,
      child: Column(
        children: [
          buildRowOne(),
          buildRowTwo(),
          buildRowThree(),
          buildRowFour()
        ],
      ),
    );
  }

  Expanded buildRowOne() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: 'Q',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'W',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'E',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'R',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'T',
            onTextInput: widget.onTextInput,
          ),
                    TextKey(
            text: 'Y',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'U',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'I',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'O',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'P',
            onTextInput: widget.onTextInput,
          ),
        ],
      ),
    );
  }

  Expanded buildRowTwo() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: 'A',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'S',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'D',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'F',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'G',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'H',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'J',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'K',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'L',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: '',
            onTextInput: widget.onTextInput,
          ),
        ],
      ),
    );
  }

  Expanded buildRowThree() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: '',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'Z',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'X',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'C',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'V',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'B',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'N',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: 'M',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: '',
            onTextInput: widget.onTextInput,
          ),
          TextKey(
            text: '',
            onTextInput: widget.onTextInput,
          ),
        ],
      ),
    );
  }



  Expanded buildRowFour() {
    return Expanded(
      child: Row(
        children: [
          TextKey(
            text: ' ',
            flex: 4,
            onTextInput: widget.onTextInput,
          ),
          BackSpaceKey(
            onBackSpace: widget.onBackSpace,
          ),
        ],
      ),
    );
  }
}




class TextKey extends StatefulWidget {
  TextKey({@required this.text,this.onTextInput,this.flex=1});

  final String text;
  final onTextInput;
  final int flex;

  @override
  _TextKeyState createState() => _TextKeyState();
}

class _TextKeyState extends State<TextKey> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.grey.shade300,
          child: InkWell(
            onTap: () {
              widget.onTextInput(widget.text);
            },
            child: Container(
              child: Center(child: Text(widget.text.toUpperCase())),
            ),
          ),
        ),
      ),
    );
  }
}





class BackSpaceKey extends StatefulWidget {
  BackSpaceKey({this.flex = 1,this.onBackSpace});
  final onBackSpace;
  final int flex;

  @override
  _BackSpaceKeyState createState() => _BackSpaceKeyState();
}

class _BackSpaceKeyState extends State<BackSpaceKey> {
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          color: Colors.grey.shade300,
          child: InkWell(
            onTap: () {
              LogicalKeyboardKey.backspace;
            },
            child: Container(
              child: Center(
                child: Icon(Icons.backspace),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

