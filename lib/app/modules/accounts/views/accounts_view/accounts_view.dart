import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_bloc/accounts_view_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_bloc/accounts_view_events.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_bloc/accounts_view_states.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/widgets/account_card_widget.dart';
import 'package:organizze_app/app/modules/accounts/views/add_account_view/add_account_view.dart';
import 'package:organizze_app/app/modules/accounts/views/edit_account_view/edit_account_view.dart';
import 'package:organizze_app/app/modules/login/domain/entities/user_entity.dart';

class AccountsView extends StatefulWidget {
  static const String routName = '/accounts';
  final UserEntity loggedUser;

  const AccountsView({Key? key, required this.loggedUser}) : super(key: key);

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {
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
            onPressed: addAccountButton,
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
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
              child: Text(
                state.msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[700],
                ),
              ),
            );
          }

          if (state is AccountsSuccess) {
            return ListView.builder(
              itemCount: state.accounts.length,
              itemBuilder: (_, index) {
                return AccountCardWidget(
                  icon: Image.asset(
                    state.accounts[index].icon.path,
                    scale: 1,
                  ),
                  title: Text(
                    state.accounts[index].name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  currentBalance:
                      state.accounts[index].balance.toStringAsFixed(2),
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      EditAccountView.routName,
                      arguments: {
                        'loggedUser': widget.loggedUser,
                        'account': state.accounts[index]
                      },
                    );
                    if (result == true) {
                      _bloc.add(FetchAccounts(widget.loggedUser.userId));
                    }
                  },
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }

  void addAccountButton() async {
    var result = await showModalBottomSheet(
      isScrollControlled: true,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (_) => AddAccountView(loggedUser: widget.loggedUser),
    );
    if (result == true) {
      _bloc.add(FetchAccounts(widget.loggedUser.userId));
    }
  }
}
