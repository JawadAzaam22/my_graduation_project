// TODO Implement this library.import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @ll.
  ///
  /// In en, this message translates to:
  /// **'llennn'**
  String get ll;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get enterCode;

  /// No description provided for @sMSActivationCode.
  ///
  /// In en, this message translates to:
  /// **'We’ve sent an SMS with an activation code to your phone'**
  String get sMSActivationCode;

  /// No description provided for @wrongCode.
  ///
  /// In en, this message translates to:
  /// **'Wrong code, please try again '**
  String get wrongCode;

  /// No description provided for @sendCodeAgain.
  ///
  /// In en, this message translates to:
  /// **'Send code again'**
  String get sendCodeAgain;

  /// No description provided for @notReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'I didn’t receive a code'**
  String get notReceiveCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'verify'**
  String get verify;

  /// No description provided for @splashSentence.
  ///
  /// In en, this message translates to:
  /// **'German Board for Training and'**
  String get splashSentence;

  /// No description provided for @splashSentence2.
  ///
  /// In en, this message translates to:
  /// **'Consulting GmbH'**
  String get splashSentence2;

  /// No description provided for @welcomeSentence.
  ///
  /// In en, this message translates to:
  /// **'Explore the app'**
  String get welcomeSentence;

  /// No description provided for @welcomeSentence1.
  ///
  /// In en, this message translates to:
  /// **'Now your courses are in one place'**
  String get welcomeSentence1;

  /// No description provided for @welcomeSentence2.
  ///
  /// In en, this message translates to:
  /// **'and always under control'**
  String get welcomeSentence2;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No desgit initcription provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get date;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone;

  /// No description provided for @last.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get last;

  /// No description provided for @first.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get first;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @loginWith.
  ///
  /// In en, this message translates to:
  /// **'Or Login with'**
  String get loginWith;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @emailValidate.
  ///
  /// In en, this message translates to:
  /// **'please enter your email'**
  String get emailValidate;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @passwordValidation.
  ///
  /// In en, this message translates to:
  /// **'please enter your password'**
  String get passwordValidation;

  /// No description provided for @forgetPassIntro.
  ///
  /// In en, this message translates to:
  /// **'Don’t worry! It happens. Please enter the phone number associated with your account'**
  String get forgetPassIntro;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @phoneValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get phoneValidation;

  /// No description provided for @createAccIntro.
  ///
  /// In en, this message translates to:
  /// **'Please enter the phone number to create your account'**
  String get createAccIntro;

  /// No description provided for @accCreated.
  ///
  /// In en, this message translates to:
  /// **'Account Created'**
  String get accCreated;

  /// No description provided for @accCreatedIntro.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created succesfully'**
  String get accCreatedIntro;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @passChanged.
  ///
  /// In en, this message translates to:
  /// **'Password Changed'**
  String get passChanged;

  /// No description provided for @passChangedIntro.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed succesfully'**
  String get passChangedIntro;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordIntro.
  ///
  /// In en, this message translates to:
  /// **'Please type something you’ll remember'**
  String get resetPasswordIntro;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'must be 8 characters'**
  String get newPasswordHint;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordValidation.
  ///
  /// In en, this message translates to:
  /// **'please repeat password'**
  String get confirmPasswordValidation;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'repeat password'**
  String get confirmPasswordHint;

  /// No description provided for @logWGoogl.
  ///
  /// In en, this message translates to:
  /// **'Log in with Google'**
  String get logWGoogl;

  /// No description provided for @popularBlogs.
  ///
  /// In en, this message translates to:
  /// **'Popular Blogs'**
  String get popularBlogs;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get required;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalid_email;

  /// No description provided for @validPasswordConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get validPasswordConfirmation;

  /// No description provided for @validPassword.
  ///
  /// In en, this message translates to:
  /// **'Password does not match'**
  String get validPassword;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @numberPasswordLetters.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get numberPasswordLetters;

  /// No description provided for @testUppercaseLetter.
  ///
  /// In en, this message translates to:
  /// **'Add an uppercase letter'**
  String get testUppercaseLetter;

  /// No description provided for @testLowercaseLetter.
  ///
  /// In en, this message translates to:
  /// **'Add a lowercase letter'**
  String get testLowercaseLetter;

  /// No description provided for @testNumber.
  ///
  /// In en, this message translates to:
  /// **'Add a number'**
  String get testNumber;

  /// No description provided for @testSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'Add a special character'**
  String get testSpecialCharacter;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @myCourses.
  ///
  /// In en, this message translates to:
  /// **'My Courses'**
  String get myCourses;

  /// No description provided for @blogs.
  ///
  /// In en, this message translates to:
  /// **'Blogs'**
  String get blogs;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @recentSearch.
  ///
  /// In en, this message translates to:
  /// **'Recent Search'**
  String get recentSearch;

  /// No description provided for @popularTags.
  ///
  /// In en, this message translates to:
  /// **'Popular Tags'**
  String get popularTags;

  /// No description provided for @hintSearch.
  ///
  /// In en, this message translates to:
  /// **'Search courses, trainers, institutions'**
  String get hintSearch;

  /// No description provided for @topCourses.
  ///
  /// In en, this message translates to:
  /// **'Top Courses'**
  String get topCourses;

  /// No description provided for @learners.
  ///
  /// In en, this message translates to:
  /// **'Learners'**
  String get learners;

  /// No description provided for @liveTrainning.
  ///
  /// In en, this message translates to:
  /// **'Live Trainning'**
  String get liveTrainning;

  /// No description provided for @studentbought.
  ///
  /// In en, this message translates to:
  /// **'Student Enrolled'**
  String get studentbought;

  /// No description provided for @instructor.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get instructor;

  /// No description provided for @keyLearning.
  ///
  /// In en, this message translates to:
  /// **'Key Learning '**
  String get keyLearning;

  /// No description provided for @objectives.
  ///
  /// In en, this message translates to:
  /// **'Objectives'**
  String get objectives;

  /// No description provided for @enroll.
  ///
  /// In en, this message translates to:
  /// **'Enroll'**
  String get enroll;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select the Payment Method you Want to Use'**
  String get selectPaymentMethod;

  /// No description provided for @paySuccess.
  ///
  /// In en, this message translates to:
  /// **'Your Payment is Successfully.Purchase a\n New Course'**
  String get paySuccess;

  /// No description provided for @viewCourse.
  ///
  /// In en, this message translates to:
  /// **'View Course'**
  String get viewCourse;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessions;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @ongoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get ongoing;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @viewNote.
  ///
  /// In en, this message translates to:
  /// **'View Note'**
  String get viewNote;

  /// No description provided for @notStarted.
  ///
  /// In en, this message translates to:
  /// **'Not Started'**
  String get notStarted;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @recordedTraining.
  ///
  /// In en, this message translates to:
  /// **'Recorded Training'**
  String get recordedTraining;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulations;

  /// No description provided for @trainingDescription.
  ///
  /// In en, this message translates to:
  /// **'Training Description'**
  String get trainingDescription;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Read Less'**
  String get readLess;

  /// No description provided for @mute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get mute;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @shareScreen.
  ///
  /// In en, this message translates to:
  /// **'Share Screen'**
  String get shareScreen;

  /// No description provided for @people.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get people;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @completeYourDetails.
  ///
  /// In en, this message translates to:
  /// **' We need some additional information to enhance your experience. Please complete your details to enjoy a personalized experience that matches your interests.'**
  String get completeYourDetails;

  /// No description provided for @noCourses.
  ///
  /// In en, this message translates to:
  /// **'No Courses'**
  String get noCourses;

  /// No description provided for @noCoursesSentence.
  ///
  /// In en, this message translates to:
  /// **'Looks like you have not enrolled for any'**
  String get noCoursesSentence;

  /// No description provided for @noCoursesSentence1.
  ///
  /// In en, this message translates to:
  /// **'course yet'**
  String get noCoursesSentence1;

  /// No description provided for @exploreCourses.
  ///
  /// In en, this message translates to:
  /// **'Explore Courses'**
  String get exploreCourses;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @recorded.
  ///
  /// In en, this message translates to:
  /// **'Recorded'**
  String get recorded;

  /// No description provided for @continu.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continu;

  /// No description provided for @certificate.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get certificate;

  /// No description provided for @introCertificate.
  ///
  /// In en, this message translates to:
  /// **'You must complete the training to earn and download this certificate'**
  String get introCertificate;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @certificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get certificates;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @inviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite Friends'**
  String get inviteFriends;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English US'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @deutsch.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get deutsch;

  /// No description provided for @specialOffers.
  ///
  /// In en, this message translates to:
  /// **'Special Offers'**
  String get specialOffers;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @vibrate.
  ///
  /// In en, this message translates to:
  /// **'Vibrate'**
  String get vibrate;

  /// No description provided for @generalNotification.
  ///
  /// In en, this message translates to:
  /// **'General Notification'**
  String get generalNotification;

  /// No description provided for @paymentOptions.
  ///
  /// In en, this message translates to:
  /// **'Payment Options'**
  String get paymentOptions;

  /// No description provided for @appUpdate.
  ///
  /// In en, this message translates to:
  /// **'App Update'**
  String get appUpdate;

  /// No description provided for @newServiceAvailable.
  ///
  /// In en, this message translates to:
  /// **'New Service Available'**
  String get newServiceAvailable;

  /// No description provided for @termsUse.
  ///
  /// In en, this message translates to:
  /// **'Terms & Use'**
  String get termsUse;

  /// No description provided for @conditionAttending.
  ///
  /// In en, this message translates to:
  /// **'Condition & Attending'**
  String get conditionAttending;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @enterCerID.
  ///
  /// In en, this message translates to:
  /// **'Enter your certificate Id'**
  String get enterCerID;

  /// No description provided for @messageWithCer.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! you have obtained a certified certificate after completing our course.'**
  String get messageWithCer;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'done'**
  String get done;

  /// No description provided for @savedSuc.
  ///
  /// In en, this message translates to:
  /// **'saved successfully'**
  String get savedSuc;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategories;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get search;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @views.
  ///
  /// In en, this message translates to:
  /// **'views'**
  String get views;

  /// No description provided for @by.
  ///
  /// In en, this message translates to:
  /// **'By'**
  String get by;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @watchVID.
  ///
  /// In en, this message translates to:
  /// **'Watch Video'**
  String get watchVID;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @noLesson.
  ///
  /// In en, this message translates to:
  /// **'No Lessons Available'**
  String get noLesson;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alert;

  /// No description provided for @nourl.
  ///
  /// In en, this message translates to:
  /// **'Video Url Not Available'**
  String get nourl;

  /// No description provided for @changVidStatue.
  ///
  /// In en, this message translates to:
  /// **'Change Video Status'**
  String get changVidStatue;

  /// No description provided for @isCompleteWatch.
  ///
  /// In en, this message translates to:
  /// **'Do you complete Watching Video?'**
  String get isCompleteWatch;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @noCerToSave.
  ///
  /// In en, this message translates to:
  /// **'Certificate Not Found!'**
  String get noCerToSave;

  /// No description provided for @cerSaved.
  ///
  /// In en, this message translates to:
  /// **'Certificate Saved Successfully in Gallery'**
  String get cerSaved;

  /// No description provided for @rateCourse.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Course'**
  String get rateCourse;

  /// No description provided for @selectRating.
  ///
  /// In en, this message translates to:
  /// **'Please rate this course to help us improve your experience.'**
  String get selectRating;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @selectAnswerFirst.
  ///
  /// In en, this message translates to:
  /// **'Select one answer First'**
  String get selectAnswerFirst;

  /// No description provided for @sorry.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately'**
  String get sorry;

  /// No description provided for @sorryMes.
  ///
  /// In en, this message translates to:
  /// **'You failed the test. Try again.'**
  String get sorryMes;

  /// No description provided for @successesMes.
  ///
  /// In en, this message translates to:
  /// **'You passed the test'**
  String get successesMes;

  /// No description provided for @reDoQuiz.
  ///
  /// In en, this message translates to:
  /// **'Retest'**
  String get reDoQuiz;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @noQuestion.
  ///
  /// In en, this message translates to:
  /// **'No Questions Available'**
  String get noQuestion;

  /// No description provided for @course.
  ///
  /// In en, this message translates to:
  /// **'course'**
  String get course;

  /// No description provided for @onSiteTraining.
  ///
  /// In en, this message translates to:
  /// **'OnSite Training'**
  String get onSiteTraining;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'Not Found Data'**
  String get noDataFound;

  /// No description provided for @noAttachment.
  ///
  /// In en, this message translates to:
  /// **'No Attachments Available'**
  String get noAttachment;

  /// No description provided for @complaint.
  ///
  /// In en, this message translates to:
  /// **'complaints'**
  String get complaint;

  /// No description provided for @addComplaint.
  ///
  /// In en, this message translates to:
  /// **'Add Complaint'**
  String get addComplaint;

  /// No description provided for @noCertificate.
  ///
  /// In en, this message translates to:
  /// **'No certificate'**
  String get noCertificate;

  /// No description provided for @dateOfCer.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Date:'**
  String get dateOfCer;

  /// No description provided for @searchForCer.
  ///
  /// In en, this message translates to:
  /// **'Search for your Certificate'**
  String get searchForCer;

  /// No description provided for @dateofbirth.
  ///
  /// In en, this message translates to:
  /// **'date of birth'**
  String get dateofbirth;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'location'**
  String get location;

  /// No description provided for @brief.
  ///
  /// In en, this message translates to:
  /// **'brief'**
  String get brief;

  /// No description provided for @thernocours.
  ///
  /// In en, this message translates to:
  /// **'There are no courses currently available'**
  String get thernocours;

  /// No description provided for @louddata.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data.'**
  String get louddata;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'student'**
  String get student;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'role'**
  String get role;

  /// No description provided for @profiles.
  ///
  /// In en, this message translates to:
  /// **'PROFILE'**
  String get profiles;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @providers.
  ///
  /// In en, this message translates to:
  /// **'Providers'**
  String get providers;

  /// No description provided for @no_notifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications at the moment'**
  String get no_notifications;

  /// No description provided for @noteAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get noteAlertTitle;

  /// No description provided for @noteEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Cannot save an empty note'**
  String get noteEmptyError;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @writeYourNote.
  ///
  /// In en, this message translates to:
  /// **'Write your note here...'**
  String get writeYourNote;

  /// No description provided for @addNoteToSession.
  ///
  /// In en, this message translates to:
  /// **'Add your note to the session'**
  String get addNoteToSession;

  /// No description provided for @noteSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Note saved successfully'**
  String get noteSavedSuccess;

  /// No description provided for @noNotesYet.
  ///
  /// In en, this message translates to:
  /// **'No notes yet'**
  String get noNotesYet;

  /// No description provided for @sessionNotes.
  ///
  /// In en, this message translates to:
  /// **'Session notes'**
  String get sessionNotes;

  /// No description provided for @noteSaved.
  ///
  /// In en, this message translates to:
  /// **'Note saved successfully'**
  String get noteSaved;

  /// No description provided for @deleteNoteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this note?'**
  String get deleteNoteConfirm;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
