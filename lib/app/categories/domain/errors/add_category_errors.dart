class AddCategoryErrors implements Exception {
  final String msg;

  AddCategoryErrors(this.msg);
}

class InvalidArgument extends AddCategoryErrors {
  InvalidArgument(super.msg);
}

class AddError extends AddCategoryErrors {
  AddError(super.msg);
}

class RepositoryError extends AddCategoryErrors {
  RepositoryError(super.msg);
}
