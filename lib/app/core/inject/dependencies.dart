import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/login/external/datasources/firebase/verify_login_datasource_imp.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppDependencies {
  static List<SingleChildWidget> dependencies() {
    return [
      Provider(
          create: (_) => VerifyLoginDatasourceImp(FirebaseFirestore.instance))
    ];
  }
}
