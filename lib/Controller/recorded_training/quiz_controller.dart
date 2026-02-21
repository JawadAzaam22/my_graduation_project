import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:german_board/Constants/base_url.dart';
import '../../Models/recorded/Quiz_Model.dart';
import '../../Services/service.dart';
import 'package:dio/dio.dart' as dio;
import '../../l10n/app_localizations.dart';

class QuizController extends GetxController {
  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  final RxBool _isLoading2 = false.obs;
  RxBool get isLoading2 => _isLoading2;

  final RxBool _isLoading3 = false.obs;
  RxBool get isLoading3 => _isLoading3;

  late final UserService service;
  late final int quizID;

  RxList<Question> questions = <Question>[].obs;
  RxInt questionIndex = 0.obs;
  RxList<Answers> options = <Answers>[].obs;
  RxBool isAnswered = false.obs;
  RxInt correctAnswers = 0.obs;

  RxList<Map<String, dynamic>> submittedAnswers = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    service = Get.find<UserService>();
    quizID = Get.arguments["quizID"];
    await getQuizDetails();
    super.onInit();
  }

  late BuildContext context;
  late String quizTitle;
  late String quizScore;
  Future<void> getQuizDetails() async {
    dio.Dio d = dio.Dio();

    try {
      _isLoading.value = true;
      dio.Response r = await d.get(
        "$baseURL/api/v1/trainee/quiz/$quizID",
        options: dio.Options(
          headers: {"Authorization": "Bearer ${service.token}"},
        ),
      );

      if (r.statusCode == 200 && r.data["status"] == "success") {
        List<dynamic> apiQuestions = r.data["data"]["questions"];
        quizTitle = r.data["data"]["title"] ?? "";
        quizScore = r.data["data"]["passing_score"] ?? "";
        questions.clear();
        questions.addAll(apiQuestions.map((e) => Question.fromJson(e)));

        questionIndex.value = 0;
        submittedAnswers.clear();
        correctAnswers.value = 0;
        loadOptions();
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
      _isLoading.value = false;
    } on dio.DioException catch (e) {
      _isLoading.value = false;
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }

  Future<bool> checkAnswerApi(int selectedAnswerId) async {
    dio.Dio d = dio.Dio();
    try {
      _isLoading2.value = true;
      dio.Response r = await d.post(
        "$baseURL/api/v1/trainee/quiz/question/check",
        options: dio.Options(
          headers: {"Authorization": "Bearer ${service.token}"},
        ),
        data: {
          "quiz_id": quizID,
          "question_id": questions[questionIndex.value].id,
          "answer_id": selectedAnswerId,
        },
      );
      _isLoading2.value = false;

      if (r.statusCode == 200 && r.data["status"] == "success") {
        return r.data["data"] == true;
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
        return false;
      }
    } on dio.DioException catch (e) {
      _isLoading2.value = false;
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
      return false;
    }
  }

  void loadOptions() {
    options.clear();
    if (questions.isNotEmpty) {
      options.addAll(questions[questionIndex.value].answers!);
    }
  }

  void selectChoice(int id) {
    if (isAnswered.value) return;

    for (var option in options) {
      option.isSelected = false;
    }

    options.firstWhere((option) => option.id == id).isSelected = true;
    options.refresh();
  }

  void checkAnswer() async {
    if (isAnswered.value) return;

    var selected = options.firstWhereOrNull((o) => o.isSelected);
    if (selected == null) {
      Get.snackbar(
        AppLocalizations.of(context)!.alert,
        AppLocalizations.of(context)!.selectAnswerFirst,
      );
      return;
    }

    isAnswered.value = true;

    bool isCorrect = await checkAnswerApi(selected.id!);
    selected.isCorrect = isCorrect;

    submittedAnswers.add({
      "question_id": questions[questionIndex.value].id,
      "answer_id": selected.id,
    });

    if (isCorrect) correctAnswers.value++;

    options.refresh();

    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  RxBool isPassed = false.obs;

  void nextQuestion() async {
    isAnswered.value = false;
    if (questionIndex.value < questions.length - 1) {
      questionIndex.value++;
      loadOptions();
    } else {
      print(submittedAnswers);
      await checkResult();
    }
  }

  Future<void> checkResult() async {
    dio.Dio d = dio.Dio();
    try {
      _isLoading3.value = true;
      dio.Response r = await d.post(
        "$baseURL/api/v1/trainee/quiz/submit",
        options: dio.Options(
          headers: {"Authorization": "Bearer ${service.token}"},
        ),
        data: submittedAnswers,
      );
      _isLoading3.value = false;

      if (r.statusCode == 200 && r.data["status"] == "success") {
        print( r.data["data"]["score"] );


        var score = r.data["data"]["score"]??0 ;

        num requiredScore = num.tryParse(quizScore) ?? 0;

        isPassed.value = score >= requiredScore;

        _showResultDialog(score);
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
    } on dio.DioException catch (e) {
      _isLoading3.value = false;
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }

  void _showResultDialog( score) {
    Get.dialog(
      AlertDialog(
        title: Obx(() => Text(isPassed.value
            ? AppLocalizations.of(context)!.congratulations
            : AppLocalizations.of(context)!.sorry)),
        content: Text(
          isPassed.value
              ? "${AppLocalizations.of(context)!.successesMes}\nScore: $score"
              : "${AppLocalizations.of(context)!.sorryMes}\nScore: $score",
        ),
        actions: [
          if (isPassed.value)
            TextButton(
              onPressed: () {
                Get.back();
                Get.back(result: true);
              },
              child: Text(AppLocalizations.of(context)!.ok),
            ),
          if (!isPassed.value)
            TextButton(
              onPressed: () {
                Get.back();
                restartQuiz();
              },
              child: Text(AppLocalizations.of(context)!.reDoQuiz),
            ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void restartQuiz() async {
    submittedAnswers.clear();
    correctAnswers.value = 0;
    isAnswered.value = false;
    questionIndex.value = 0;

    await getQuizDetails();
  }
}
