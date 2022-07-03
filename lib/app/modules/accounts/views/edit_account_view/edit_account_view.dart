import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';
import 'package:organizze_app/app/modules/accounts/views/edit_account_view/edit_account_viw_bloc/edit_account_view_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/edit_account_view/edit_account_viw_bloc/edit_account_view_events.dart';
import 'package:organizze_app/app/modules/accounts/views/edit_account_view/edit_account_viw_bloc/edit_account_view_states.dart';
import 'package:organizze_app/app/modules/accounts/views/edit_account_view/widgets/remove_account_modal_bottom_widget.dart';
import 'package:organizze_app/app/modules/accounts/views/select_icon_account_view/select_icon_account_view.dart';

class EditAccountView extends StatefulWidget {
  static const String routName = '/editAccount';
  final dynamic arguments;

  const EditAccountView({Key? key, required this.arguments}) : super(key: key);

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  bool accountNameChange = false;
  IconEntity? icon;
  bool iconSelected = false;
  String accountNameController = '';
  late final EditAccountViewBloc _bloc;
  final balanceFormatter = CurrencyTextInputFormatter(
    locale: 'pt',
    symbol: 'R\$',
  );

  @override
  void initState() {
    super.initState();
    _bloc = context.read<EditAccountViewBloc>();
    _bloc.add(ToEditAccountDefault());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.arguments['account'].name),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _deleteAccount,
            icon: const Icon(
              Icons.delete_forever,
              size: 30,
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saldo Atual',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[800],
                        ),
                      ),
                      TextFormField(
                          initialValue: balanceFormatter.format(
                            widget.arguments['account'].balance
                                .toStringAsFixed(2),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [balanceFormatter],
                          onChanged: (text) {
                            _bloc.add(OnEditAccountChangeEvent());
                          }),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Nome da conta',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[800],
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.arguments['account'].name,
                        keyboardType: TextInputType.text,
                        onChanged: (text) {
                          accountNameChange = true;
                          accountNameController = text;
                          _bloc.add(OnEditAccountChangeEvent());
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Icone da conta',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.grey[600],
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            SelectIconAccountView.routeName,
                          );
                          if (result is IconEntity) {
                            iconSelected = true;
                            _bloc.add(OnEditAccountChangeEvent());
                            setState(() {
                              icon = result;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            iconSelected
                                ? Image.asset(
                                    icon!.path,
                                    scale: 10,
                                  )
                                : Image.asset(
                                    widget.arguments['account'].icon.path,
                                    scale: 10,
                                  ),
                            const SizedBox(width: 10),
                            iconSelected
                                ? Text(icon!.name.replaceAll('.png', ''))
                                : Text(widget.arguments['account'].icon.name),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                  BlocListener<EditAccountViewBloc, EditAccountViewStates>(
                    bloc: _bloc,
                    listener: (_, state) {
                      if (state is EditAccountSuccessState) {
                        Future.delayed(const Duration(milliseconds: 500)).then(
                          (_) => Navigator.pop(context, true),
                        );
                      }

                      if (state is RemoveAccountSuccessState) {
                        Future.delayed(const Duration(milliseconds: 500)).then(
                          (_) => Navigator.pop(context, true),
                        );
                      }

                      if (state is EditAccountErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.msg)),
                        );
                      }
                    },
                    child:
                        BlocBuilder<EditAccountViewBloc, EditAccountViewStates>(
                      bloc: _bloc,
                      builder: (_, state) {
                        if (state is EditAccountButtonEnable) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: SizedBox(
                              height: 70,
                              width: 70,
                              child: FloatingActionButton(
                                child: const Icon(
                                  Icons.check,
                                ),
                                onPressed: () {
                                  _bloc.add(
                                    OnEditAccountEvent(
                                      AccountEntity(
                                          id: widget.arguments['account'].id,
                                          balance: balanceFormatter
                                              .getUnformattedValue()
                                              .toDouble(),
                                          name: accountNameChange
                                              ? accountNameController
                                              : widget
                                                  .arguments['account'].name,
                                          icon: iconSelected
                                              ? icon!
                                              : widget
                                                  .arguments['account'].icon),
                                      widget.arguments['loggedUser'].userId,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }

                        if (state is EditAccountLoadingState) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: SizedBox(
                              height: 70,
                              width: 70,
                              child: FloatingActionButton(
                                enableFeedback: false,
                                splashColor: Colors.transparent,
                                child: const CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: FloatingActionButton(
                              enableFeedback: false,
                              splashColor: Colors.transparent,
                              elevation: 0,
                              backgroundColor: Colors.grey,
                              child: const Icon(
                                Icons.check,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _deleteAccount() {
    showModalBottomSheet(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      context: context,
      builder: (_) => RemoveAccountModalBottomWidget(onRemove: () {
        _bloc.add(
          OnRemoveAccountEvent(
            widget.arguments['loggedUser'].userId,
            widget.arguments['account'].id,
          ),
        );
        Navigator.pop(context);
      }),
    );
  }
}
