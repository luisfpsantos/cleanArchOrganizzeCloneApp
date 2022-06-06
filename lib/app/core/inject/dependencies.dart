import 'package:organizze_app/app/login/presenter/views/login_view/login_view_dependencies.dart';
import 'package:provider/single_child_widget.dart';

class AppDependencies {
  static List<SingleChildWidget> dependencies() {
    return [
      ...LoginViewDependencies.providers(),
    ];
  }
}
