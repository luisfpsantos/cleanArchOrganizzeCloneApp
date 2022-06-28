import 'package:organizze_app/app/modules/accounts/views/views_dependencies.dart';
import 'package:organizze_app/app/modules/login/presenter/views/view_dependencies.dart';
import 'package:provider/single_child_widget.dart';

class AppDependencies {
  static List<SingleChildWidget> dependencies() {
    return [
      ...LoginDependencies.providers(),
      ...AccountsDependencies.providers(),
    ];
  }
}
