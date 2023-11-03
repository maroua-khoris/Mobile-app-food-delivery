import 'package:application/Pages/AppConstant.dart';
import 'package:application/data/api/ApiClient.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class User_repo{
  final ApiClient apiClient;
  User_repo({
    required this.apiClient,
  });
  getUserInfo() async {
    return await apiClient.getDataINFO(AppConstant.user_url);
  }
}