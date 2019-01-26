import 'package:flutter/material.dart';

class SigIn extends StatefulWidget {
  @override
  State createState() => _SigIn();
}

class _SigIn extends State<SigIn> {
  final _formKey = GlobalKey<FormState>();
  var _company = false;
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
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Clave',
                              labelText: 'Clave',
                          ),
                        ),
                        SizedBox(height: 8.0,),
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
                          child: Text('Registrar', style: TextStyle(color: Colors.white),),
                        ),
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
