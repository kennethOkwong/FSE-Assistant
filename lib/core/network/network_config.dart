class NetworkConfig {
  static String developmentBaseUrl = 'your_dev_base_url_here';
  static String releaseBaseUrl = 'your_release_base_url_here';
  static String googelMapsBaseUrl = 'https://maps.googleapis.com/maps';
}

//app Flavours
enum Flavour {
  development,
  release,
}

class Config {
  static Flavour? appFlavour;

  static String get baseUrl {
    switch (appFlavour) {
      case Flavour.development:
        return NetworkConfig.developmentBaseUrl;
      case Flavour.release:
        return NetworkConfig.releaseBaseUrl;
      default:
        return '';
    }
  }
}
