import 'package:get/get.dart';

import '../modules/PickRole/bindings/pick_role_binding.dart';
import '../modules/PickRole/views/pick_role_view.dart';
import '../modules/forgotPass/bindings/forgot_pass_binding.dart';
import '../modules/forgotPass/views/forgot_pass_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_psycholog/views/home_psycholog_view.dart';
import '../modules/landing_psycholog/bindings/landing_psycholog_binding.dart';
import '../modules/landing_psycholog/views/landing_psycholog_view.dart';

import '../modules/manage_schedule/views/manage_schedule_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/onboarding2/bindings/onboarding2_binding.dart';
import '../modules/onboarding2/views/onboarding2_view.dart';
import '../modules/resetPass/bindings/reset_pass_binding.dart';
import '../modules/resetPass/views/reset_pass_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/signup_psychologst/bindings/signup_psychologst_binding.dart';
import '../modules/signup_psychologst/views/signup_psychologst_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING_PSYCHOLOG;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING2,
      page: () => const Onboarding2View(),
      binding: Onboarding2Binding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_PSYCHOLOGST,
      page: () => const SignupPsychologstView(),
      binding: SignupPsychologstBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SignInView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LANDING_PSYCHOLOG,
      page: () => const LandingPsychologView(),
      binding: LandingPsychologBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PSYCHOLOG,
      page: () => const HomePsychologView(),
    ),
    GetPage(
      name: _Paths.PICK_ROLE,
      page: () => const PickRoleView(),
      binding: PickRoleBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASS,
      page: () => const ForgotPassView(),
      binding: ForgotPassBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASS,
      page: () => const ResetPassView(),
      binding: ResetPassBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_SCHEDULE,
      page: () => const ManageScheduleView(),
    ),
  ];
}
