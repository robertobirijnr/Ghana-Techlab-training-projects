
import 'package:flutter/material.dart';



void main()=> runApp(CalcApp());


class CalcApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor){


    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: btncolor, //background color of button

            elevation: 3, //elevation of button
            shape: RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.all(20) //content padding inside button
        ),
        onPressed: (){
            // calculation(btntxt);
          print("you clicked me")
        },
        child: Text(btntxt,
        style: TextStyle(
          fontSize: 35,
          color: txtcolor
        ),),
       
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(title: Text("CodeBooth Calculator"), backgroundColor: Colors.amber,),
        body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                //Calculator display
              //Role One
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.all(10.0),
                  // child: Text(text,
                  child: Text('0',
                  textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,
                    fontSize: 100
                    ),
                  ),
                  )
                ],
              ),
              
              //Row two
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //here operation button here
                  calcbutton("AC", Colors.grey, Colors.black),
                  //copy and past the above
                  calcbutton("+/-", Colors.grey, Colors.black),
                  calcbutton("%", Colors.grey, Colors.black),
                  calcbutton("/", Colors.amber, Colors.white)
                ],
              ),
              SizedBox(height: 10,),

              // Next Row

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //here operation button here
                  calcbutton("7", Colors.grey, Colors.black),
                  //copy and past the above
                  calcbutton("8", Colors.grey, Colors.black),
                  calcbutton("9", Colors.grey, Colors.black),
                  calcbutton("x", Colors.amber, Colors.white)
                ],
              ),
              SizedBox(height: 10,),

              //Next Row

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //here operation button here
                  calcbutton("4", Colors.grey, Colors.black),
                  //copy and past the above
                  calcbutton("5", Colors.grey, Colors.black),
                  calcbutton("6", Colors.grey, Colors.black),
                  calcbutton("-", Colors.amber, Colors.white)
                ],
              ),
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //here operation button here
                  calcbutton("1", Colors.grey, Colors.black),
                  //copy and past the above
                  calcbutton("2", Colors.grey, Colors.black),
                  calcbutton("3", Colors.grey, Colors.black),
                  calcbutton("+", Colors.amber, Colors.white)
                ],
              ),
              SizedBox(height: 10,),

              //Next Row is a bit different from the rest

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //This is button 0
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber, //background color of button
                        side: BorderSide(width:3, color:Colors.brown), //border width and color
                        elevation: 3, //elevation of button
                      shape: StadiumBorder(),
                      padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                    ),

                    onPressed: (){
                     calculation('0');
                    },

                    child: Text("0",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white
                      ),),

                  ),
                  calcbutton(".", Colors.grey, Colors.white),
                  calcbutton("=", Colors.amber, Colors.white)
                ],
              ),

              SizedBox(height:10)
            ],
          ),
    ),
    );
  }

  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}

