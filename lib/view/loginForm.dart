import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_trip_out/view/components/tripButton.dart';
import 'package:we_trip_out/view/home/bottomNavigator.dart';

class LoginForm extends StatefulWidget {
  @override
  State createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = new ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _email = '';
  var _password = '';

  login() {
    _auth
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((user) {
      Navigator.of(context).pushNamed(BottomNavigator.routeName);
    }).catchError((err) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error')));
    });
  }

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
                        '¡Bienvenido!',
                        style: Theme.of(context).textTheme.headline,
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

                            setState(() {
                              _email = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
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
                            setState(() {
                              _password = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Clave',
                            labelText: 'Clave',
                          ),
                        ),
                      ),
                      TripButton(
                        texto: 'Inicia sesión',
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                                login();
                          }
                          // Navigator.of(context).pushNamed(BottomNavigator.routeName);
                        },
                      ),
                      GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed('/sig_in'),
                          child:
                              Text('¿No tienes una cuenta? Registrate aqui.')),
                      Text('Recuperar clave'),
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
