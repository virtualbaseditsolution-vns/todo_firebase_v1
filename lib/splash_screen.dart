import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_firebase/views/dashboard.dart';
import 'package:todo_firebase/views/login.dart';
import 'package:todo_firebase/widgets/splash_widget.dart';

import 'library.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const SplashWidget();
          }else if(snapshot.hasData){
            return const Dashboard();
          }else if(snapshot.hasError){
            return Center(child: Text("Something went wrong",style: heading,),);
          }else{
            return const LoginPage();
          }
        }
      ),
    );
  }
}



