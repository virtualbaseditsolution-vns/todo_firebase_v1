import 'package:todo_firebase/library.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("LOGIN", style: heading2.copyWith(color: Colors.white)),
                    vSpaceBig,
                    Text("Planing the Project", style: heading1.copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final googleAuth = Provider.of<GoogleAuthController>(
                          context,
                          listen: false);

                      await googleAuth.googleLogin();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10)),
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: const Text(
                      "Google Sign in",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
