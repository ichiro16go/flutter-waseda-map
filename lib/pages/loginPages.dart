import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'firebase_options.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  static final _googleSignin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField( // for original email
                decoration: const InputDecoration(labelText: 'Email address'),
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              TextFormField( // for original password
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (String value) {
                  setState(() {
                    _password = value;
                  });
                } ,
              ),
              ElevatedButton( // fot login using original email
                child: const Text('Login'),
                onPressed: () async {
                  try {
                    final User? user = (
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email, 
                        password: _password
                      )
                    ).user;
                    if (user == null) return;
                    
                    print('Succeded in logging in!\n hello, ${user.uid}');
                  } catch (e) {
                    print(e);
                  }
                }
              ),
              ElevatedButton(
                child: const Text('Login with Google'),
                onPressed: () async {
                  GoogleSignInAccount? account = await _googleSignin.signIn();
                  if (account == null) return;

                  GoogleSignInAuthentication authentication = await account.authentication;
                  final OAuthCredential credential = GoogleAuthProvider.credential(
                    idToken: authentication.idToken,
                    accessToken: authentication.accessToken,
                  );
                  User? user = (
                    await FirebaseAuth.instance.signInWithCredential(credential)
                  ).user;
                  if (user == null) return;
                  
                  print('succeeded in logging in with Google account: ${user.uid}');
                  setState(() {
                    // change Scene
                  });
                }, 
              ),
              ElevatedButton( // for new user resisration.
                child: const Text('User resisration'),
                onPressed: () async {
                  try {
                    final User? user = (
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _email, 
                        password: _password
                      )
                    ).user;
                    if (user != null) {
                      print("Succeeded in resitering you as our user!\n email: ${user.email}, id: ${user.uid}");
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              )
            ],

          ),
        )
      ),
    );
  }
}
