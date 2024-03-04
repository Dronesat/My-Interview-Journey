import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_flutter_project/end_screen.dart';
import 'package:my_flutter_project/intro_screen.dart';
import 'decision_map.dart';

//List to store decision map object in database
late Box<DecisionMap> box;

Future<void> main() async {
  //Hive database setup
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DecisionMapAdapter());
  box = await Hive.openBox<DecisionMap>('decisionMap');

  String csv = "decision_map.csv"; //path to csv file asset
  String fileData = await rootBundle.loadString(csv);
  List <String> rows = fileData.split("\n");
  for (int i = 0; i < rows.length; i++)  {
    //selects an item from row and places
    String row = rows[i];
    List <String> itemInRow = row.split(",");
    //Code to map item to the DecisionMap object
    DecisionMap decMap = DecisionMap(
        int.parse(itemInRow[0]),
        int.parse(itemInRow[1]),
        int.parse(itemInRow[2]),
        itemInRow[3],
        itemInRow[4]);
    int key = int.parse(itemInRow[0]);
    box.put(key,decMap);
  }
  runApp (const MaterialApp(home: MyFlutterApp(),),
  );
}

class MyFlutterApp extends StatefulWidget {
  const MyFlutterApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyFlutterState();
  }
}

class MyFlutterState extends State<MyFlutterApp>{
  //VARIABLE
  late int nodeID;
  late int yesID;
  late int noID;
  String description = "";
  String question = "";
  late int currentNodeID;

  void initState() {
    super.initState();
    //CODE INITIALISE SERVER OBJECTS
    currentNodeID = 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Code execute immediately after the UI is built
      display(currentNodeID);
      introScreen();
    });
  }
  void introScreen(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen())
    );
  }

  //Refresh content on screen
  void display(node){
    setState(() {
      DecisionMap? current = box.get(node);
      if(current != null) {
        yesID = current.yesID;
        noID = current.noID;
        if (current.description == '-'){
          description = '';
        } else {description = current.description;}
        if (current.question == '-'){
          question = '';
        } else {question = current.question;}
      }
    });
  }

  //Check if it is end node
  void checkEndNode(node){
    String message = description;
    if (yesID == 0 && noID == 0){
      currentNodeID = 1;
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EndScreen(
            message : message
          ))
      );
    }
  }

  //Event handler
  void btnYesHandler() {
    currentNodeID = yesID;
    checkEndNode(currentNodeID);
    display(currentNodeID);
  }
  void btnNoHandler(){
    currentNodeID = noID;
    checkEndNode(currentNodeID);
    display(currentNodeID);
  }
  void btnBackHandler(){
    currentNodeID = 1;
    display(currentNodeID);
    introScreen();
  }

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
              //Button Yes
              Align(
                alignment: const Alignment(-0.45, 0.5),
                child: MaterialButton(
                  onPressed: ( ) { btnYesHandler(); },
                  color: const Color(0xff3a21d9),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),),
                  textColor: const Color(0xfffffdfd),
                  height: 50,
                  minWidth: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              //Button NO
              Align(
                alignment: const Alignment(0.45, 0.5),
                child: MaterialButton(
                  onPressed: ( ) { btnNoHandler(); },
                  color: const Color(0xff3a21d9),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),),
                  textColor: const Color(0xfffffdfd),
                  height: 50,
                  minWidth: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "No",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              //Text box description
              Align(
                alignment: const Alignment(0.0, -0.8),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 34,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              //Text box question
              Align(
                alignment: const Alignment(0.0, -0.4),
                child: Text(
                  question,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 34,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              //Button back
              Align(
                alignment: const Alignment(-0.99, -0.99),
                child: MaterialButton(
                  onPressed: ( ) { btnBackHandler(); },
                  color: const Color(0xff3a21d9),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),),
                  textColor: const Color(0xfffffdfd),
                  height: 40,
                  minWidth: 140,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "Back",
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
