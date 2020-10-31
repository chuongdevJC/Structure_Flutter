import 'package:flutter/material.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/text_style.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        gradient: LinearGradient(colors: [
          AppColors.blueAccentColor,
          AppColors.lightBlueAccentColor
        ]),
        color: AppColors.lightBlueColor,
      ),
      child: FlatButton(
        onPressed: _onPressed,
        child: Text(
          'LOGIN',
          style: AppStyles.white_bold_11,
        ),
      ),
    );
  }
}