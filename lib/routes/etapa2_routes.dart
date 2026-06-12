import 'package:flutter/widgets.dart';

import '../screens/etapa2/create_account_screen.dart';
import '../screens/etapa2/face_id_authentication_screen.dart';
import '../screens/etapa2/going_to_dashboard_screen.dart';
import '../screens/etapa2/login_screen.dart';
import '../screens/etapa2/personal_details_screen.dart';
import '../screens/etapa2/reset_password_screen.dart';
import '../screens/etapa2/verification_success_screen.dart';
import '../screens/etapa2/verify_identity_screen.dart';

class Etapa2Routes {
  static const String createAccount = '/etapa2/create-account';
  static const String personalDetails = '/etapa2/personal-details';
  static const String login = '/etapa2/login';
  static const String resetPassword = '/etapa2/reset-password';
  static const String verifyIdentity = '/etapa2/verify-identity';
  static const String verificationSuccess = '/etapa2/verification-success';
  static const String faceIdAuthentication = '/etapa2/face-id';
  static const String goingToDashboard = '/etapa2/going-to-dashboard';

  static Map<String, WidgetBuilder> get routes => {
    personalDetails: (context) => const PersonalDetailsScreen(),
    createAccount: (context) => const CreateAccountScreen(),
    login: (context) => const LoginScreen(),
    resetPassword: (context) => const ResetPasswordScreen(),
    verifyIdentity: (context) => const VerifyIdentityScreen(),
    verificationSuccess: (context) => const VerificationSuccessScreen(),
    faceIdAuthentication: (context) => const FaceIdAuthenticationScreen(),
    goingToDashboard: (context) => const GoingToDashboardScreen(),
  };
}
