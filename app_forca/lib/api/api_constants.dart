class ApiConstants{
  //base URL's
  static String playersUrl = 'http://192.168.15.60:80/players';
  static String matchesUrl = 'http://192.168.15.60:80/matches';
  static String authUrl    = 'http://192.168.15.60:80/auth';

  //endpoints
  static String getPlayers   = '/all';
  static String getMatches   = '/all-matches';
  static String addPlayer    = '/add';
  static String addMatch     = '/add-match';
  static String removePlayer = '/delete';
  static String removeMatch  = '/delete-match';
  static String getPlayer    = '/get';
  static String registerUser = '/register';
  static String loginUser    = '/login';
  static String userLoggedIn = '/is-logged';
  static String userLogout   = '/logout';
}