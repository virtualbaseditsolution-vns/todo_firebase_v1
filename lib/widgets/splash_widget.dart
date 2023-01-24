import '../library.dart';
import '../views/login.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Planning the Project",style: heading2),
                  vSpaceBig,
                  Text("Assignment Submitted By",style: smallText),
                  vSpaceSmall,
                  Text("vbits.vns@gmail.com",style: heading1)
                ],
              )
          ),
        ),
        Column(
          children: [
            FloatingActionButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
            },child: const Icon(Icons.navigate_next_rounded,size: 40,),),
            const SizedBox(height: 50,),
          ],
        )
      ],
    );
  }
}
