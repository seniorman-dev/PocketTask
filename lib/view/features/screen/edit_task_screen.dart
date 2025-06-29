import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pockettask/controller/database/task_controller.dart';
import 'package:pockettask/view/utils/buttons/broom_button.dart';
import 'package:pockettask/view/utils/components/snackbar.dart';
import 'package:pockettask/view/utils/components/textfield.dart';
import 'package:pockettask/view/utils/theme/app_color.dart';







class EditTaskScreen extends StatelessWidget {
  EditTaskScreen({super.key, required this.index, required this.title, required this.note, required this.createdAt, required this.status});
  final int index;
  final String title;
  final String note;
  final String status;
  final DateTime createdAt;

  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BroomIconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: CupertinoIcons.arrow_left
                  ),
                
                  BroomIconButton(
                    onPressed: () async{
                      await _taskController.updateTask(
                        index: index,
                        title: _taskController.titleTextEdit.text.isNotEmpty ? _taskController.titleTextEdit.text : title, 
                        note: _taskController.noteTextEdit.text.isNotEmpty ? _taskController.noteTextEdit.text : note, 
                        status: status, 
                        createdAt: createdAt, //DateTime.timestamp().toLocal()
                      )
                      .then((val) {
                        _taskController.filterTaskList.clear();
                        _taskController.getTask().then((val) {
                          _taskController.titleTextEdit.clear();
                          _taskController.noteTextEdit.clear();
                          Get.back();
                          showMySnackBar(message: "Task updated successfully", backgroundColor: AppColor.primaryGreen);
                        });
                      });
                    },
                    icon: Icons.save_outlined
                   ),
                ], 
              ),

              SizedBox(height: 40.h,),

              //TEXTFIELDS
              Text(
                "Title",
                style: GoogleFonts.nunito(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              SizedBox(height: 10.h,),
              CustomTextField(
                onChanged: (val) {
                  _taskController.titleTextEdit.text = val;
                },
                onFocusChanged: (val) {},
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                initialValue: title,
              ),

              SizedBox(height: 40.h,),

              Text(
                "Detail",
                style: GoogleFonts.nunito(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              SizedBox(height: 10.h,),
              CustomTextField(
                onChanged: (val) {
                  _taskController.noteTextEdit.text = val;
                },
                onFocusChanged: (val) {},
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                initialValue: note,
              ),

            ].animate(interval: 100.ms, autoPlay: true).fadeIn(duration: 100.ms, curve: Curves.bounceIn),
          )
        )
      )
    );
  }
}