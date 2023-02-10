import 'package:flutter/material.dart';
import 'package:practice/Screnns/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
        TextField(
          controller: controller,
          obscureText: obSecure,
          decoration: InputDecoration(
            prefixIcon: Icon(iconData,color: gSecondaryColor,),
            hintText: hint,
            fillColor: fillColor,

            filled: true,
            suffixIcon: suffix,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
          ),
        );
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
gymAdminSignIn() async {
  var email = emailController.text;
  var pass = passwordController.text;

  ProgressDialog dialog = ProgressDialog(
    context,
    title: const Text('Signing up'),
    message: const Text(
      'Please wait',
    ),
    defaultLoadingWidget: const SpinKitCircle(
      color: gSecondaryColor,
      size: 50.0,
    ),
  );

  if (email.isEmpty || pass.isEmpty) {
    Fluttertoast.showToast(
        msg: 'Please fill all the fields',
        backgroundColor: gPrimaryColor,
        textColor: Colors.black);
    return;
  }

  dialog.show();

  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );

    if (userCredential.user != null) {
      dialog.dismiss();
      Fluttertoast.showToast(
        msg: 'Login Successfully',
        backgroundColor: gPrimaryColor,
        textColor: Colors.black,
      );
      Get.offAll(() => const AdminDashboard());
    }
  } on FirebaseAuthException catch (e) {
    dialog.dismiss();
    if (e.code == 'user-not-found') {
      Fluttertoast.showToast(msg: 'User not found');
    } else if (e.code == 'wrong-password') {
      Fluttertoast.showToast(msg: 'Wrong Password');
    }
  }
}
gymAdminSignUp() async {
  var name = nameController.text;
  var phone = phoneController.text;
  var email = emailController.text;
  var pass = passwordController.text;
  var age = ageController.text;
  var occupation = selectOccupation.toString();
  var gender = selectGender.toString();
  var confirmPass = confirmPassController.text;

  if (name.isEmpty ||
      phone.isEmpty ||
      email.isEmpty ||
      age.isEmpty ||
      occupation.isEmpty ||
      gender.isEmpty ||
      pass.isEmpty ||
      confirmPass.isEmpty) {
    Fluttertoast.showToast(
        msg: 'Please fill all the fields',
        backgroundColor: gPrimaryColor,
        textColor: Colors.black);
    return;
  }

  if (pass != confirmPass) {
    Fluttertoast.showToast(
      msg: 'Password do not match',
      backgroundColor: gPrimaryColor,
      textColor: Colors.black,
    );
    return;
  }

  ProgressDialog dialog = ProgressDialog(
    context,
    title: const Text('Signing up'),
    message: const Text(
      'Please wait',
    ),
    defaultLoadingWidget: const SpinKitRipple(
      color: gSecondaryColor,
      size: 50.0,
    ),
  );

  dialog.show();

  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: pass);
    User? user = userCredential.user;
    firestore.collection('users').doc(user?.uid).set({
      'uid': user?.uid,
      "email": email,
      "name": name,
      "age": age,
      "occupation": occupation,
      "gender": gender,
      "phone": phone,
      "type": 'user',
    });
    if (userCredential.user != null) {
      Fluttertoast.showToast(
          msg: 'Success',
          backgroundColor: gPrimaryColor,
          textColor: Colors.black);
      Get.to(() => const SigninScreenAdmin());
      dialog.dismiss();
    } else {
      Fluttertoast.showToast(
        msg: 'Failed',
        backgroundColor: gPrimaryColor,
        textColor: Colors.black,
      );
    }
    Get.offAll(() => const SigninScreenAdmin());
    dialog.dismiss();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      Fluttertoast.showToast(
        msg: 'Email already use',
        backgroundColor: gPrimaryColor,
        textColor: Colors.black,
      );
      dialog.dismiss();
    } else if (e.code == 'weak-password') {
      Fluttertoast.showToast(
        msg: 'Password id weak',
        backgroundColor: gPrimaryColor,
        textColor: Colors.black,
      );
      dialog.dismiss();
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    dialog.dismiss();
  }
  // Get.to(() => const SigninScreenAdmin());
  dialog.dismiss();
}
