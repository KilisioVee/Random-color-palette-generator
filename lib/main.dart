import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_utils/flutter_color_utils.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  Color mix=Colors.green;
  @override
  void initState() {
    super.initState();

    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
      setState(() {
          mix= ColorUtils.mixColors(colorList);

        });
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(mix.toString()!=null?mix.toString():"shaked"),
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
void mixColors(){
  setState(() {
    mix= ColorUtils.mixColors(colorList);

  });

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
              : SingleChildScrollView(
            child: Column(

              children: [
                Container(
                  height: 400,
                  child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 5.0,
                      children: List.generate(colorList.length, (index) {

                        return
                          Center(
                            child:  InkWell(
                              onTap: () {
                                ColorPicker(
                                  pickerColor: colorList[index], //default color
                                  onColorChanged: (Color color){
                                    setState(() {
                                      colorList[index]=color;
                                    });

                                    print(color);
                                  },
                                );

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),

                                child:
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                            title: Text('Pick a color!'),
                                            content: SingleChildScrollView(
                                              child: ColorPicker(
                                                pickerColor:  colorList[index], //default color
                                                onColorChanged: (Color color){ //on color picked
                                                  setState(() {
                                                    colorList[index] = color;
                                                  });
                                                },
                                              ),
                                            ),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: const Text('DONE'),
                                                onPressed: () {
                                                  Navigator.of(context).pop(); //dismiss the color picker
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                    );

                                  },
                                  child: Card(
elevation: 2,
                                      color: colorList[index],
                                      child: Center(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
 ]
                                      ),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          );




                      }
                      )),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5),

                    child: Container(
                      width: 300,
                      child: ButtonTheme(
                        height: 40,


                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            child: Text('Generate Palette ', style: TextStyle(color: Colors.white, fontSize: 15)),

                            onPressed: () =>
                            {
                            mixColors()
                            }


                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  child: Center(child: Text("Result",style: TextStyle(color: Colors.white, fontSize: 15))),
                  height: 120,
                  width:300,
                  color: mix,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(5),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5),

                    child: Container(
                      width: 300,
                      child: ButtonTheme(
                        height: 40,


                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.all(20)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14, color: Colors.white))),
                            child: Text('Click to copy to clip board ', style: TextStyle(color: Colors.white, fontSize: 15)),

                            onPressed: () =>
                            {
                            Clipboard.setData(new ClipboardData(text: mix.toString()))
                                .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(mix.toString()+' Copied to your clipboard !')));
                            })
                            }


                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )



      ),
    );
  }
}
