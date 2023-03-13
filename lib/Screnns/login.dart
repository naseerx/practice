import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showErrorText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xff6F1C54),
        Color(0xff6F1C54),
        Color(0xff4A1D3A),
        Color(0xff281E26),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xff6F1C54),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 40,
                                color: Color(0xffCEB846),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Text(
                            'username',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0),
                              prefixIcon: const Icon(Icons.person_3_outlined),
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xffE3E3E3)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Text(
                            'password',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0),
                              prefixIcon: const Icon(Icons.lock_outline),
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xffE3E3E3)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        showErrorText
                            ? const Text(
                                'your username or password were incorrect',
                                style: TextStyle(
                                  color: Color(0xffCEB846),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color(0xffCEB846),
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                setState(() {
                                  showErrorText = !showErrorText;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: Colors.white),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xff6F1C54),
                        foregroundColor: Colors.white),
                    onPressed: () {
                      setState(() {
                        showErrorText = !showErrorText;
                      });
                    },
                    child: const Text(
                      'SING UP',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),

                Text('moodie',
                    style: GoogleFonts.leckerliOne(
                      textStyle: const TextStyle(
                        fontSize: 50,
                        color: Color(0xffCEB846),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
