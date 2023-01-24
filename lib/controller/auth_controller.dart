import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../library.dart';

class GoogleAuthController extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future googleLogin()async{
    final googleUser = await googleSignIn.signIn();

    if(googleUser==null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    loading("Please Wait ....");
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.back();
    notifyListeners();
  }

  Future logout()async{
    loading("Logout....");
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    Get.back();
  }

}