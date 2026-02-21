import 'package:german_board/Bindings/Live%20trainning/session_bindings.dart';
import 'package:german_board/Bindings/Live%20trainning/view_course_triannig_bindings.dart';
import 'package:german_board/Bindings/Live%20trainning/view_live_trainnig_bindings.dart';
import 'package:german_board/Bindings/auth/otp_register_bindings.dart';
import 'package:german_board/Bindings/auth/register_bindings.dart';
import 'package:german_board/Bindings/auth/welcome_bindings.dart';
import 'package:german_board/Bindings/on%20Site%20training/view_onsite_training_bindings.dart';
import 'package:german_board/Bindings/profile/complaint_bindings.dart';
import 'package:german_board/Bindings/profile/edit_profile_bindings.dart';
import 'package:german_board/Bindings/profile/language_bindings.dart';
import 'package:german_board/Bindings/profile/search_certificate_bindings.dart';
import 'package:german_board/Bindings/profile/security_bindings.dart';
import 'package:german_board/Bindings/profile/terms_condition_bindings.dart';
import 'package:german_board/Bindings/recorded%20training/quiz_bindings.dart';
import 'package:german_board/Bindings/my_courses_bindings.dart';
import 'package:german_board/Bindings/recorded%20training/view_enrolled_recorded_course_bindings.dart';
import 'package:german_board/Bindings/recorded%20training/view_recorded_trainning_bindings.dart';
import 'package:german_board/View/Live%20training/session_screen.dart';
import 'package:german_board/View/auth/otp_register_screen.dart';
import 'package:german_board/View/auth/register_screen.dart';
import 'package:german_board/View/auth/welcome_screen.dart';
import 'package:german_board/View/my_courses/my_courses_screen.dart';
import 'package:german_board/View/profile/edit_profile_screen.dart';
import 'package:german_board/View/profile/search_certificate_screen.dart';
import 'package:german_board/View/profile/security_screen.dart';
import 'package:german_board/View/profile/terms_condition_screen.dart';
import 'package:german_board/View/recorded%20training/view_enrolled_recorded_course_screen.dart';
import 'package:german_board/View/recorded%20training/view_recorded_trainning_screen.dart';
import 'package:german_board/changetheme/Binding.dart';
import 'package:german_board/profile/user_profile_bindings.dart';
import 'package:german_board/profile/user_profile_screen.dart';
import 'package:get/get.dart';
import '../Bindings/all_categories_bindings.dart';
import '../Bindings/auth/enter_number_bindings.dart';
import '../Bindings/auth/login_bindings.dart';
import '../Bindings/auth/otp_reset_password_bindigs.dart';
import '../Bindings/auth/pasword_changed_bindings.dart';
import '../Bindings/auth/reset_password_bindings.dart';
import '../Bindings/auth/splash_bindings.dart';
import '../Bindings/blogs/view_blog_bindings.dart';
import '../Bindings/browse_item_bindings.dart';
import '../Bindings/layout_bindings.dart';
import '../Bindings/profile/change_pass_security_bindings.dart';
import '../Bindings/profile/setting_notification_bindings.dart';
import '../Bindings/search_bindings.dart';

import '../View/Live training/view_course_triannig_screen.dart';
import '../View/Live training/view_live_training_screen.dart';
import '../View/all_categories_screen.dart';
import '../View/auth/account_created_screen.dart';
import '../View/auth/complete_information_screen.dart';
import '../View/auth/create_acc_number_screen.dart';
import '../View/auth/forget_password_screen.dart';
import '../View/auth/login_screen.dart';
import '../View/auth/otp_reset_password_screen.dart';
import '../View/auth/password_changed_screen.dart';
import '../View/auth/reset_password_screen.dart';
import '../View/auth/splash_screen.dart';
import '../View/blogs/view_blog_screen.dart';
import '../View/browse_item_screen.dart';
import '../View/layout _screen.dart';
import '../View/on Site training/view_onsite_training_screen.dart';
import '../View/profile/change_pass_security_screen.dart';
import '../View/profile/complaint_screen.dart';
import '../View/profile/language_screen.dart';
import '../View/profile/setting_notification_screen.dart';
import '../View/recorded training/quiz_screen.dart';
import '../View/search_screen.dart';
import '../changetheme/ui.dart';

class AppRoutes {

  static String initial = "/splash";


