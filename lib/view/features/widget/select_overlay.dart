import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pockettask/controller/database/task_controller.dart';
import 'package:pockettask/view/features/screen/detail_screen.dart';
import 'package:pockettask/view/features/screen/edit_task_screen.dart';
import 'package:pockettask/view/utils/components/snackbar.dart';
import 'package:pockettask/view/utils/theme/app_color.dart';






Future<void> selectOverlay({
  required BuildContext context,
  required TaskController controller,
  required int index,
  required String title,
  required String note,
  required String status,
  required DateTime createdAt,
}) async{
  
  Get.bottomSheet(
    isDismissible: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))
    ),
    isScrollControlled: true,
    Wrap(
      children: [
        Container(
          alignment: Alignment.center,
          //height: MediaQuery.of(context).size.height * 0.75,
          padding: EdgeInsets.symmetric(horizontal: 30.w,),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 7.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),

              SizedBox(height: 30.h,),

              GestureDetector(
                onTap: () async{
                  if(status == "pending") {
                    await controller.updateTask(
                      index: index,
                      title: title, 
                      note: note, 
                      status: "completed", 
                      createdAt: createdAt,
                    )
                    .then((val) {
                      controller.getTask().then((val) {
                        Get.back();
                        showMySnackBar(message: "Task completed successfully", backgroundColor: AppColor.primaryGreen);
                      });
                    });
                  }
                  else {
                    Get.back();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: status ==  "pending" ? AppColor.errorRed.withOpacity(0.2) : AppColor.primaryBlue, //Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(40.r)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        status == "pending" ? "Mark as 'completed'?" : "Task status (completed)",
                        style: GoogleFonts.nunito(
                          color: AppColor.primaryBlack,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      Icon(
                        color: AppColor.primaryBlack, //color: Theme.of(context).textTheme.bodyMedium!.color,
                        size: 20.r,
                        status == "pending" ? CupertinoIcons.doc_text : CupertinoIcons.checkmark
                      )
                    ],
                  )
                  
                ),
              ),
              
              SizedBox(height: 40.h,),

              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(() => DetailScreen(
                    title: title, 
                    note: note, 
                    createdAt: createdAt, 
                    index: index, 
                    status: status
                  ));
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(40.r)
                  ),
                  child: Text(
                    "View task",
                    style: GoogleFonts.nunito(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.h,),

              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(() => EditTaskScreen(
                    title: title, 
                    note: note, 
                    createdAt: createdAt, 
                    index: index, 
                    status: status
                  ));
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(40.r)
                  ),
                  child: Text(
                    "Edit task",
                    style: GoogleFonts.nunito(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h,),
            ],
          )
        )
      ]
    )
  );
}