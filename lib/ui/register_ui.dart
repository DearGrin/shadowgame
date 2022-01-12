
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web/bloc/game_bloc.dart';
import 'package:web/bloc/login_bloc.dart';
import 'package:web/models/evnet_model.dart';
import 'package:web/models/player_model.dart';

class RegisterUI extends StatefulWidget{
  //final GameBloc gameBloc;
  final LoginBloc loginBloc;
  RegisterUI(this.loginBloc);
  @override
  State<StatefulWidget> createState() {
    return RegisterUIState();
  }
}

class RegisterUIState extends State<RegisterUI>{
  final _registerFormKey = GlobalKey<FormState>();
  final User _user = User();
  int page = 0;
  int isLoading = 0;
  String errorText = '';
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 400.0,
        width: 500.0,
        child: Card(
          semanticContainer: true,
          child: IndexedStack(
            index: isLoading,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50.0,
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FlatButton(
                            onPressed: (){ setState(() {
                              page = 0;
                            });},
                            child: Text(
                              'Войти',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            color: page==1? Colors.blue[600]: Colors.blue[300],
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: (){ setState(() {
                              page = 1;
                            });},
                            child: Text(
                              'Регистрация',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            color: page==0? Colors.blue[600]: Colors.blue[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.0),
                    child: Form(
                      key: _registerFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          page==1? TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Имя'
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: (value) {
                              if(value.isEmpty) {
                                return 'Пожалуйста, введите Ваше имя';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                setState(() => _user.name = value),
                          ) : Container(),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email'
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                            validator: (value) {
                              if(value.isEmpty) {
                                return 'Пожалуйста, введите Ваш email';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                setState(() => _user.email = value),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Пароль'
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
                            obscureText: true,
                            validator: (value) {
                              if(value.isEmpty) {
                                return 'Пожалуйста, придумайте пароль';
                              }
                              else if(value.length < 4)
                              {
                                return 'Пароль должен содержать минимум 4 символа';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value){page==0? login() : register();},
                            onSaved: (value) =>
                                setState(() => _user.password = value),

                          ),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    child: Text(
                      errorText,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: RaisedButton(
                            onPressed: page==0? login : register,
                            child: Text(
                              page==1? 'Зарегистрироваться': 'Войти',
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.blue[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    child: TextButton(
                    child: Text('авт контур'),
                      onPressed: (){widget.loginBloc.testGoogle();},
                    ),

                  ),
                ],
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],

          ),
        ),
      ),
    );
  }
  void register() async{
    final form = _registerFormKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        isLoading = 1;
      });
      PhpCallback callback = await widget.loginBloc.register(_user);
      if(callback.type==false)
      {
        setState(() {
          isLoading = 0;
          errorText = callback.message;
        });
      }
    }
  }
    void login() async{
      final form = _registerFormKey.currentState;
      if (form.validate()) {
        setState(() {
          isLoading = 1;
        });
        form.save();
        PhpCallback callback = await widget.loginBloc.logIn(_user.email, _user.password);
        if(callback.type==false)
          {
            setState(() {
              isLoading = 0;
              errorText = callback.message;
            });
          }
      }
    }
}