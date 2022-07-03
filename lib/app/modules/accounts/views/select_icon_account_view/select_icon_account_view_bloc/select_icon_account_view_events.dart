abstract class SelectIconAccountViewEvents {}

class FetchAccountIcons extends SelectIconAccountViewEvents {
  final String assetPath;

  FetchAccountIcons(this.assetPath);
}
