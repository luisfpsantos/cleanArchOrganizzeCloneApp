class SaveLoginLocalErrors implements Exception {
  final String msg;

  SaveLoginLocalErrors(this.msg);
}

class UnableToSaveLoginLocal extends SaveLoginLocalErrors {
  UnableToSaveLoginLocal(super.msg);
}
