import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pockettask/view/utils/theme/app_color.dart';







class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.svgPath, required this.title, this.showButton = false, this.button});
  final String svgPath;
  final String title;
  final bool showButton;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100.h,),
          //SvgPicture.asset(svgPath),
          Container(
            alignment: Alignment.center,
            height: 200.h,
            width: 200.w,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              //borderRadius: BorderRadius.circular(20.r),
              shape: BoxShape.circle
            ),
            child: Icon(
              size: 100.r,
              color: Theme.of(context).iconTheme.color,
              CupertinoIcons.doc_text,
            ),
                       
          ),
          SizedBox(height: 30.h,),
          Text(
            title,
            style: GoogleFonts.nunito(
              color: Theme.of(context).textTheme.bodySmall!.color,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
          ),
          SizedBox(height: 15.h,),
          showButton ? SizedBox(height: 25.h,) : const SizedBox.shrink(),
          if(showButton)
          button ?? const SizedBox.shrink()
        ],
      )
    );
  }
}


