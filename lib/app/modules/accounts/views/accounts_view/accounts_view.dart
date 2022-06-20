import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_bloc/accounts_view_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_bloc/accounts_view_events.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_bloc/accounts_view_states.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/widgets/account_card_widget.dart';
import 'package:organizze_app/app/modules/login/domain/entities/logged_user_entity.dart';

class AddAccountsView extends StatefulWidget {
  static const String routName = '/addAccounts';

  final LoggedUserEntity loggedUser;

  const AddAccountsView({Key? key, required this.loggedUser}) : super(key: key);

  @override
  State<AddAccountsView> createState() => _AddAccountsViewState();
}

class _AddAccountsViewState extends State<AddAccountsView> {
  late final AccountsViewBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = context.read<AccountsViewBloc>();
    _bloc.add(FetchAccounts(widget.loggedUser.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 245),
      appBar: AppBar(
        title: const Text('Contas'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<AccountsViewBloc, AccountsViewStates>(
        bloc: _bloc,
        builder: (_, state) {
          if (state is AccountsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AccountsError) {
            return Center(
              child: Text(state.msg),
            );
          }

          if (state is AccountsSuccess) {
            return ListView.builder(
              itemCount: state.accounts.length,
              itemBuilder: (_, index) {
                return AccountCardWidget(
                  icon: Image.asset(
                    'assets/images/login_icons/dollar-symbol.png',
                    scale: 1,
                  ),
                  title: Text(state.accounts[index].name),
                  currentBalance: state.accounts[index].balance.toString(),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
