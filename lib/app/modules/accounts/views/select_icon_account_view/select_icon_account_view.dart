import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/select_icon_account_view/select_icon_account_view_bloc/select_icon_account_view_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/select_icon_account_view/select_icon_account_view_bloc/select_icon_account_view_events.dart';
import 'package:organizze_app/app/modules/accounts/views/select_icon_account_view/select_icon_account_view_bloc/select_icon_account_view_states.dart';
import 'package:organizze_app/app/modules/accounts/views/select_icon_account_view/widgets/card_icon_widget.dart';

class SelectIconAccountView extends StatefulWidget {
  static const String routeName = '/selectIconAccount';
  const SelectIconAccountView({Key? key}) : super(key: key);

  @override
  State<SelectIconAccountView> createState() => _SelectIconAccountViewState();
}

class _SelectIconAccountViewState extends State<SelectIconAccountView> {
  late final SelectIconAccountViewBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<SelectIconAccountViewBloc>();
    _bloc.add(FetchAccountIcons('assets/images/account_icons'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Selecione um icone',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: BlocBuilder<SelectIconAccountViewBloc, SelectIconAccountViewStates>(
        bloc: _bloc,
        builder: (_, state) {
          if (state is IconsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is IconsError) {
            return Center(
              child: Text(state.msg),
            );
          }

          if (state is IconsSuccess) {
            return ListView.separated(
              itemCount: state.icons.length,
              separatorBuilder: (__, _) => const Divider(),
              itemBuilder: (_, index) => CardIconWidget(
                icon: Image.asset(
                  state.icons[index].path,
                  scale: 2,
                ),
                title: Text(
                  state.icons[index].name.replaceAll('.png', ''),
                ),
                onTap: () {
                  Navigator.pop(context, state.icons[index]);
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
