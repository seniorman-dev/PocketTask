import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pockettask/view/utils/components/loader.dart';






class BroomButton extends StatefulWidget {
  BroomButton({
    super.key, 
    this.onPressed, 
    //required this.backgroundColor, 
    required this.text, 
    //required this.textColor,
    RxBool? isLoading, // Nullable parameter

  }) : isLoading = isLoading ?? RxBool(false);
  
  final RxBool isLoading;  
  final VoidCallback? onPressed;
  //final Color backgroundColor; // List of colors for the gradient
  //final Color textColor;
  final String text;

  @override
  State<BroomButton> createState() => _BroomButtonState();
}

class _BroomButtonState extends State<BroomButton> with SingleTickerProviderStateMixin {


  late final AnimationController _controller;
  
  //handles the animation upon press
  Future<void> handlePress() async {
    if (widget.onPressed == null) {
      _controller.forward().then((_) => _controller.reverse());
      HapticFeedback.heavyImpact();
    }
    else {
      _controller.forward().then((_) => _controller.reverse());
      HapticFeedback.heavyImpact();
      widget.onPressed!();
    }
    return;
  }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: (1.0 + (0.1 * _controller.value)).clamp(1.0, 1.05),
          child: GestureDetector(
            onTap: () => handlePress(), ///widget.onPressed,
            child: Obx(
              () {
                return Container(
                  //height: 70.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: widget.isLoading.value ? LoaderDark(color: Theme.of(context).textTheme.bodyMedium!.color,) : Text(
                    widget.text,
                    style: GoogleFonts.nunito(
                      //height: 18.4.sp,
                      color: Theme.of(context).textTheme.bodyMedium!.color, //widget.textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ), 
                    textAlign: TextAlign.center,
                  )
                       
                );
              }
            ),
          ),
        );
      }
    );
  }
}






class BroomIconButton extends StatefulWidget {
  BroomIconButton({
    super.key, 
    this.onPressed, 
    required this.icon, 
    RxBool? isLoading, // Nullable parameter
  }) : isLoading = isLoading ?? RxBool(false);
  final RxBool isLoading;  
  final VoidCallback? onPressed;
  final IconData icon;

  @override
  State<BroomIconButton> createState() => _BroomIconButtonState();
}

class _BroomIconButtonState extends State<BroomIconButton> with SingleTickerProviderStateMixin {


  late final AnimationController _controller;
  
  //handles the animation upon press
  Future<void> handlePress() async {
    if (widget.onPressed == null) {
      _controller.forward().then((_) => _controller.reverse());
      HapticFeedback.heavyImpact();
    }
    else {
      _controller.forward().then((_) => _controller.reverse());
      HapticFeedback.heavyImpact();
      widget.onPressed!();
    }
    return;
  }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: (1.0 + (0.1 * _controller.value)).clamp(1.0, 1.05),
          child: GestureDetector(
            onTap: () => handlePress(), ///widget.onPressed,
            child: Obx(
              () {
                return Container(
                  //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    //borderRadius: BorderRadius.circular(20.r),
                    shape: BoxShape.circle
                  ),
                  child: widget.isLoading.value 
                  ?LoaderDark(color: Theme.of(context).iconTheme.color)
                  :Icon(
                    size: 20.r,
                    color: Theme.of(context).iconTheme.color,
                    widget.icon,
                  ),
                       
                );
              }
            ),
          ),
        );
      }
    );
  }
}

