import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pockettask/controller/database/task_controller.dart';
import 'package:pockettask/view/features/screen/add_task_screen.dart';
import 'package:pockettask/view/features/widget/select_overlay.dart';
import 'package:pockettask/view/features/widget/status_overlay.dart';
import 'package:pockettask/view/utils/buttons/broom_button.dart';
import 'package:pockettask/view/utils/components/converters.dart';
import 'package:pockettask/view/utils/components/empty_state.dart';
import 'package:pockettask/view/utils/components/loader.dart';
import 'package:pockettask/view/utils/theme/app_color.dart';
import 'package:pockettask/view/utils/theme/theme_controller.dart';







class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  final ThemeController _themeController = Get.find<ThemeController>(); 
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Task",
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        onPressed: () {
          Get.to(() => AddTaskScreen());
        },
        enableFeedback: true,
        shape: CircleBorder(),
        child: Icon(
          size: 30.r,
          color: Theme.of(context).iconTheme.color,
          CupertinoIcons.add
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "PocketTask",
                      style: GoogleFonts.nunito(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Obx(() => Switch.adaptive(
                        inactiveTrackColor: AppColor.inactiveGrey.withOpacity(0.2),
                        inactiveThumbColor: AppColor.primaryGreen.withOpacity(0.3), //AppColor.textGrey,
                        activeColor: AppColor.primaryGreen,
                        activeTrackColor: AppColor.primaryGreen.withOpacity(0.3),
                        value: _themeController.isDarkMode.value,
                        onChanged: (value) => _themeController.toggleTheme(),
                      )),
                      SizedBox(width: 10.w,),
                      BroomIconButton(
                        onPressed: () {
                          statusOverlay(
                            context: context,
                            controller: _taskController,
                          );
                        },
                        icon: CupertinoIcons.arrow_up_arrow_down
                      ),
                      /*SizedBox(width: 10.w,),
                      BroomIconButton(
                        onPressed: () {},
                        icon: CupertinoIcons.calendar_today
                      )*/
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 40.h,),
        
            //ListView
            Expanded(
              child: Obx(
                () {
                  if(_taskController.isLoading.value) {
                    return LoaderDark();
                  }
                  if(_taskController.taskList.isEmpty) {
                    return EmptyState(svgPath: 'assets/svg/note_empty.svg', title: "Create your first task!");
                  }
                  return RefreshIndicator.adaptive(
                    backgroundColor: Theme.of(context).cardColor,
                    color: Theme.of(context).iconTheme.color,
                    elevation: 0,
                    onRefresh: () => _taskController.getTask(),
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      itemCount: _taskController.filterTaskList.length,
                      separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                      itemBuilder: (context, index) {
                        final data = _taskController.filterTaskList[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              color: AppColor.errorRed.withOpacity(0.4),
                              size: 30.r,
                              CupertinoIcons.delete,
                            ),
                            
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async{
                            await _taskController.deleteTaskByIndex(
                              index: index
                            )
                            .then((val) {
                              _taskController.getTask().then((val) {
                                debugPrint("task array refreshed successfully");
                              });
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              selectOverlay(
                                context: context,
                                controller: _taskController,
                                title: data.title,
                                note: data.note,
                                status: data.status,
                                createdAt: data.createdAt,
                                index: index
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.title,
                                    style: GoogleFonts.nunito(
                                      color: Theme.of(context).textTheme.bodyMedium!.color,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                  ),
                                  SizedBox(height: 30.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${formatDate(data.createdAt)}  ${formatTime(data.createdAt)}",
                                        style: GoogleFonts.nunito(
                                          color: Theme.of(context).textTheme.bodyMedium!.color,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                      ),
                            
                                      Container(
                                        //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                        alignment: Alignment.center,
                                        height: 35.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          color: data.status ==  "pending" ? AppColor.errorRed.withOpacity(0.2) : AppColor.primaryBlue,
                                          borderRadius: BorderRadius.circular(15.r),
                                        ),
                                        child: Text(
                                          data.status,
                                          style: GoogleFonts.nunito(
                                            color: data.status ==  "pending" ? AppColor.errorRed : AppColor.primaryBlack,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                            
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              ),
            )
        
        
          ].animate(interval: 100.ms, autoPlay: true).fadeIn(duration: 100.ms, curve: Curves.bounceIn),
        )
      )
    );
    
  }
}