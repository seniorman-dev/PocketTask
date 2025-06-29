import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pockettask/view/utils/buttons/broom_button.dart';
import 'package:pockettask/view/utils/components/converters.dart';
import 'package:pockettask/view/utils/theme/app_color.dart';





class DetailScreen extends StatelessWidget {
  final int index;
  final String title;
  final String note;
  final String status;
  final DateTime createdAt;
  const DetailScreen({super.key, required this.title, required this.note, required this.createdAt, required this.index, required this.status});

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
                
                  Container(
                    //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    alignment: Alignment.center,
                    height: 35.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: status ==  "pending" ? AppColor.errorRed.withOpacity(0.2) : AppColor.primaryBlue,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.nunito(
                        color: status ==  "pending" ? AppColor.errorRed : AppColor.primaryBlack,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ], 
              ),

              SizedBox(height: 40.h,),

              //TEXTS
              Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),

              SizedBox(height: 20.h,),

              Text(
                note,
                style: GoogleFonts.nunito(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
              ),
              SizedBox(height: 20.h,),
              Text(
                "${formatDate(createdAt)}  ${formatTime(createdAt)}",
                style: GoogleFonts.nunito(
                  color: Theme.of(context).textTheme.bodySmall!.color,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
              ),

            ].animate(interval: 100.ms, autoPlay: true).fadeIn(duration: 100.ms, curve: Curves.bounceIn),
          )
        )
      )
    );
  }
}