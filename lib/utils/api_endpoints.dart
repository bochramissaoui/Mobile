class ApiEndPoints{

  // static final String baseUrl="http://192.168.137.13:8080";

  // Emulator:
  static final String baseUrl="http://10.0.2.2:8080";

  // Pre-prod :
  // static final String baseUrl="https://api-pre-prod-maps.relead.tn";

  static _AuthEndPoints authEndpoints= _AuthEndPoints();
}

class _AuthEndPoints {
  final String register="/api/v1/consumer/add";
  final String login="/api/v1/consumer/login";
  final String getCurrentUserInfo="/api/v1/consumer/get/info";

  final String registerToken="/api/v1/consumer/registerCode?emailToken=";

  final String oldEmailToken="/api/v1/consumer/oldEmail?oldEmailToken=";
  final String sendOldEmailToken="/api/v1/consumer/oldEmailCode";
  final String newEmailToken="/api/v1/consumer/newEmail?newEmail="; //&newEmailToken=
  final String sendNewEmailToken="/api/v1/consumer/newEmailCode?newEmail=";

  final String sendForgotPasswordToken="/api/v1/consumer/forgotPassword?email=";
  final String forgotPasswordToken="/api/v1/consumer/confirmPasswordCode?resetToken=";
  final String newPassword="/api/v1/consumer/resetPassword?email="; //&newPassword=

  final String sendPhoneToken="/api/v1/consumer/sendSMS?phone=";
  final String verifyPhone="/api/v1/consumer/verifyOTP?code="; //&phone=

  final String getZones="/api/v1/zone/get/all";
  final String getCategories="/api/v1/category/get/all";
  final String getSubCategories="/api/v1/subCategory/get/all";

  final String uploadImage="/api/v1/consumer/image";
}