class ApiConnection {
  static const hostConnect = "http://192.168.254.106/api_myApp";
  static const hostConnectUser = "$hostConnect/user";

  // SignUp user
  static const validateEmail = "$hostConnectUser/validate_email.php";
  static const signUp = "$hostConnectUser/signup.php";
}
