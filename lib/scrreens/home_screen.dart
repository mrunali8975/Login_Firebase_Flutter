import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase_demo/model/user_model.dart';
import 'package:login_firebase_demo/scrreens/login_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user=FirebaseAuth.instance.currentUser;
  UserModel loggedUser=UserModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value){
      this.loggedUser=UserModel.fromMap(value.data());
      setState((){});
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Welcome"),centerTitle: true,

    ),
    body: Center(child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 100,
          child: Image.asset("assets/launc_icon.png",fit: BoxFit.contain),),
          Text("Welcome Back",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text("${loggedUser.firstName } ${loggedUser.secondName}",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Text("${loggedUser.email}",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500),),
          SizedBox(height: 50,),
          ActionChip(label: Text('Logout') ,onPressed: (){
            logout(context);
          },)
        ]
      ),
    ),),);
  }
  
  
  Future<void> logout(BuildContext context) async
  {
    await  FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
}
