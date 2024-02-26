import 'package:flutter/material.dart';

class HCButton extends StatefulWidget {
  Function? onPressed;
  String text;
  Color? backgroundColor;
  Color? textColor;

  HCButton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor = const Color(0xFFFFD470),
    this.textColor = const Color(0xFF000000),
  });

  @override
  State<StatefulWidget> createState() {
    return _HCButtonState();
  }
}

class _HCButtonState extends State<HCButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      padding: EdgeInsets.zero,
      child: TextButton(
        onPressed: () => widget.onPressed?.call(),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(100, 40)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(widget.backgroundColor),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
