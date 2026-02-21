import 'package:german_board/Models/profiles.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../Services/service.dart';
import '../Constants/base_url.dart';

class UserProfileController extends GetxController {
  late final UserService service;
  final RxInt selectedTab = 0.obs;
  final RxBool isLoading = false.obs;
  final dio.Dio _dio = dio.Dio();
  final RxBool isFailed = false.obs;
  @override
  void onInit()async {
    super.onInit();
    service = Get.find<UserService>();
    id=Get.arguments["id"];
    await getprofileDetails();
  }
  late int id;
  final profiles = Rxn<Profiles>();

  Future<void> getprofileDetails() async {
    isLoading.value = true;
    isFailed.value = false;

    try {
      final res = await _dio.get(
        "$baseURL/api/v1/trainee/provider/$id",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },
        ),

      );

      if (res.statusCode == 200 && res.data["status"] == "success") {
         profiles.value = Profiles.fromJson(res.data["data"]);
         print("halllo ");
      } else {
        isFailed.value = true;
        Get.snackbar("Error", res.data["message"] ?? "Failed to fetch profile .");
      }
    } on dio.DioException catch (e) {
      isFailed.value = true;
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    } finally {
      isLoading.value = false;
    }
  }


  void setSelectedTab(int index) {
    selectedTab.value = index;
  }
}