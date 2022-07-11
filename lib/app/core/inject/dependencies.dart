import 'package:organizze_app/app/core/models/logged_user.dart';
import 'package:organizze_app/app/modules/accounts/views/views_dependencies.dart';
import 'package:organizze_app/app/modules/login/presenter/views/view_dependencies.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppDependencies {
  static List<SingleChildWidget> dependencies() {
    return [
      Provider(create: (_) => LoggedUser()),
      ...LoginDependencies.providers(),
      ...AccountsDependencies.providers(),
    ];
  }
}
