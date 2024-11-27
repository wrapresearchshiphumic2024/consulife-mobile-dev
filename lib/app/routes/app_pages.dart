import 'package:get/get.dart';

import '../modules/PickRole/bindings/pick_role_binding.dart';
import '../modules/PickRole/views/pick_role_view.dart';

import '../modules/ProfilePycholog/bindings/profile_pycholog_binding.dart';
import '../modules/ProfilePycholog/views/profile_pycholog_view.dart';
import '../modules/PsiResetPass/bindings/psi_reset_pass_binding.dart';
import '../modules/PsiResetPass/views/psi_reset_pass_view.dart';
import '../modules/PsikologChaPass/bindings/psikolog_cha_pass_binding.dart';
import '../modules/PsikologChaPass/views/psikolog_cha_pass_view.dart';
import '../modules/PsikologHistory/bindings/psikolog_history_binding.dart';
import '../modules/PsikologHistory/views/psikolog_history_view.dart';
import '../modules/PsikologPerInfo/bindings/psikolog_per_info_binding.dart';
import '../modules/PsikologPerInfo/views/psikolog_per_info_view.dart';
import '../modules/PsikologProDet/bindings/psikolog_pro_det_binding.dart';
import '../modules/PsikologProDet/views/psikolog_pro_det_view.dart';

import '../modules/edit_schedule/bindings/edit_schedule_binding.dart';
import '../modules/edit_schedule/views/edit_schedule_view.dart';

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

      name: _Paths.PROFILE_PYCHOLOG,
      page: () => const ProfilePychologView(),
      binding: ProfilePychologBinding(),
    ),
    GetPage(
      name: _Paths.PSIKOLOG_HISTORY,
      page: () => const PsikologHistoryView(),
      binding: PsikologHistoryBinding(),
    ),
    GetPage(
      name: _Paths.PSIKOLOG_PER_INFO,
      page: () => const PsikologPerInfoView(),
      binding: PsikologPerInfoBinding(),
    ),
    GetPage(
      name: _Paths.PSIKOLOG_PRO_DET,
      page: () => const PsikologProDetView(),
      binding: PsikologProDetBinding(),
    ),
    GetPage(
      name: _Paths.PSIKOLOG_CHA_PASS,
      page: () => const PsikologChaPassView(),
      binding: PsikologChaPassBinding(),
    ),
    GetPage(
      name: _Paths.PSI_RESET_PASS,
      page: () => const PsiResetPassView(),
      binding: PsiResetPassBinding(),
    ), 
    GetPage(

      name: _Paths.MANAGE_SCHEDULE,
      page: () => const ManageScheduleView(),
    ),
    GetPage(
      name: _Paths.EDIT_SCHEDULE,
      page: () => const EditScheduleView(),
      binding: EditScheduleBinding(),

    ),
  ];
}
