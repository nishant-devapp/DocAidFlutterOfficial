import 'package:code/home/models/home_get_model.dart';
import 'package:code/home/service/home_service.dart';
import 'package:flutter/material.dart';

class HomeGetProvider extends ChangeNotifier {
  final HomeGetService _homeGetService = HomeGetService();
  HomeGetModel? _doctorProfile;
  bool _isLoading = false;
  bool _isAddingClinic = false;
  bool _isUpdatingClinic = false;
  String? _errorMessage;

  HomeGetModel? get doctorProfile => _doctorProfile;

  bool get isLoading => _isLoading;

  bool get isAddingClinic => _isAddingClinic;
  bool get isUpdatingClinic => _isUpdatingClinic;

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

    try {
      await _homeGetService.addNewClinic(clinicName, location, incharge,
          startTime, endTime, clinicContact, clinicNewFee, clinicOldFees, days);

      // Fetch updated doctor profile to reflect the new clinic
      _doctorProfile = await _homeGetService.fetchDoctorProfile();
    } catch (error) {
      _errorMessage = 'Error adding clinic: $error';
    } finally {
      _isAddingClinic = false;
      notifyListeners();
    }
  }


  Future<void> updateClinic(
      int clinicId,
      String clinicName,
      String location,
      String incharge,
      String startTime,
      String endTime,
      String clinicContact,
      String clinicNewFee,
      String clinicOldFees,
      List<String> days,
      ) async{

    _isUpdatingClinic = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _homeGetService.updateClinic(clinicId, clinicName, location, incharge,
          startTime, endTime, clinicContact, clinicNewFee, clinicOldFees, days);

      doctorProfile?.data?.clinicDtos?.forEach((clinic) {
        if (clinic.id == clinicId) {
          clinic.clinicName = clinicName;
          clinic.location = location;
          clinic.incharge = incharge;
          clinic.startTime = startTime;
          clinic.endTime = endTime;
          clinic.clinicContact = clinicContact;
          clinic.clinicNewFees = clinicNewFee as double?;
          clinic.clinicOldFees = clinicOldFees as double?;
          clinic.days = days;
        }
      });

    } catch (error) {
      _errorMessage = 'Error updating clinic: $error';
    } finally {
      _isUpdatingClinic = false;
      notifyListeners();
    }

  }


  // Get a list of clinics
  List<ClinicDtos> getClinics() {
    return doctorProfile?.data?.clinicDtos ?? [];
  }
}
