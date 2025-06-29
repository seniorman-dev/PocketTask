import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pockettask/view/utils/theme/app_color.dart';






class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, this.initialValue, this.readOnly = false, this.icon, required this.onChanged, this.hintText, required this.keyboardType, required this.textInputAction, this.textController, this.onFocusChanged, this.validator, this.onTap, this.inputFormatters});
  final Icon? icon;
  final bool readOnly;
  final TextEditingController? textController;
  final TextInputType keyboardType;
  final String? hintText;
  final String? initialValue;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 6,
        minLines: 1,
        inputFormatters: widget.inputFormatters,
        enableSuggestions: true,
        //enableInteractiveSelection: true,
        initialValue: widget.initialValue,
        cursorColor: Theme.of(context).textTheme.bodySmall!.color,
        style: GoogleFonts.nunito(color: Theme.of(context).textTheme.bodySmall!.color, fontSize: 14.sp, fontWeight: FontWeight.w400),    
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(    
          prefixIcon: widget.icon,
          //SvgPicture.asset(widget.icon, height: 20.h, width: 20.w,), 
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),   
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(color: AppColor.inactiveGrey.withOpacity(0.2)), // Set the color you prefer
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(color: AppColor.inactiveGrey.withOpacity(0.2)), // Set the color you prefer
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(color: AppColor.primaryGreen), // Set the color you prefer
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide(color: AppColor.errorRed), // Set the color you prefer
          ),
          fillColor: AppColor.inactiveGrey.withOpacity(0.3), 
          filled: true,    
          hintText: widget.hintText,
          hintStyle: GoogleFonts.nunito(color: Theme.of(context).textTheme.bodySmall!.color, fontSize: 14.sp, fontWeight: FontWeight.w400), 
          errorStyle: GoogleFonts.nunito(color: AppColor.errorRed, fontSize: 14.sp, fontWeight: FontWeight.w400), 
        ),
      ),
    );
  }
}


