import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quiz_ui/data/questions_exam.dart';
import 'package:quiz_ui/screens/result_screen.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({Key? key}) : super(key: key);
  

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {

double _initial=0.0;
double  _initial1=0.0;
bool condition=false;

  


 
 Widget _stepIndicator(){
   return Column
   (
     children: 
   [
     
     LinearProgressIndicator(
       minHeight: 25.0,
       valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
       value: _initial,
       backgroundColor: Colors.white,
     ),
    
    ],);

 }

 Widget _step2Indicator(){
   return Column
   (
     children: 
   [
     
     LinearProgressIndicator(
       
       minHeight: 25.0,
       valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
       value: _initial1,
       backgroundColor: Colors.white,
       
     ),
    
    ],);

 }


  int question_pos = 0;
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;
  @override
  void initState() {
    
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: PageView.builder(
            controller: _controller!,
            onPageChanged: (page) {
              if (page == questions.length - 1) {
                setState(() {
                  btnText = "See Results";
                });
              }
              setState(() {
                answered = false;
              });
            },
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              
                children: [
                  _stepIndicator(),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Question ${index + 1}/20",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                   Text("Entertainment:Board Game", textAlign: TextAlign.center,style: TextStyle(
                        color: Colors.white,),),
                        RatingBar.builder
                      (
                        initialRating:2,
                        itemCount: 3,
                        itemSize: 28,
                        ignoreGestures: true,
                        unratedColor: Colors.white,
                  
                        itemBuilder: (context, _)=> Icon(Icons.star,color: Colors.yellowAccent,),
                        onRatingUpdate: (rating){},
                      ),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 130.0,
                    child: Text(
                      "${questions[index].question}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  for (int i = 0; i < questions[index].answers!.length; i++)
                    Container(
                      width: double.infinity,
                      height: 30.0,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 12.0, right: 12.0),
                      child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fillColor: btnPressed
                            ? questions[index].answers!.values.toList()[i]
                                ? Colors.green
                                : Colors.red
                                : Colors.white,
                        onPressed: !answered
                            ? () {
                                if (questions[index]
                                    .answers!
                                    .values
                                    .toList()[i]) {
                                  score++;
                                  print("yes");
                                } else {
                                  print("no");
                                }
                                setState(() {
                                  btnPressed = true;
                                  answered = true;
                                });
                              }
                            : null,
                        child: Text(questions[index].answers!.keys.toList()[i],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            )),
                      ),
                    ),
                  SizedBox(
                    height: 0.0,
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      if (_controller!.page?.toInt() == questions.length - 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultScreen(score)));
                      } else {
                        _controller!.nextPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInExpo);

                        setState(() {
                          btnPressed = false;
                           _initial=_initial+0.053;
                           
                           if(score.isOdd)
                           {
                            _initial1=_initial1+0.053;
                             Text("${score}");
                           }
                           else
                           {
                            _initial1=_initial1--;
                             
                           };
                          
                        });
                      }
                    },
                    shape: StadiumBorder(),
                    fillColor: Colors.grey,
                    padding: EdgeInsets.all(18.8),
                    elevation: 0.0,
                    child: Text(
                      btnText,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                      
                  ),
                  SizedBox(height: 5,),
                  Row(children: [
                    
                    Text("score: ${score}",style: TextStyle
                  (color: Colors.white,fontSize: 20.0,),),
                  SizedBox(width: 60.0,),
                  Text("max score: ${score/1}%",style: TextStyle
                  (color: Colors.white,fontSize: 20.0,),),
                    
                  ],
                    
                  ),
                    
                  
                  
                  SizedBox(height: 20,),
                  _step2Indicator()
                ],
              );
            },
            itemCount: questions.length,
          )),
    );
  }
}