import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  State createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
//        mainAxisSize: MainAxisSize.min,
          controller: _scrollController,
          reverse: true,
          children: <Widget>[
            new Container(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Iniciar Sesion',
                        style: Theme.of(context).textTheme.display1,
                      ),
                      GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(
                            0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Favor ingresar usuario';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Usuario/Email'
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(
                            0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Favor ingresar clave';
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Clave'
                          ),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.lightBlue,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0)
                          )
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text('Iniciar Sesion', style: TextStyle(color: Colors.white),),
                      )
                    ],
                  )),
            ),
            new Container(
//              width: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset(
                  "assets/logotripout.png",
                  height: MediaQuery.of(context).size.height * 0.2,
                )),
          ],
        ),
      ),
    );
  }
}