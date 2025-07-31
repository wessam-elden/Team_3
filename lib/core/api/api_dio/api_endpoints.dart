class Endpoints {
  //authentication
  static const String baseUrl ='http://192.168.1.18:4040/';
  static const String logIn = '${baseUrl}auth/login';
  static const String signUp = '${baseUrl}auth/signup';
  static const String getProfile = '${baseUrl}auth/profile';
  //cities and landmarks
  static const String getCities = '${baseUrl}city/all';
  static const String createcity = '${baseUrl}city/create';
  static const String getLandmarksByCityIdd = '${baseUrl}landmark/byCity/';
  static const String getLandmarks = '${baseUrl}landmark/all';
  static const String createLandmark = '${baseUrl}landmark/create';
  //visits
  static const String createVisit = '${baseUrl}visit/create';
  static const String getVisits = '${baseUrl}visit/getAll';

  //ai
  static const String chatpot = '${baseUrl}AI/chat';

}

