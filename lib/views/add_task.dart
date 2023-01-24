import 'package:cloud_firestore/cloud_firestore.dart';

import '../library.dart';

class AddTask extends StatefulWidget {
  final String? userId;
  final dynamic task;
  const AddTask({Key? key, this.userId, this.task}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final formKey = GlobalKey<FormState>();

  TextEditingController name= TextEditingController();
  TextEditingController description= TextEditingController();
  TextEditingController taskDate= TextEditingController();

  DateTime selectedDate = DateTime.now();

  bool isLoading=false;

  String? title="Add New Task";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showData();
  }

  showData(){
    setState(() {
      isLoading=true;
    });
    if(widget.task!=null){
      name.text=widget.task['name'];
      description.text=widget.task['description'];
      taskDate.text=widget.task['task_date'];
      title="Update Task";
    }
    setState(() {
      isLoading=false;
    });


  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            title!,
            style: heading1.copyWith(color: Colors.white),
          )
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            children: [
              TextFormField(
                controller: name,
                validator: (val)=>val==""?"Task name required":null,
                decoration: inputDecoration(
                  label: "Task Name",
                  hintText: "Enter Task Name",
                ),
              ),
              vSpaceBig,
              TextFormField(
                controller: description,
                validator: (val)=>val==""?"Task description required":null,
                decoration: inputDecoration(
                  label: "Description",
                  hintText: "Enter Description",
                ),
                minLines: 2,
                maxLines: 10,
              ),
              vSpaceBig,
              TextFormField(
                controller: taskDate,
                validator: (val)=>val==""?"Task Date required":null,
                decoration: inputDecoration(
                  label: "Task Date",
                  hintText: "Select Task Date",
                    suffixIcon: Icons.calendar_month,
                ),
                readOnly: true,
                onTap: () {
                  selectDate(taskDate);
                },
              ),
              vSpaceBig,
              ElevatedButton(
                onPressed: saveTask,
                style: buttonStyle,
                child: Text(
                  "SAVE TASK",
                  style: heading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveTask()async{

    FocusScope.of(context).unfocus();


    var form = formKey.currentState;

    if(form!.validate()){
      form.save();
      final taskDoc = FirebaseFirestore.instance.collection("task").doc();
      /// creating Task
      var data={
        "userId":widget.userId.toString(),
        "name":name.text,
        "description":description.text,
        "task_date":taskDate.text,
      };

      if(title=="Update Task"){
        var res = await TaskController().updateTask(widget.task.id,data);
        if(res!=null){
          Get.back();
          Get.showSnackbar(const GetSnackBar(message: "Task Updated",duration: Duration(seconds: 2),backgroundColor: Colors.orange,));
        }
      }else{
        data.addAll({"created_at":DateTime.now().toString()});

        var res = await TaskController().addNewTask(data);
        if(res!=null){
          Get.back();
          Get.showSnackbar(const GetSnackBar(message: "Task Added",duration: Duration(seconds: 2),backgroundColor: Colors.green,));
        }
      }


    }


  }

  void selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 150)),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        controller.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }


}
