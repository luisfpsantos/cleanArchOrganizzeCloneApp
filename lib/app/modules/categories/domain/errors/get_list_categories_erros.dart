class GetListCategoriesErrors implements Exception {
  final String msg;

  GetListCategoriesErrors(this.msg);
}

class NoCategoriesFound extends GetListCategoriesErrors {
  NoCategoriesFound(super.msg);
}

class RepositoryError extends GetListCategoriesErrors {
  RepositoryError(super.msg);
}
