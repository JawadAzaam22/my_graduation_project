import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/base_url.dart';
import '../Services/service.dart';

class SearchAController extends GetxController {
  late final UserService service;


  final TextEditingController search = TextEditingController();
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  final providers = <dynamic>[].obs;
  final articles  = <dynamic>[].obs;
  final courses   = <dynamic>[].obs;

  final recentSearches = <String>[].obs;


  Timer? _debounce;
  dio.CancelToken? _cancelToken;

  @override
  void onInit() {
    service = Get.find<UserService>();
    loadRecentSearches();
    super.onInit();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    _cancelToken?.cancel('disposed');
    super.onClose();
  }

  void debouncedSearch(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      providers.clear();
      articles.clear();
      courses.clear();
      _isLoading.value = false;
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(query, saveRecent: false);
    });
  }
  Future<void> submitSearch(String query) async {
    final q = query.trim();
    if (q.isEmpty) return;
    search.text = q;
    await _search(q, saveRecent: true);
  }

  Future<void> _search(String query, {required bool saveRecent}) async {
    _cancelToken?.cancel('new query started');
    final localToken = dio.CancelToken();
    _cancelToken = localToken;

    _isLoading.value = true;

    final client = dio.Dio();
    try {
      final r = await client.post(
        "$baseURL/api/v1/all/search?language=en",
        options: dio.Options(headers: {
          "Authorization": "Bearer ${service.token}",
        }),
        data: {"search": query},
        cancelToken: localToken,
      );

      if (search.text.trim() != query.trim()) return;

      if (r.statusCode == 200 && r.data["status"] == "success") {
        providers.assignAll(r.data["data"]["providers"] ?? []);
        articles.assignAll(r.data["data"]["articles"] ?? []);
        courses.assignAll(r.data["data"]["trainings"] ?? []);

        if (saveRecent) {
          await saveRecentSearch(query);
        }
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
    } on dio.DioException catch (e) {
      if (!(dio.CancelToken.isCancel(e))) {
        Get.snackbar("Error", e.response?.data["message"] ?? e.message);
      }
    } finally {

      if (_cancelToken == localToken) {
        _isLoading.value = false;
      }
    }
  }

  void navToViewCourse(String type,int id){
    if(type=="recorded"){
      Get.toNamed("/viewRecordedCourse",arguments: {
        "id":id,
      });

    }
    if(type=="live"){
      Get.toNamed("/view",arguments: {
        "id":id,
      });
    }
    if(type=="onsite"){
      Get.toNamed("/viewOnSiteCourse",arguments: {
        "id":id,
      });
    }

  }
  Future<void> saveRecentSearch(String term) async {
    final prefs = await SharedPreferences.getInstance();


    recentSearches.removeWhere((e) => e.toLowerCase() == term.toLowerCase());
    recentSearches.insert(0, term);


    if (recentSearches.length > 10) {
      recentSearches.removeRange(10, recentSearches.length);
    }

    await prefs.setStringList("recent_searches", recentSearches);
  }

  Future<void> loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList("recent_searches") ?? [];
    recentSearches.assignAll(saved);
  }

  Future<void> removeRecentSearch(String term) async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches.remove(term);
    await prefs.setStringList("recent_searches", recentSearches);
  }

  Future<void> clearAllRecent() async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches.clear();
    await prefs.setStringList("recent_searches", recentSearches);
  }

  void navToViewBlog(int blogID) async{
    print("clickkkk");
    await addView(blogID);
    Get.toNamed("/viewBlog",arguments:{
      "blogID":blogID

    });



  }
  Future<void> addView(int blogID) async {
    dio.Dio d = dio.Dio();
    try {

      dio.Response r = await d.post(
        "$baseURL/api/v1/all/addView",
        options: dio.Options(
          headers: {"Authorization": "Bearer ${service.token}"},
        ),
        data: {
          "global_article_id": blogID,

        },
      );


      if (r.statusCode == 200 && r.data["status"] == "success") {
        print("donnnnne");

      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");

      }
    } on dio.DioException catch (e) {

      Get.snackbar("Error", e.response?.data["message"] ?? e.message);

    }
  }

}
