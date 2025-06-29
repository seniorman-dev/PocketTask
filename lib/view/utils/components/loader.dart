import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pockettask/view/utils/theme/app_color.dart';





class LoaderDark extends StatelessWidget {
  const LoaderDark({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle( 
        color: color ?? AppColor.primaryGreen,  
        size: 30.r,  //35.r
      ),
    );
  }
}

class LoaderDarkSmall extends StatelessWidget {
  const LoaderDarkSmall({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle( 
        color: color ?? AppColor.primaryGreen,  
        size: 18.r,  //30.r
      ),
    );
  }
}