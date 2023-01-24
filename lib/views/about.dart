import 'package:todo_firebase/library.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title:const Text("About")
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Developed by",style:heading),
            vSpace,
            Text("VIJAY BAHADUR",style: heading.copyWith(fontSize: 12,color: Colors.blue),),
            vSpaceSmall,
            InkWell(
                onTap: ()async{
                  await launchUrl(Uri.parse("mailto:vbits.vns@gmail.com"));
                },child: Text("vbits.vns@gmail.com",style:smallText)),
            const SizedBox(height: 3,),
            InkWell(
                onTap: ()async{
                  await launchUrl(Uri.parse("tel:+91 8299096863"));
                },child: Text("+91 8299096863",style:smallText.copyWith(fontWeight: FontWeight.w500))),
            const SizedBox(height: 100,),
            Text("Follow on",style:heading),
            vSpace,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: ()async{
                      await launchUrl(Uri.parse("https://digital-vijay.web.app/"));
                    },
                    child: const FaIcon(FontAwesomeIcons.globe,color: Colors.blue,)),
                hSpaceBig,
                InkWell(
                    onTap: ()async{
                      await launchUrl(Uri.parse("https://www.facebook.com/vijaybahadurvns"));
                    },
                    child: const FaIcon(FontAwesomeIcons.facebook,color: Colors.blue,)),
                hSpaceBig,
                InkWell(
                    onTap: ()async{
                      await launchUrl(Uri.parse("https://www.instagram.com/vijaybahadurvns"));
                    },child: FaIcon(FontAwesomeIcons.instagram,color: Colors.redAccent.shade400,)),
                hSpaceBig,
                InkWell(
                    onTap: ()async{
                      await launchUrl(Uri.parse("https://www.linkedin.com/in/vijaybahadurvns/"));
                    },child: FaIcon(FontAwesomeIcons.linkedin,color:Colors.blue.shade800)),
                hSpaceBig,
                InkWell(
                    onTap: ()async{
                      await launchUrl(Uri.parse("https://www.youtube.com/@vbits4464"));
                    },child: const FaIcon(FontAwesomeIcons.youtube,color:Colors.red)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
