class GetListIconsErrors {
  final String msg;

  GetListIconsErrors(this.msg);
}

class NoAssetsFound extends GetListIconsErrors {
  NoAssetsFound(super.msg);
}
