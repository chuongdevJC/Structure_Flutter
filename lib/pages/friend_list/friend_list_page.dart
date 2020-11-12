import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter/bloc/bloc.dart';
import 'package:structure_flutter/core/common/helpers/random_helper.dart';
import 'package:structure_flutter/core/resource/app_colors.dart';
import 'package:structure_flutter/core/resource/icon_style.dart';
import 'package:structure_flutter/data/entities/account.dart';
import 'package:structure_flutter/data/source/remote/friend_remote_datasource.dart';
import 'package:structure_flutter/di/injection.dart';
import 'package:structure_flutter/widgets/app_bar_widget.dart';
import 'package:structure_flutter/widgets/loading_widget.dart';
import 'package:structure_flutter/widgets/snackbar_widget.dart';

import 'widgets/friend_profile.dart';

class FriendListPage extends StatefulWidget {
  String currentUid;
  String currentUserName;

  FriendListPage(this.currentUid, this.currentUserName);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<FriendListPage> {
  final _snackBar = getIt<SnackBarWidget>();

  final _friendBloc = getIt<FriendBloc>();

  final _random = getIt<RandomHelper>();

  @override
  void dispose() {
    _friendBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    _friendBloc.add(InitializeFriendList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        elevation: 0,
        backgroundColor: AppColors.outer_space,
        leading: AppIcons.account_box_rounded,
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
      ),
      body: BlocListener(
        cubit: _friendBloc,
        listener: (BuildContext context, FriendState state) {
          _snackBar.buildContext = context;
          if (state is Loading) {
            Loading();
          }
          if (state is Failure) {
            _snackBar.failure("Something went wrong !");
          }
          if (state is Success) {
            _snackBar.success("Looking for friends near you !");
          }
        },
        child: _onRenderGridFriend(),
      ),
    );
  }

  Widget _onRenderGridFriend() {
    return BlocBuilder(
      cubit: _friendBloc,
      builder: (BuildContext context, FriendState state) {
        if (state is Loading) {
          return Loading();
        }
        if (state is Failure) {
          _snackBar.failure("Something went wrong !");
        }
        if (state is Success) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  crossAxisCount: 2,
                  children: state.accounts.map((Account account) {
                    return _buildGridView(account);
                  }).toList(),
                ),
              ),
            ],
          );
        }
        return Loading();
      },
    );
  }

  Widget _buildGridView(Account recipient) {
    return FriendProfile(
      name: recipient.name,
      image: recipient.image,
      followers: _random.followers(),
      colors: _random.colors(),
      feed: _random.feed(),
      onPressed: () => _onSendRequestPressed(
        recipient.id,
        recipient.name,
        widget.currentUid,
        widget.currentUserName,
      ),
      isActiveButton: true,
    );
  }

  void _onSendRequestPressed(
    String recipientID,
    String recipientName,
    String currentUserID,
    String currentUserName,
  ) {
    _friendBloc.add(MakingFriendRequest(
      currentUserID,
      currentUserName,
      recipientID,
      recipientName,
    ));
  }
}
