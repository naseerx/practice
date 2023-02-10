import 'package:e_express/Screens/repo/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _formkey = GlobalKey<FormState>();
  AuthServices authServices = AuthServices();
  var emailEditingController = TextEditingController();

  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('forget Screen'),
        centerTitle: true,
        backgroundColor:  Colors.amber,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: const Image(
                      image: AssetImage('assets/mailverfication.gif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.email),
                    ),
                    onChanged: (String value) {
                      email = value;
                    },
                    validator: (value) {
                      return value!.isEmpty ? 'please enter your email' : null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    width: 180,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          authServices.sendPasswordResetEmail(
                              emailEditingController.text.trim());
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(msg: 'Request has been send.');
                        }
                      },
                      child: const Text('Reset'),
                      style: ElevatedButton.styleFrom(
                          primary:  Colors.amber,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
