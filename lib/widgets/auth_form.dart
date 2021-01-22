import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
      this.submitFn,
      this.isLoading,
      );

  final bool isLoading;
  final void Function(
      String email,
      String password,
      String userName,
      bool isLogin,
      BuildContext ctx,
      ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
      Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Image(
            image: AssetImage('assets/images/logo1.png'),
            width: 160,
            height: 160,
          ),
          SizedBox(
            height: 25,
          ),
          Card(
        elevation: 15,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)),
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(

                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Lütfen geçerli bir mail adresi giriniz!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email adresi',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Lütfen en az 4 karakter giriniz!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Kullanıcı Adı',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Şifre en az 7 karakterli olmalı';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Şifre',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: _isLogin ? Text(
                        "Kullanıcı Girişi",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ) : Text(
                          "Kayıt Olun",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Colors.blueGrey,
                      child: _isLogin ? Text(
                          "Yeni hesap açın", style: TextStyle(
                        color: Colors.black,
                      ),)
                          : Text("Benim zaten bir hesabım var",
                        style: TextStyle(
                          color: Colors.black,
                        ),),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
      ],
      ),
    ),],);
  }
}
