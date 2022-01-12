import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:web/bloc/auth.dart';
import 'package:web/bloc/controller.dart';
import 'package:web/bloc/game_bloc.dart';
import 'package:web/extensios/jwt_convert.dart';
import 'package:web/screens/TestThree.dart';
import 'package:web/screens/TestTwo.dart';
import 'package:web/screens/game_layout.dart';
import 'package:web/ui/re_rules.dart';
import 'package:web/ui/register_ui.dart';
import 'package:web/extensios/router.dart';
import 'package:web/models/route_names.dart' as names;
import 'package:web/extensios/navigator_service.dart' as navigation;
import 'dart:html' as html;

Future<void> main() async {
  setPathUrlStrategy();
  Location currentLocation = html.window.location;
  var h = currentLocation.href;
  print('href ' + h);
  var pL = h.split('/');
  String p = pL[2];
  print(p);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('path', p);
  String id = 'none';
  if(h.contains('token'))
    {
      print('found jwt');
      final JWTConvert jwt = JWTConvert();
      id = jwt.convertJWT(h.substring(32));
      print('sub is: $id');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('sub', id);
    }
  //print('hash ' + currentLocation.hash);
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}
class MyAppState extends State<MyApp>{
  // This widget is the root of your application.
 // final GameBloc gameBloc = GameBloc();
  //final Controller controller = Controller();
  @override
  void initState() {
    // TODO: implement initState

   // gameBloc.addToStreamStatePage();

    /*
   html.window.addEventListener('beforeunload', (event) => (){
     print('Before');
     gameBloc.setReady(false);
   });
    html.window.addEventListener('unload', (event) => (){
      print('Unload');
      gameBloc.setReady(false);
    });

     */
/*
    html.window.onBeforeUnload.listen((event) async {
      // do something
      print('onDefore');
      doUnload();
      gameBloc.setReady(false);
    });
    html.window.onUnload.listen((event) async{
      // do something
      print('onUload');
      doUnload();
      gameBloc.setReady(false);
    });

 */


    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    //gameBloc.setReady(false);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shadows Game',
      debugShowCheckedModeBanner: false,
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
       // primarySwatch: Colors.blue,
        //cardColor: Color.fromARGB(75, 236, 237, 245),
        cardColor: Color.fromRGBO(125, 133, 188, 0.15),
        //cardColor: Color.fromARGB(185, 218, 198, 223),
        primaryColor: Color.fromARGB(255, 125, 133, 185),
        hintColor: Color.fromRGBO(187, 190, 225, 0.5), //new color for cards
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 125, 133, 185))),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Circe'),
          headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 125, 133, 185), fontFamily: 'Circe'),
          bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Circe'),
          bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 125, 133, 185), fontFamily: 'Circe'),
          headline3: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Circe',),
          subtitle1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 125, 133, 185), fontFamily: 'Circe'),
          subtitle2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal, color:Colors.white, fontFamily: 'Circe'),
        ),
      ),
      //home: ReRules(),

      builder: (context, child) => LayoutTemplate(
        child: child,
      ),
      navigatorKey: navigation.NavigationService().navigatorKey,
      onGenerateRoute:generateRoute,
      initialRoute: names.HomeRoute,




        //onGenerateRoute: router.generateRoute,
      //home: Background(),
       // home: LayoutTemplate(),
      //home: GameLayout(controller.masterBloc),
    );
  }
  void doUnload(){
    print('do unload');
    print(gameBloc.token);
   // gameBloc.setReady(false);
  }
}

class Background extends StatefulWidget{
  final String arguments;
  Background({this.arguments});
  @override
  State<StatefulWidget> createState() {
    return BackgroundState();
  }
}

class BackgroundState extends State<Background> {
  //Auth auth = Auth();
  final Controller controller = Controller();
  @override
  void initState() {
    // TODO: implement initState
    //gameBloc.liste('tokenfol3793fhkhhhhh');
    html.window.addEventListener("unload", (event) async{
      //print('event on unload');
     // _showDialog(context);
      for(var i = 0; i < 100000000; i++) {
        //print('onDefore ');
      }
      return null;
    });
   // auth.getPassport(); //todo auth for passport
  //  auth.tryOpenid();
  //  print('arguments ' + widget.arguments!=null? widget.arguments: 'null');
   // gameBloc.checkToken();
   // auth.testGoogle();
    //controller.checkToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),

              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 125, 133, 188),
                        Color.fromARGB(255, 234, 201, 223),
                      ]
                  )
              ),



              //color: Colors.lightGreen[200],
              //decoration: BoxDecoration(
                //color: Colors.white,
                /*
                image: DecorationImage(
                    image: AssetImage('assets/fon.jpg'), fit: BoxFit.cover),

              ),
              padding: constraints.maxWidth < 1000
                  ? EdgeInsets.zero
                  : EdgeInsets.all(30.0),
              */
              child: displayPage(constraints.maxWidth),
            );
          }
      ),
    );
  }
  Widget displayPage(double maxWidth){
    int _currentPage = 0;
    Widget rule;
    return StreamBuilder(
     //stream: gameBloc.statePage,
      stream: controller.statePage,
      //initialData: 0,
      builder: (context, AsyncSnapshot<int> snapshot){
        if(snapshot.hasData)
          {
            if (snapshot.data == 0) {
              return RegisterUI(controller.setLoginBloc());
             // return TestTwo();
            }
            else if (snapshot.data == 1) {
              if(_currentPage != 1) {
                _currentPage = 1;
                rule = ReRules(controller.setRulesBloc());
              }
              return rule;
              //return RulesUI(controller.setRulesBloc());

            }
            else if (snapshot.data == 2) {
              _currentPage = 2;
              return GameLayout(controller.masterBloc);
              //return GameUI(gameBloc, maxWidth);
            }
            else
              {
                return Container();
              }
          }
        else {
            controller.checkToken();
            return CircularProgressIndicator();
          }
      },
    );
  }
  _showDialog(context) {
    print('context');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Card(
            child: Container(
              width: 300,
              height: 300,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Недостаточно игроков онлайн',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      'Позовите друзей или попробуйте позже',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    RaisedButton(
                      child: Text('Ok', style: Theme.of(context).textTheme.bodyText1,),
                      color: Colors.blue[600],
                      onPressed: (){Navigator.of(context).pop();},
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}

