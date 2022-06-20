import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_dependencies.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_dependencies.dart';
import 'package:organizze_app/app/modules/login/presenter/views/splash_view/splash_view_depedencies.dart';
import 'package:provider/single_child_widget.dart';

class AppDependencies {
  static List<SingleChildWidget> dependencies() {
    return [
      ...LoginViewDependencies.providers(),
      ...SplashViewDependencies.providers(),
      ...AccountsViewDependencies.providers(),
    ];
  }
}
