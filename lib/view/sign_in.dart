import 'package:flutter/material.dart';
import 'package:we_trip_out/view/components/tripButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class SigIn extends StatefulWidget {
  static const String routeName = '/sig_in';
  @override
  State createState() => _SigIn();
}

class _SigIn extends State<SigIn> {
  final _formKey = GlobalKey<FormState>();
  var _company = false;
  var _name = '';
  var _email = '';
  var _password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Null> registrarte() async{
    _auth.createUserWithEmailAndPassword(email: _email, password: _password)
    .then(
      (res) {
        final Firestore _fbStore = Firestore.instance;
        _fbStore.collection('user').document()
        .setData({'name': _name, 'uid': res.uid, 'company': _company, 'email': _email});
        _fbStore.collection('account').document()
        .setData({'owner': res.uid, 'name': 'Cuenta por defecto', 'transactions' : []});
        print('FIREBASE: ${res.uid} ${res.email} ${res.displayName}');
      }
    )
    .catchError((err) {
      print('FIREBASE: ERROR');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
//        height: MediaQuery.of(context).size.height,
//        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: new Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Card(
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new ListView(
//                  mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '¡Bienvenido!',
                          style: Theme.of(context).textTheme.headline,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Switch(value: _company, onChanged: (val) => setState(() {
                              _company = val;
                            })),
                            Text(
                              '¿Eres una empresa?'
                            )
                          ],
                        ),
                        SizedBox(height: 8.0,),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Favor ingresar Nombre';
                            }
                            setState(() {
                              _name = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Nombre completo',
                            labelText:  'Nombre completo'
                          ),
                        ),
                        SizedBox(height: 8.0,),
                        TextFormField(
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
                              hintText: 'Usuario/Email',
                              labelText: 'Usuario/Email',
                          ),
                        ),
                        SizedBox(height: 8.0,),
                        TextFormField(
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
                        SizedBox(height: 8.0,),
                        TripButton(
                          texto: 'Registrar',
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
//                              Scaffold.of(context).showSnackBar(
//                                  SnackBar(content: Text('Processing Data')));
                                  registrarte();
                            }
                          },
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
        decoration: BoxDecoration(
//            color: Colors.red,
            image: DecorationImage(
                image: AssetImage("assets/edificios01.png"),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter)),
      ),

    );
  }
}
