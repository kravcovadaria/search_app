import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_app/common/theme/app_icons.dart';

class AppInputField extends StatefulWidget {
  const AppInputField({
    super.key,
    this.controller,
    this.enabled = true,
    this.maxLength,
    this.text = '',
    this.counterText,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.onPrefixPressed,
    this.onSuffixPressed,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final bool enabled;
  final int? maxLength;
  final String text;
  final String? counterText;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon, suffixIcon;
  final Function(String)? onPrefixPressed, onSuffixPressed;
  final Function(String)? onSubmitted;

  @override
  State<StatefulWidget> createState() => AppInputFieldState();
}

class AppInputFieldState extends State<AppInputField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: widget.text);
  }

  @override
  void didUpdateWidget(covariant AppInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text &&
        widget.text != controller.text) {
      controller.text = widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData defaultTheme = Theme.of(context);
    return Theme(
      data: defaultTheme.copyWith(
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return defaultTheme.disabledColor;
                }
                return defaultTheme.primaryColor;
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Colors.transparent;
              },
            ),
          ),
        ),
      ),
      // child: TextField(
      child: CupertinoTextField(
        controller: controller,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        // decoration: InputDecoration(
        //   contentPadding: EdgeInsets.symmetric(horizontal: 10.r),
        // counterText: widget.counterText,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: defaultTheme.cardColor,
        ),
        prefix: widget.prefixIcon == null
            ? null
            : IconButton(
                iconSize: 24.r,
                icon: Icon(
                  size: 24.r,
                  widget.prefixIcon,
                ),
                onPressed: () =>
                    widget.onPrefixPressed?.call(controller.value.text),
              ),
        suffix: widget.suffixIcon == null
            ? null
            : widget.enabled
                ? IconButton(
                    iconSize: 24.r,
                    icon: Icon(
                      size: 24.r,
                      widget.suffixIcon!,
                    ),
                    onPressed: () =>
                        widget.onSuffixPressed?.call(controller.value.text),
                  )
                : IconButton(
                    iconSize: 24.r,
                    icon: const Icon(AppIcons.ban),
                    onPressed: null,
                  ),
        textInputAction: widget.textInputAction,
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
