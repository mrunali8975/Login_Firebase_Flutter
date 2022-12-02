import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_firebase_demo/model/user_model.dart';
import 'package:login_firebase_demo/scrreens/home_screen.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //form key
  final _formKey=GlobalKey<FormState>();
  final _auth=FirebaseAuth.instance;
  final firstNameEditController=new TextEditingController();
  final lastNameEditController=new TextEditingController();
  final emailEditController=new TextEditingController();
  final passwordEditController=new TextEditingController();
  final confirmpasswordEditController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    //password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordEditController,
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter your password");
        }
        if (!regExp.hasMatch(value)) {
          return ("Please enter Valid Password minimum 6 character");
        }
        return null;
      },
      onSaved: (value) {
        passwordEditController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Paaword",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //sign up button
    final loginButton = Material(
      elevation: 5,
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditController.text, passwordEditController.text);
        },
        child: Text("Sign up",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter your Email");
        }
        //  reg expresstion
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[1-z]").hasMatch(value)) {
          return ("Please Enter a valude email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditController,
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First name cannot be empty");
        }
        if (!regExp.hasMatch(value)) {
          return ("Enter valid name min 3 character");
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        firstNameEditController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //last name field
    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regExp = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Second name cannot be empty");
        }
        if (!regExp.hasMatch(value)) {
          return ("Enter valid name min 3 character");
        }
        return null;
      },
      onSaved: (value) {
        lastNameEditController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Second Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //Confirm password field
    final conformPassField = TextFormField(
      autofocus: false,
      controller: confirmpasswordEditController,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      validator: (value)
      {if(passwordEditController.text.length>6&& passwordEditController.text!=value)
        {
          return "Password dont match";
        }
        return null;
      },
      onSaved: (value) {
        confirmpasswordEditController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){Navigator.of(context).pop();},
          icon: Icon(Icons.arrow_back,color: Colors.redAccent,),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 180,
                          child: Image.asset('assets/launc_icon.png',
                              fit: BoxFit.contain),
                        ),

                        firstNameField,
                        SizedBox(
                          height: 20,
                        ),
                        lastNameField,
                        SizedBox(
                          height: 20,
                        ),
                        emailField,
                        SizedBox(
                          height: 25,
                        ),
                        passwordField,
                        SizedBox(
                          height: 20,
                        ),
                        conformPassField,
                        SizedBox(
                          height: 20,
                        ),
                        loginButton,
                        SizedBox(
                          height: 15,
                        ),

                      ],
                    ),
                  ),
                )),
          )),
    );
  }
  void signUp(String email,String password) async
  {
    if(_formKey.currentState!.validate())
      {
       await _auth.createUserWithEmailAndPassword(email: email, password: password).
    then((value) => {
      postDetailsToFirseStrore()
       }).catchError((e){
         Fluttertoast.showToast(msg: e!.message);
       });
      }

  }
  postDetailsToFirseStrore() async{
  //  calling firestore
  //  calling usermodel
  //  sending our value
    FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
    User? user=_auth.currentUser;
    UserModel userModel=UserModel();
  //  writting all b=value
    userModel.email=user!.email;
    userModel.uid=user!.uid;
    userModel.firstName=firstNameEditController.text;
    userModel.secondName=lastNameEditController.text;
    await firebaseFirestore.collection("users").doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);

  }

}
