import 'package:flutter/cupertino.dart';
import 'package:search_app/common/theme/app_icons.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.controller,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  @override
  State<StatefulWidget> createState() => SearchFieldState();
}

class SearchFieldState extends State<SearchField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      maxLength: 256,
      prefix: Icon(AppIcons.search),
      suffix: Icon(AppIcons.close),
      textInputAction: TextInputAction.search,
      onSubmitted: widget.onSubmitted,
    );
  }
}
