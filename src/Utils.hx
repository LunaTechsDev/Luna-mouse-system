using StringTools;

class Utils {
  public static function parseFilename(path: String, ?ext: Bool = true): String {
    var filename = path.substr(path.lastIndexOf('/')).replace('/', '');
    if (ext) {
      return filename;
    }
    return filename.replace('.png', '');
  }
}