// 161.35.209.168 ///production
// 167.99.135.221//dev

class AppApiPaths {
  static const String url = "https://todo.iraqsapp.com";
  static const String auth = '$url/auth';
  static const String imageUrl = '$url//images/';

  static String setImageUrl(String image) {
    if (image.contains(url)) {
      return image;
    } else {
      return imageUrl + image;
    }
  }

  //auth
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String refreshToken = '$auth/refresh-token';
  static const String logout = '$auth/logout';
  static const String profile = '$auth/profile';

  //home
  static const String todo = '$url/todos';
  static const String uploadImage = '$url/upload/image';
}
