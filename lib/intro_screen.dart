import 'package:flutter/material.dart';
import 'package:my_flutter_project/main.dart';

class IntroScreen extends StatelessWidget{
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              //Text box
              const Align(
                alignment: Alignment(0.0, -0.9),
                child: Text(
                  'The Art Of Having An',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 55,
                    color: Color(0xff000000),
                  ),
                ),
              ),
               //Button
               Align(
                alignment:  const Alignment(0, 0.5),
                child:  MaterialButton(
                  color:  const Color(0xff3a21d9),
                  elevation: 0,
                  shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),),
                  textColor:  const Color(0xfffffdfd),
                  height: 80,
                  minWidth: 200,
                  padding:  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => const MyFlutterApp())
                    );
                  },
                  child:  const Text(
                    "Let's go",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              //Picture
              const Align(
                alignment: Alignment(0, -0.68),
                child:
                Image(
                  image: AssetImage('interview_2.jpg'),
                  height: 130,
                  width: 600,
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment(0, -0.2),
                child:
                Image(
                  image: AssetImage('interview_1.png'),
                  height: 200,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}