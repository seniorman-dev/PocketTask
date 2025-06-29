import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pockettask/view/utils/theme/app_color.dart';





Future<void> showErrorOverlay({
  required String errorText,
}) async {
  await Get.dialog(
    transitionCurve: const ElasticOutCurve(),
    useSafeArea: true,
    barrierDismissible: false,
    AlertDialog.adaptive(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      backgroundColor: AppColor.primaryWhite,
      content: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                  height: 150.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.errorRed.withOpacity(0.2),
                  ),
                  child: Icon(
                    CupertinoIcons.xmark,
                    color: AppColor.errorRed,
                    size: 80.r,
                  ),
                ),

                SizedBox(height: 30.h,),
                Text(
                  errorText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: AppColor.primaryBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 50.h,),
              
                //Custom Elevated Button
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      color: AppColor.primaryBlue,
                      borderRadius: BorderRadius.circular(10.r)
                    ),
                    child: Text(
                      "Got it!",
                      style: GoogleFonts.nunito(
                        color: AppColor.primaryBlack,  //primaryWhite,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

              ],
            ),
          )
  
        ],
      ),
    ),
  );
}





Future<void> showDemureSnackBar({required String title, required String message}) async{
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    //backgroundColor: AppColor.semiIndigoColor,
    snackStyle: SnackStyle.FLOATING,
    barBlur: 10,
    duration: Duration(seconds: 2),
  );
}




Future<void> showMySnackBar({required String message, required Color backgroundColor}) async {
  Get.snackbar(
    "",  // Title (can be empty if not needed)
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    colorText: AppColor.primaryWhite,
    borderRadius: 8.0,
    margin: const EdgeInsets.all(16.0),
    duration: const Duration(seconds: 2), // Adjust the duration as needed
    snackStyle: SnackStyle.FLOATING,
    barBlur: 10,
    animationDuration: const Duration(milliseconds: 300),
    messageText: Text(
      message,
      textAlign: TextAlign.center,
      style: GoogleFonts.nunito(
        color: AppColor.primaryWhite,
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