   static List<GetPage> routes = [
     GetPage(
       name: "/splash",
       page: () => const SplashScreen(),
       binding: SplashBindings(),
     ),
     GetPage(
       name: "/welcome",
       page: () => WelcomeScreen(),
       binding: WelcomeBindings(),
     ),
     GetPage(
       name: "/register",
       page: () => RegisterScreen(),
       binding: RegisterBindings(),
     ),
     GetPage(
       name: "/otpResetPassword",
       page: () => OtpResetPasswordScreen(),
       binding: OtpResetPasswordBindigs(),
     ),
     GetPage(
       name: "/Login",
       page: () => LoginScreen(),
       binding: LoginBindings(),
     ),
     GetPage(
       name: "/CreateAccNumber",
       page: () => const CreateAccNumberScreen(),
       binding: EnterNumberBindings(),
     ),
     GetPage(
       name: "/ForgetPassword",
       page: () => const ForgetPasswordScreen(),
       binding: EnterNumberBindings(),
     ),
     GetPage(
       name: "/ResetPassword",
       page: () => const ResetPasswordScreen(),
       binding: ResetPasswordBindings(),
     ),
     GetPage(
       name: "/PasswordChanged",
       page: () => const PasswordChangedScreen(),
       binding: PasswordChangedBindings(),
     ),
     GetPage(
       name: "/AccountCreated",
       page: () => const AccountCreatedScreen(),
       binding: PasswordChangedBindings(),
     ),
     GetPage(
       name: "/layout",
       page: () =>  const LayoutScreen(),
       binding: LayoutBindings(),
     ),
     GetPage(
       name: "/allCategories",
       page: () => AllCategoriesScreen(),
       binding: AllCategoriesBindings(),
     ),
     GetPage(
       name: "/changetheme",
       page: () =>  ChangeTheme(),
       binding: changeBindings(),
     ),
     GetPage(
       name: "/search",
       page: () =>  SearchScreen(),
       binding: SearchBindings(),
     ),
     GetPage(
       name: "/view",
       page: () =>  const ViewLiveTrainingScreen(),
       binding: ViewLiveTrainnigBindings(),
     ),

     GetPage(
       name: "/ViewCourse",
       page: () =>  const ViewCourseTriannigScreen(),
       binding: ViewCourseTriannigBindings(),
     ),
     GetPage(
       name: "/otpRegister",
       page: () => OtpRegisterScreen(),
       binding: OtpRegisterBindings(),
     ),
     GetPage(
       name: "/viewEnrolledRecordedCourse",
       page: () => const ViewEnrolledRecordedCourseScreen(),
       binding: ViewEnrolledRecordedCourseBindings(),
     ),
     GetPage(
       name: "/viewRecordedCourse",
       page: () => const ViewRecordedTrainningScreen(),
       binding: ViewRecordedTrainningBindings(),
     ),
     GetPage(
       name: "/quiz",
       page: () => const QuizScreen(),
       binding: QuizBindings(),
     ),
     GetPage(
       name: "/LoginWithGoogle",
       page: () => const CompleteInformationScreen(),
       binding: LoginBindings(),
     ),
     GetPage(
       name: "/myCourses",
       page: () => const MyCoursesScreen(),
       binding: MyCoursesBindings(),
     ),
     GetPage(
       name: "/agora",
       page: () => const SessionScreen(),
       binding: SessionBindings(),
     ),

     GetPage(
       name: "/browse",
       page: () => const BrowseItemScreen(),
       binding: BrowseItemBindings(),
     ),

     GetPage(
       name: "/editProfile",
       page: () => EditProfileScreen(),
       binding: EditProfileBindings(),
     ),
     GetPage(
       name: "/security",
       page: () => const SecurityScreen(),
       binding: SecurityBindings(),
     ),
     GetPage(
       name: "/language",
       page: () => const LanguageScreen(),
       binding: LanguageBindings(),
     ),
 GetPage(
       name: "/termsAndCondition",
       page: () => const TermsConditionScreen(),
       binding: TermsConditionBindings(),
     ),
GetPage(
       name: "/settingNotify",
       page: () => const SettingNotificationScreen(),
       binding: SettingNotificationBindings(),
     ),
GetPage(
       name: "/changePassSec",
       page: () => const ChangePassSecurityScreen(),
       binding: ChangePassSecurityBindings(),
     ),
GetPage(
       name: "/searchCertificate",
       page: () => SearchCertificateScreen(),
       binding: SearchCertificateBindings(),
     ),
GetPage(
       name: "/viewBlog",
       page: () => const ViewBlogScreen(),
       binding: ViewBlogBindings(),
     ),
     GetPage(
       name: "/userprofiles",
       page: () => const UserProfileScreen(),
       binding: UserProfileBindings(),
     ),
       GetPage(
       name: "/viewOnSiteCourse",
       page: () => const ViewOnsiteTrainingScreen(),
       binding: ViewOnsiteTrainingBindings(),
     ),
GetPage(
       name: "/addComplaint",
       page: () => ComplaintScreen(),
       binding: ComplaintBindings(),
),
   ];

 }
