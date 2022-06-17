import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view.dart';
import 'package:organizze_app/app/modules/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_bloc/login_view_bloc.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_bloc/login_view_events.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_bloc/login_view_states.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_widgets/login_input_password_widget.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_widgets/login_input_user_widget.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_widgets/login_submit_button_widget.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_widgets/login_title_widget.dart';

class LoginView extends StatefulWidget {
  static const String routName = '/login';

  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginViewBloc _bloc;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _checkboxValue = false;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<LoginViewBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 242, 245),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const LoginTitleWidget(),
                const SizedBox(
                  height: 20,
                ),
                BlocListener<LoginViewBloc, LoginViewStates>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.pushReplacementNamed(
                        context,
                        AddAccountsView.routName,
                      );
                    }
                  },
                  child: BlocBuilder<LoginViewBloc, LoginViewStates>(
                    bloc: _bloc,
                    builder: (_, state) {
                      if (state is LoginLoading) {
                        return Column(
                          children: [
                            LoginInputUserWidget(
                              textEditingController: _loginController,
                              readingOnly: true,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            LoginInputPasswordWidget(
                              textEditingController: _passwordController,
                              readingOnly: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _checkboxValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkboxValue = value!;
                                    });
                                  },
                                ),
                                const Text('Lembrar login')
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const CircularProgressIndicator(),
                          ],
                        );
                      }

                      if (state is LoginError) {
                        return Column(
                          children: [
                            LoginInputUserWidget(
                              textEditingController: _loginController,
                              errorBorder: true,
                              onChanged: (_) {
                                _bloc.add(CleanViewErrorsEvent());
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            LoginInputPasswordWidget(
                              textEditingController: _passwordController,
                              errorBorder: true,
                              onChanged: (_) {
                                _bloc.add(CleanViewErrorsEvent());
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _checkboxValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkboxValue = value!;
                                    });
                                  },
                                ),
                                const Text('Lembrar login')
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            LoginSubmitButtonWidget(onPressed: _submitButton),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 247, 122, 113),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                state.msg,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          LoginInputUserWidget(
                            textEditingController: _loginController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          LoginInputPasswordWidget(
                            textEditingController: _passwordController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _checkboxValue,
                                onChanged: (value) {
                                  setState(() {
                                    _checkboxValue = value!;
                                  });
                                },
                              ),
                              const Text('Lembrar login')
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LoginSubmitButtonWidget(onPressed: _submitButton),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitButton() {
    _bloc.add(
      VerifyLoginEvent(
        login: LoginEntity(
          user: _loginController.text,
          password: _passwordController.text,
          rememberMe: _checkboxValue,
        ),
      ),
    );
  }
}
