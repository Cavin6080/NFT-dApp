import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:flutter/services.dart';

class TextInputField extends StatelessWidget {
  final InputBorder? errorBorder;
  final InputBorder? enabledBorder;
  final MultiValidator multiValidator;
  final bool? enabled;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final String hinttext;
  final TextInputAction? textInputAction;

  final int minLines;
  final int maxLines;
  final TextInputType? textInputType;
  final TextEditingController? editingController;
  final bool? obscureText;
  final TextStyle? hintStyle;
  final void Function()? onTogglePassword;
  final MultiValidator? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Icon? iconName;
  const TextInputField({
    Key? key,
    this.onChanged,
    this.enabled,
    this.hintStyle,
    this.textInputAction,
    required this.hinttext,
    this.contentPadding,
    this.enabledBorder,
    this.maxLength,
    this.errorBorder,
    this.textInputType,
    this.editingController,
    this.obscureText,
    this.onTogglePassword,
    this.validator,
    this.prefixIcon,
    this.iconName,
    this.minLines = 1,
    this.maxLines = 1,
    required this.multiValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // inputFormatters: name ?? [],
      maxLength: maxLength ?? 100,
      style: const TextStyle(color: Color(0xFF491CCB)),
      enabled: enabled ?? true,
      validator: validator ?? multiValidator,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      obscuringCharacter: '*',
      autovalidateMode: AutovalidateMode.disabled,
      controller: editingController,
      keyboardType: textInputType ?? TextInputType.text,
      cursorColor: const Color(0xFF2B547E),
      decoration: InputDecoration(
        errorStyle: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: Colors.red, fontSize: 12),
        counterText: '',
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
        errorMaxLines: 3,
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
        // prefixIcon: prefixIcon ?? SizedBox.shrink(),
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 15),
        border: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
        focusedBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
        hintText: hinttext,
        // label: Text(label),
        // labelStyle: TextStyle(
        //   color: Colors.red,
        // ),
        suffixIcon: obscureText != null
            ? GestureDetector(
                onTap: onTogglePassword,
                child: Icon(
                  (obscureText ?? false)
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: const Color.fromRGBO(143, 148, 251, 1),
                ),
              )
            : null,
        hintStyle: hintStyle ?? TextStyle(color: Colors.grey.shade400),
      ),
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
