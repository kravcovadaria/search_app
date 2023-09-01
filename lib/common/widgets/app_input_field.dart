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
    this.counterText = '',
    this.hint = '',
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
  final String counterText;
  final String hint;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon, suffixIcon;
  final Function(String)? onPrefixPressed, onSuffixPressed;
  final Function(String)? onSubmitted;

  @override
  State<StatefulWidget> createState() => AppInputFieldState();
}

class AppInputFieldState extends State<AppInputField> {
  late TextEditingController controller;
  late FocusNode focus;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: widget.text);
    focus = FocusNode()..addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(covariant AppInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text && widget.text != controller.text) {
      controller.text = widget.text;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    focus.removeListener(_onFocusChange);
    focus.dispose();
    super.dispose();
  }

  void _onFocusChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    ThemeData defaultTheme = Theme.of(context);
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.r),
      borderSide: const BorderSide(color: Colors.transparent),
    );
    return Theme(
      data: defaultTheme.copyWith(
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (!widget.enabled) {
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
      child: TextFormField(
        focusNode: focus,
        controller: controller,
        maxLength: widget.maxLength,
        maxLines: 1,
        enabled: widget.enabled,
        style: defaultTheme.textTheme.bodyMedium,
        decoration: InputDecoration(
          counterText: widget.counterText,
          counterStyle:
              widget.counterText.isEmpty ? const TextStyle(fontSize: 0) : null,
          label: Text(
            widget.hint,
            style: defaultTheme.textTheme.displaySmall,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: defaultBorder,
          enabledBorder: defaultBorder,
          focusedBorder: defaultBorder.copyWith(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.r,
            ),
          ),
          contentPadding: EdgeInsets.all(16.r),
          disabledBorder: defaultBorder,
          fillColor:
              focus.hasFocus ? defaultTheme.hoverColor : defaultTheme.cardColor,
          filled: true,
          prefixIcon: widget.prefixIcon == null
              ? null
              : IconButton(
                  iconSize: 24.r,
                  padding: EdgeInsets.fromLTRB(16.r, 10.r, 10.r, 10.r),
                  color: (!widget.enabled)
                      ? defaultTheme.disabledColor
                      : defaultTheme.primaryColor,
                  icon: Icon(
                    size: 24.r,
                    widget.prefixIcon,
                  ),
                  onPressed: () =>
                      widget.onPrefixPressed?.call(controller.value.text),
                ),
          suffixIcon: widget.suffixIcon == null
              ? null
              : widget.enabled
                  ? IconButton(
                      iconSize: 24.r,
                      padding: EdgeInsets.fromLTRB(10.r, 10.r, 16.r, 10.r),
                      color: (!widget.enabled)
                          ? defaultTheme.disabledColor
                          : defaultTheme.primaryColor,
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
        ),
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onSubmitted,
      ),
    );
  }
}
