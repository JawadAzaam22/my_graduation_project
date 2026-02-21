// TODO Implement this library.import 'package:german_board/Models/auth/trainee_model.dart';
import 'package:get/get.dart';

import '../Models/auth/trainee_model.dart';

class UserService extends GetxService{
  String? token ;
  String? refreshToken;
  TraineeModel? currentUser;

}