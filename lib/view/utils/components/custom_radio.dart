import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';







class CustomRadioButton extends StatefulWidget {
  final Color radioColor;
  final bool isSelected;
  final VoidCallback onSelect;

  const CustomRadioButton({
    required this.radioColor,
    required this.isSelected,
    required this.onSelect,
    super.key,
  });

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
        width: 20.w,
        height: 20.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.isSelected ? widget.radioColor : widget.radioColor,
            width: 2,
          ),
        ),
        child: widget.isSelected
        ?Center(
          child: Container(
            width: 10.w,
            height: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.radioColor,
            ),
          ),
        )
        : null,
      ),
    );
  }
}


