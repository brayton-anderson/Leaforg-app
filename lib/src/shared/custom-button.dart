import 'package:flutter/material.dart';
import 'constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.width,
      this.height,
      this.color,
      this.textColor,
      this.icon})
      : super(key: key);

  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final Widget icon;
  final String text;
  final VoidCallback onPressed;

  Widget build(BuildContext context) {
    double width = this.width;
    double height = this.height;
    AppScale scale = AppScale(context);
    Text text =
        Text(this.text, style: TextStyle(fontSize: scale.ofHeight(0.019)));

    if (this.width != null && this.width <= 1) {
      width = scale.ofWidth(this.width);
    }

    if (this.height != null && this.height <= 1) {
      height = scale.ofHeight(this.height);
    }

    return Container(
      width: 180,
      height: 45,
      child: Center(
        child: RawMaterialButton(
          // borderSide: BorderSide(color: Colors.white),
          fillColor: color,
          elevation: 5,
          textStyle: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          child: icon == null
              ? text
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Padding(
                        child: icon,
                        padding: EdgeInsets.all(5),
                      ),
                      text
                    ]),
          splashColor: Theme.of(context).secondaryHeaderColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
