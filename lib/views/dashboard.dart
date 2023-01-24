import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/library.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/views/view_task.dart';
import 'about.dart';
import 'add_task.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: primaryColor
                ),
                child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                  vSpace,
                  Text("${user.displayName}",style: heading.copyWith(color: Colors.grey.shade200),),
                  Text("${user.email}",style: smallText.copyWith(color: Colors.grey.shade400),),
                ],
              ),
            ),),
            ListTile(
              title:Text("About",style:heading),
              leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade200,
                  child: const Icon(Icons.person),
              ),
              onTap: (){
                Get.back();
                Get.to(()=>const AboutPage());
              },
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: CircleAvatar(
                backgroundColor:Colors.grey.shade400,
                child: const FaIcon(FontAwesomeIcons.powerOff),
              ),
              title:Text("Logout",style:heading),
              onTap: ()async{
                Get.back();
                var conf = await appConfirm(context: context,title: "Are you sure ?",subTitle: "Sign out from this app");
                if(conf==true){
                  await GoogleAuthController().logout();
                }
              },
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTask(
                        userId: user.email,
                      )));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(color: primaryColor,

            image: const DecorationImage(image: AssetImage("assets/images/bg.jpg"),fit: BoxFit.cover)
            ),
            child: Stack(
              children: [
                Positioned(
                  top:0,
                  bottom:0,
                  left:MediaQuery.of(context).size.width*0.6,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4)
                    ),
                  ),
                ),
                Positioned(
                  bottom:0,
                  left: 0,
                  right: MediaQuery.of(context).size.width*0.4,
                  child: Container(
                    height: 4,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(50))
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap:(){
                          scaffoldKey.currentState!.openDrawer();
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.barsStaggered,
                          color: Colors.white,
                        ),
                      ),
                      vSpaceBig,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Project\nThe Planning",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 25,
                                  color: Colors.grey.shade200),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "24",
                                style: heading1.copyWith(color: Colors.grey.shade200),
                              ),
                              Text(
                                "Personal",
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey.shade400),
                              )
                            ],
                          ),
                          hSpace,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "15",
                                style: heading1.copyWith(color: Colors.grey.shade200),
                              ),
                              Text(
                                "Business",
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey.shade400),
                              )
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      Text(
                        "Jan 22, 2023",
                        style: smallText.copyWith(color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: tasks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      var data = snapshot.data!;

                      if (data.isEmpty) {
                        return Center(
                          child: Text("No Task Found", style: heading1),
                        );
                      }

                      return ListView.builder(
                          itemCount: data.length,
                          padding: const EdgeInsets.only(
                              bottom: 90, top: 10, left: 10, right: 10),
                          itemBuilder: (context, index) {
                            var task = data[index];
                            return InkWell(
                              onLongPress: user.email != task['userId']
                                  ? null
                                  : () {
                                      bottomSheet(Column(
                                        children: [
                                          Text("ACTION", style: heading),
                                          ListTile(
                                            title: Text(
                                              "Edit",
                                              style: heading,
                                            ),
                                            leading: const Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                            ),
                                            onTap: () {
                                              Get.back();
                                              Get.to(() => AddTask(
                                                    userId: user.email,
                                                    task: task,
                                                  ));
                                            },
                                          ),
                                          ListTile(
                                            title: Text(
                                              "Delete",
                                              style: heading,
                                            ),
                                            leading: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onTap: () async {
                                              Get.back();
                                              var conf = await appConfirm(
                                                  context: context,
                                                  title: "Are you sure?",
                                                  subTitle:
                                                      "Delete ${task['name']}");
                                              if (conf == true) {
                                                await TaskController()
                                                    .deleteTask(task.id);
                                                Get.showSnackbar(const GetSnackBar(message: "Task Deleted",duration: Duration(seconds: 2),backgroundColor: Colors.red,));
                                              }
                                            },
                                          )
                                        ],
                                      ));
                                    },
                              onTap: () {
                                Get.to(() => ViewTask(data: task));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade300))),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Center(
                                          child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: const FaIcon(FontAwesomeIcons.evernote),
                                      )),
                                    ),
                                    hSpace,
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "${task['name']}",
                                          style: heading1.copyWith(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${task['description']}",
                                          style: smallText.copyWith(
                                              color: Colors.grey),
                                        ),
                                        vSpaceSmall,
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month,color: primaryColor,size: 15,),
                                            hSpaceSmall,
                                            Text(
                                              "${task['task_date']}",
                                              style: heading.copyWith(
                                                fontSize: 10,
                                                  color: primaryColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Something went wrong", style: heading1),
                      );
                    }
                    return Text("NO Task Found", style: heading1);
                  }))
        ],
      ),
    );
  }

  Stream<List> tasks() => FirebaseFirestore.instance
      .collection("tasks")
      .snapshots()
      .map((snapshot) => snapshot.docs.toList());
}
