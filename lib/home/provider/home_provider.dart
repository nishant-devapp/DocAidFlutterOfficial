import 'package:code/home/models/home_get_model.dart';
import 'package:code/home/service/home_service.dart';
import 'package:flutter/material.dart';

class HomeGetProvider extends ChangeNotifier {
  final HomeGetService _homeGetService = HomeGetService();
  HomeGetModel? _doctorProfile;
  bool _isLoading = false;
  bool _isAddingClinic = false;
  String? _errorMessage;

  HomeGetModel? get doctorProfile => _doctorProfile;

  bool get isLoading => _isLoading;

  bool get isAddingClinic => _isAddingClinic;

  String? get errorMessage => _errorMessage;

  Future<void> fetchDoctorProfile() async {
    if (_doctorProfile != null) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _doctorProfile = await _homeGetService.fetchDoctorProfile();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addClinic(
      String clinicName,
      String location,
      String incharge,
      String startTime,
      String endTime,
      String clinicContact,
      String clinicNewFee,
      String clinicOldFees,
      List<String> days) async {

    _isAddingClinic = true;
    _errorMessage = null;
    notifyListeners();

    try{
      await _homeGetService.addNewClinic(
          clinicName, location, incharge, startTime, endTime, clinicContact, clinicNewFee, clinicOldFees, days
      );

      await fetchDoctorProfile();

    }catch(error){
      _errorMessage = 'Error adding clinic: $error';
    } finally {
      _isAddingClinic = false;
      notifyListeners();
    }

  }

  // Get a list of clinics
  List<ClinicDtos> getClinics() {
    return doctorProfile?.data?.clinicDtos ?? [];
  }

}
