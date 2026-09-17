import 'package:flutter/widgets.dart';

import '../presentation/auth/create_account_screen.dart';
import '../presentation/auth/face_id_authentication_screen.dart';
import '../presentation/auth/going_to_dashboard_screen.dart';
import '../presentation/auth/login_screen.dart';
import '../presentation/auth/personal_details_screen.dart';
import '../presentation/auth/reset_password_screen.dart';
import '../presentation/auth/verification_success_screen.dart';
import '../presentation/auth/verify_identity_screen.dart';
class AuthRoutes {
  static const String createAccount = '/auth/create-account';
  static const String personalDetails = '/auth/personal-details';
  static const String login = '/auth/login';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyIdentity = '/auth/verify-identity';
  static const String verificationSuccess = '/auth/verification-success';
  static const String faceIdAuthentication = '/auth/face-id';
  static const String goingToDashboard = '/auth/going-to-dashboard';

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
