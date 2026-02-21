import 'package:get/get.dart';

class SettingNotificationController extends GetxController {
  RxBool specialOffers = true.obs;
  RxBool sound = true.obs;
  RxBool vibrate = false.obs;
  RxBool generalNotification = true.obs;
  RxBool paymentOptions = true.obs;
  RxBool appUpdate = true.obs;
  RxBool newServiceAvailable = false.obs;

  void onSpecialOffersChanged(bool value) {
    specialOffers.value = value;
  }

  void onSoundChanged(bool value) {
    sound.value = value;
  }

  void onVibrateChanged(bool value) {
    vibrate.value = value;
  }

  void onGeneralNotificationChanged(bool value) {
    generalNotification.value = value;
  }

  void onPaymentOptionsChanged(bool value) {
    paymentOptions.value = value;
  }

  void onAppUpdateChanged(bool value) {
    appUpdate.value = value;
  }

  void onNewServiceAvailableChanged(bool value) {
    newServiceAvailable.value = value;
  }
}
