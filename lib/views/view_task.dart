import 'package:todo_firebase/library.dart';

class ViewTask extends StatefulWidget {

  final dynamic data;

  const ViewTask({Key? key, this.data}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title:const Text("Task Details")
      ),

      body: ListView(
        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
        children: [
          Row(
            children: [
              Icon(Icons.task,color: primaryColor,size: 15,),
              hSpace,
              Text("${widget.data['name']}",style: heading1,),
            ],
          ),
          vSpaceSmall,
          Row(
            children: [
              Icon(Icons.calendar_month,color: primaryColor,size: 15,),
              hSpace,
              Text("${widget.data['task_date']}",style: heading.copyWith(fontSize: 11,color: primaryColor),),
            ],
          ),
          vSpace,
          Text("${widget.data['description']}"),
        ],
      ),

    );
  }
}
