import 'package:consulin_mobile_dev/app/modules/detail_available_pasien/bindings/detail_available_pasien_binding.dart';
import 'package:consulin_mobile_dev/app/modules/detail_available_pasien/views/detail_available_pasien_view.dart';
import 'package:get/get.dart';

import '../modules/Edit_Information/bindings/psikolog_pro_det_binding.dart';
import '../modules/Edit_Information/views/psikolog_pro_det_view.dart';
import '../modules/Edit_Profile/bindings/psikolog_per_info_binding.dart';
import '../modules/Edit_Profile/views/psikolog_per_info_view.dart';
import '../modules/ForgotPass_psycholog/bindings/psikolog_cha_pass_binding.dart';
import '../modules/ForgotPass_psycholog/views/psikolog_cha_pass_view.dart';
import '../modules/History/bindings/psikolog_history_binding.dart';
import '../modules/History/views/psikolog_history_view.dart';
import '../modules/PickRole/bindings/pick_role_binding.dart';
import '../modules/PickRole/views/pick_role_view.dart';
import '../modules/Profile/views/profile_pycholog_view.dart';
import '../modules/Reset_Pass_psycholog/bindings/psi_reset_pass_binding.dart';
import '../modules/Reset_Pass_psycholog/views/psi_reset_pass_view.dart';
import '../modules/ai_analyzer_pasien/bindings/ai_analyzer_pasien_binding.dart';
import '../modules/ai_analyzer_pasien/views/ai_analyzer_pasien_view.dart';
import '../modules/analyzer_history_pasien/bindings/analyzer_history_pasien_binding.dart';
import '../modules/analyzer_history_pasien/views/analyzer_history_pasien_view.dart';
import '../modules/chat_patient/views/chat_patient_view.dart';
import '../modules/chat_psycholog/views/chat_psycholog_view.dart';
import '../modules/detail_chat_patient/bindings/detail_chat_patient_binding.dart';
import '../modules/detail_chat_patient/views/detail_chat_patient_view.dart';
import '../modules/detail_completed/bindings/detail_completed_binding.dart';
import '../modules/detail_completed/views/detail_completed_view.dart';
import '../modules/detail_completed_pasien/bindings/detail_completed_pasien_binding.dart';
import '../modules/detail_completed_pasien/views/detail_completed_pasien_view.dart';
import '../modules/edit_profile_pasien/bindings/personal_information_pasien_binding.dart';
import '../modules/edit_profile_pasien/views/personal_information_pasien_view.dart';
import '../modules/edit_schedule/bindings/edit_schedule_binding.dart';
import '../modules/edit_schedule/views/edit_schedule_view.dart';
import '../modules/forgotPass/bindings/forgot_pass_binding.dart';
import '../modules/forgotPass/views/forgot_pass_view.dart';
import '../modules/history_pasien/bindings/history_pasien_binding.dart';
import '../modules/history_pasien/views/history_pasien_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_pasien/views/home_pasien_view.dart';
import '../modules/home_psycholog/views/home_psycholog_view.dart';
import '../modules/landing_pasien/bindings/landing_pasien_binding.dart';
import '../modules/landing_pasien/views/landing_pasien_view.dart';
import '../modules/landing_psycholog/bindings/landing_psycholog_binding.dart';
import '../modules/landing_psycholog/views/landing_psycholog_view.dart';
import '../modules/manage_schedule/views/manage_schedule_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/notification_pasien/bindings/notification_pasien_binding.dart';
import '../modules/notification_pasien/views/notification_pasien_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/onboarding2/bindings/onboarding2_binding.dart';
import '../modules/onboarding2/views/onboarding2_view.dart';
import '../modules/profile_pasien/views/profile_pasien_view.dart';
import '../modules/psycholog/bindings/psycholog_binding.dart';
import '../modules/psycholog/views/psycholog_view.dart';
import '../modules/resetPass/bindings/reset_pass_binding.dart';
import '../modules/resetPass/views/reset_pass_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/signup_psychologst/bindings/signup_psychologst_binding.dart';
import '../modules/signup_psychologst/views/signup_psychologst_view.dart';
import '../modules/upcoming_appointment/bindings/upcoming_appointment_binding.dart';
import '../modules/upcoming_appointment/views/upcoming_appointment_view.dart';
import '../modules/upcoming_appointmet_pasien/bindings/upcoming_appointmet_pasien_binding.dart';
import '../modules/upcoming_appointmet_pasien/views/upcoming_appointmet_pasien_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

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
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.UPCOMING_APPOINTMENT,
      page: () => const UpcomingAppointmentView(),
      binding: UpcomingAppointmentBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_COMPLETED,
      page: () => const DetailCompletedView(),
      binding: DetailCompletedBinding(),
    ),
    GetPage(
      name: _Paths.LANDING_PASIEN,
      page: () => const LandingPasienView(),
      binding: LandingPasienBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PASIEN,
      page: () => const ProfilePasienView(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFORMATION_PASIEN,
      page: () => const PersonalInformationPasienView(),
      binding: PersonalInformationPasienBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_PASIEN,
      page: () => const HistoryPasienView(),
      binding: HistoryPasienBinding(),
    ),
    GetPage(
      name: _Paths.PSYCHOLOG,
      page: () => const PsychologView(),
      binding: PsychologBinding(),
    ),
    GetPage(
      name: _Paths.AI_ANALYZER_PASIEN,
      page: () => const AiAnalyzerPasienView(),
      binding: AiAnalyzerPasienBinding(),
    ),
    GetPage(
      name: _Paths.ANALYZER_HISTORY_PASIEN,
      page: () => const AnalyzerHistoryPasienView(),
      binding: AnalyzerHistoryPasienBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PASIEN,
      page: () => const HomePasienView(),
    ),
    GetPage(
      name: _Paths.DETAIL_COMPLETED_PASIEN,
      page: () => const DetailCompletedPasienView(),
      binding: DetailCompletedPasienBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_AVAILABLE_PASIEN,
      page: () => const DetailAvailablePasienView(),
      binding: DetailAvailablePasienBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_PASIEN,
      page: () => const NotificationPasienView(),
      binding: NotificationPasienBinding(),
    ),
    GetPage(
      name: _Paths.UPCOMING_APPOINTMET_PASIEN,
      page: () => const UpcomingAppointmetPasienView(),
      binding: UpcomingAppointmetPasienBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_PSYCHOLOG,
      page: () => const ChatPsychologView(),
    ),
    GetPage(
      name: _Paths.CHAT_PATIENT,
      page: () => const ChatPatientView(),
    ),
    GetPage(
      name: _Paths.DETAIL_CHAT_PATIENT,
      page: () => const DetailChatPatientView(),
      binding: DetailChatPatientBinding(),
    ),
  ];
}
