import 'package:flutter/material.dart';
import 'package:my_flutter_project/main.dart';

class EndScreen extends StatelessWidget{
  const EndScreen({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              //Text box result message
               Align(
                alignment: const Alignment(0.0, -0.5),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 45,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              //Button play again
              Align(
                alignment:  const Alignment(0, 0),
                child:  MaterialButton(
                  color:  const Color(0xff3a21d9),
                  elevation: 0,
                  shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),),
                  textColor:  const Color(0xfffffdfd),
                  height: 60,
                  minWidth: 200,
                  padding:  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => const MyFlutterApp())
                    );
                  },
                  child:  const Text(
                    "Play Again",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}