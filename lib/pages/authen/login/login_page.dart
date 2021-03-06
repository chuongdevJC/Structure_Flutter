import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/icon_style.dart';
import 'package:structure_flutter/core/resource/text_style.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/widgets/app_bar_widget.dart';
import 'widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = getIt<LoginBloc>();

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Row(
          children: [
            AppIcons.chat_blue,
            SizedBox(width: 10),
            Text('Chat chit', style: AppStyles.blue_18),
          ],
        ),
        backgroundColor: AppColors.white_10,
        isCenterTitle: true,
        elevation: 0,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => _loginBloc,
        child: LoginForm(),
      ),
    );
  }
}
