import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:german_board/Services/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/base_url.dart';
import '../l10n/app_localizations.dart';

const String stripePublishableKey =
    "pk_test_51RXMU0QYJPl9deDcZo2zVagREcl6NVdVgCMfPEjGp0aNZa6FqxvvK9ZROEjmrz9x6DNtE1VF8dUI4OJdV4Ni2g3700boiXKNCk";

class StripeService {
  static final StripeService instance = StripeService._();

  StripeService._();
  final RxBool isLoadingToPay = RxBool(false);
  Future<void> makePayment(
      int trainingId, String amount, BuildContext context, String type) async {
    try {
      isLoadingToPay.value = true;
      String? paymentIntentClientSecret =
          await enrollInCourse(trainingId, amount, "usd");

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);
      if (paymentIntentClientSecret == null) {
        isLoadingToPay.value = false;
        return;
      }
      isLoadingToPay.value = false;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              allowsDelayedPaymentMethods: true,
              paymentIntentClientSecret: paymentIntentClientSecret,
              merchantDisplayName: "German Board",
              googlePay: const PaymentSheetGooglePay(
                merchantCountryCode: "US",
                currencyCode: "USD",
                testEnv: true,
              )));
      isLoadingToPay.value = false;

      String? resultOfResponse;

      await _processPayment().then((onValue) async {
        resultOfResponse = await payResponse(paymentIntentClientSecret);
      });
      if (resultOfResponse != null) {
        Get.defaultDialog(
          title: "",
          content: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Container(
                width: 360.w,
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/successsfully.svg",
                        height: 170.h,
                        width: 215.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      AppLocalizations.of(context)!.congratulations,
                      style: GoogleFonts.jost(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      AppLocalizations.of(context)!.paySuccess,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    InkWell(
                      onTap: () {
                        if (type == "live") {
                          Get.offAndToNamed("/ViewCourse",
                              arguments: {"id": trainingId});
                        } else if (type == "recorded") {
                          Get.offAndToNamed("/viewEnrolledRecordedCourse",
                              arguments: {"id": trainingId});
                        }
                      },
                      child: Container(
                        height: 60.h,
                        width: 200.w,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.viewCourse,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.jost(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    height: 39.h,
                                    width: 39.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Theme.of(context).primaryColor,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print("errrrrrrrror$e");
    }
  }
}

final UserService service = Get.find<UserService>();

Future<String?> enrollInCourse(
    int trainingId, String amount, String currency) async {
  dio.Dio d = dio.Dio();

  try {
    dio.Response r = await d.post("$baseURL/api/v1/trainee/training/enroll",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },
        ),
        data: {
          "training_id": trainingId,
          "amount": amount,
          "currency": currency
        });
    if (r.statusCode == 200 && r.data["status"] == "success") {
      return r.data["data"]['clint_secret'];
    } else {
      Get.snackbar("Error", r.data["message"] ?? "error");

      return null;
    }
  } on dio.DioException catch (e) {
    Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    return null;
  }
}

Future<String?> payResponse(String clientSecret) async {
  dio.Dio d = dio.Dio();

  try {
    dio.Response r = await d.post("$baseURL/api/v1/trainee/payment/checkResult",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },
        ),
        data: {
          "client_secret": clientSecret,
        });
    if (r.statusCode == 200 && r.data["status"] == "success") {
      return r.data["status"];
    } else {
      Get.snackbar("Error", r.data["message"] ?? "error");

      return null;
    }
  } on dio.DioException catch (e) {
    Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    return null;
  }
}
