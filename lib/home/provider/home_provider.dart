import 'package:code/home/models/home_get_model.dart';
import 'package:code/home/service/home_get_service.dart';
import 'package:flutter/material.dart';

class HomeGetProvider extends ChangeNotifier{

  final HomeGetService _homeGetService = HomeGetService();
  HomeGetModel? _doctorProfile;
  bool _isLoading = false;
  String? _errorMessage;

  HomeGetModel? get doctorProfile => _doctorProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDoctorProfile() async {

    if (_doctorProfile != null) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try{
      _doctorProfile = await _homeGetService.fetchDoctorProfile();
    }catch(error){
      _errorMessage = error.toString();
    }finally {
      _isLoading = false;
      notifyListeners();
    }

  }

  // Get a list of clinics
  List<Clinics> getClinics() {
    return doctorProfile?.data?.clinics ?? [];
  }

}