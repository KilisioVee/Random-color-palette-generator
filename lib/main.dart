import 'package:flutter/material.dart';
import 'package:flutter_color_utils/flutter_color_utils.dart';
import 'package:shake/shake.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<MyHomePage> {
  List<Color> colorList = [Colors.lightBlue,Colors.black,Colors.white,Colors.red];
  var colorC;
  @override
  void initState() {
    super.initState();
    Color mix= ColorUtils.mixColors(colorList);
    print(mix.toString());
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("shaked"),
          ),
        );
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
         // getVehicleType(parttype??"");

        });
      },
      child: Scaffold(

          appBar: AppBar(
            title: const Text('Vehicle types (Tap to Tally)'),

          ),
          body: colorList.isEmpty
              ? const Center(child: const Text('You don\'t have any colors'))
              :  GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              children: List.generate(colorList.length, (index) {

                  return
                    Center(
                      child:  InkWell(
                        onTap: () {
                    /* Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddTodoScreen(
            todo: todo,
          );
        }));*/

                  },
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Card(
                  color: colorList[index],
                  child: Center(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[



                //  Expanded(child: Text((colorList[index]..toString() ) )),







                  ]
                  ),
                  )
                  ),
                ),
                ),
                    );




              }
              ))


      ),
    );
  }
}
