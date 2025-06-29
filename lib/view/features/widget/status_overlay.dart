import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pockettask/controller/database/task_controller.dart';
import 'package:pockettask/view/utils/components/custom_radio.dart';







Future<void> statusOverlay({
  required BuildContext context,
  required TaskController controller,
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

              Center(
                child: Text(
                  "Filter task by",
                  style: GoogleFonts.nunito(
                    color: Theme.of(context).textTheme.bodySmall!.color,
                    fontSize: 16.sp,  //22.sp
                    fontWeight: FontWeight.w500  //w700,
                  ),
                ),
              ),

              SizedBox(height: 30.h,),

              GestureDetector(
                onTap: () async{
                  controller.onStatusFilter("all");
                  await controller.filterTaskStatus("") //
                  .whenComplete(() {
                    Get.back();
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(40.r)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All",
                        style: GoogleFonts.nunito(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      Obx(
                        () {
                          return CustomRadioButton(
                            radioColor: Theme.of(context).textTheme.bodyMedium!.color!,
                            isSelected: controller.selectedStatusFilter.value == 'all',
                            onSelect: () async{
                              controller.onStatusFilter("all");
                              await controller.filterTaskStatus("") //
                              .whenComplete(() {
                                Get.back();
                              });
                            }
                          );
                        }
                      ),
                    ],
                  )
                  
                ),
              ),
              
              SizedBox(height: 40.h,),

              GestureDetector(
                onTap: () async{
                  controller.onStatusFilter("pending");
                  await controller.filterTaskStatus("pending") //
                  .whenComplete(() {
                    Get.back();
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(40.r)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pending",
                        style: GoogleFonts.nunito(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      Obx(
                        () {
                          return CustomRadioButton(
                            radioColor: Theme.of(context).textTheme.bodyMedium!.color!,
                            isSelected: controller.selectedStatusFilter.value == 'pending',
                            onSelect: () async{
                              controller.onStatusFilter("pending");
                              await controller.filterTaskStatus("pending") //
                              .whenComplete(() {
                                Get.back();
                              });
                            }
                          );
                        }
                      ),
                    ],
                  )
                  
                ),
              ),

              SizedBox(height: 40.h,),

              GestureDetector(
                onTap: () async{
                  controller.onStatusFilter("completed");
                  await controller.filterTaskStatus("completed") //
                  .whenComplete(() {
                    Get.back();
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(40.r)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Completed",
                        style: GoogleFonts.nunito(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      Obx(
                        () {
                          return CustomRadioButton(
                            radioColor: Theme.of(context).textTheme.bodyMedium!.color!,
                            isSelected: controller.selectedStatusFilter.value == 'completed',
                            onSelect: () async{
                              controller.onStatusFilter("completed");
                              await controller.filterTaskStatus("completed") //
                              .whenComplete(() {
                                Get.back();
                              });
                            }
                          );
                        }
                      ),
                    ],
                  )
                  
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