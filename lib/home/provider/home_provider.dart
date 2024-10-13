import 'dart:io';

import 'package:code/home/models/home_get_model.dart';
import 'package:code/home/service/home_service.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class HomeGetProvider extends ChangeNotifier {
  final HomeGetService _homeGetService = HomeGetService();
  HomeGetModel? _doctorProfile;
  Uint8List? _profileImage, _prescriptionImage;
  bool _isLoading = false;
  bool _isUpdatingProfile = false;
  bool _isAddingClinic = false;
  bool _isUpdatingClinic = false;
  bool _isUpdatingImage = false;
  bool _isFetchingImage = false;
  String? _errorMessage;

  HomeGetModel? get doctorProfile => _doctorProfile;

  Uint8List? get profileImage => _profileImage;
  Uint8List? get prescriptionImage => _prescriptionImage;

  bool get isLoading => _isLoading;

  bool get isUpdatingProfile => _isUpdatingProfile;

  bool get isUpdatingImage => _isUpdatingImage;

  bool get isAddingClinic => _isAddingClinic;

  bool get isUpdatingClinic => _isUpdatingClinic;

  bool get isFetchingImage => _isFetchingImage;

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

  Future<void> fetchDoctorImage() async {
    if (_profileImage != null) {
      return;
    }
    _isFetchingImage = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _profileImage = await _homeGetService.fetchDoctorImage();
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Failed to load image: $error';
    } finally {
      _isFetchingImage = false;
      notifyListeners();
    }
  }

  Future<void> fetchPrescriptionImage(int clinicId) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try{
      _prescriptionImage = await _homeGetService.fetchClinicPrescriptionImage(clinicId);
      notifyListeners();
    }catch(error){
      _errorMessage = 'Failed to load prescription images: $error';
    }finally{
      _isLoading = false;
      notifyListeners();
    }

  }

  Future<void> uploadPrescriptionImage(File file, int clinicId) async{
    _isUpdatingImage = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _homeGetService.uploadClinicPrescription(file, clinicId);
      _prescriptionImage = await file.readAsBytes();
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isUpdatingImage = false;
      notifyListeners();
    }
  }

  Future<void> updateDoctorImage(File imageFile) async {
    _isUpdatingImage = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Call the service class to upload the image
      await _homeGetService.updateDoctorImage(imageFile);
      _profileImage = await imageFile.readAsBytes();
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isUpdatingImage = false;
      notifyListeners();
    }
  }

  Future<void> updateDoctorProfile(
      String firstName,
      String lastName,
      String email,
      String contact,
      List<String> degrees,
      List<String> achievements,
      List<String> researchJournal,
      List<String> citations,
      List<String> specialization,
      int experience,
      String licenceNumber) async {
    _isUpdatingProfile = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _homeGetService.updateDoctorProfile(
          firstName,
          lastName,
          email,
          contact,
          degrees,
          achievements,
          researchJournal,
          citations,
          specialization,
          experience,
          licenceNumber);

      _doctorProfile = await _homeGetService.fetchDoctorProfile();

      notifyListeners(); // Notify listeners to update the UI
    } catch (error) {
      _errorMessage = 'Error updating profile: $error';
      notifyListeners();
    } finally {
      _isUpdatingProfile = false;
      notifyListeners();
    }
  }

  Future<int?> addClinic(
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
      final int? clinicId = await _homeGetService.addNewClinic(clinicName, location, incharge,
          startTime, endTime, clinicContact, clinicNewFee, clinicOldFees, days);

      _doctorProfile = await _homeGetService.fetchDoctorProfile();
      return clinicId;
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
  ) async {
    _isUpdatingClinic = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _homeGetService.updateClinic(
          clinicId,
          clinicName,
          location,
          incharge,
          startTime,
          endTime,
          clinicContact,
          clinicNewFee,
          clinicOldFees,
          days);

      doctorProfile?.data?.clinicDtos?.forEach((clinic) {
        if (clinic.id == clinicId) {
          clinic.clinicName = clinicName;
          clinic.location = location;
          clinic.incharge = incharge;
          clinic.startTime = startTime;
          clinic.endTime = endTime;
          clinic.clinicContact = clinicContact;
          clinic.clinicNewFees = double.parse(clinicNewFee);
          clinic.clinicOldFees = double.parse(clinicOldFees);
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

  Future<void> deleteClinic(int clinicId) async{
    _isUpdatingClinic = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final isDeleted = await _homeGetService.deleteClinic(clinicId);

      if(isDeleted){
        doctorProfile?.data?.clinicDtos?.removeWhere((clinic) => clinic.id == clinicId);
        notifyListeners();
      }

    } catch (error) {
      _errorMessage = 'Error deleting clinic: $error';
      notifyListeners();
    } finally {
      _isUpdatingClinic = false;
      notifyListeners();
    }
  }

  Future<void> addDoctorSchedule(String startTime, String endTime,
      String location, String purpose, String startDate, String endDate) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _homeGetService.addNewSchedule(
          startTime, endTime, location, purpose, startDate, endDate);
      _doctorProfile = await _homeGetService.fetchDoctorProfile();
    } catch (error) {
      _errorMessage = 'Error adding schedule: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDoctorSchedule(
      int interfaceId,
      String startTime,
      String endTime,
      String location,
      String purpose,
      String startDate,
      String endDate) async {
    _isUpdatingClinic = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _homeGetService.updateSchedule(interfaceId, startTime, endTime,
          location, purpose, startDate, endDate);

      doctorProfile?.data?.docIntr?.forEach((intr) {
        if (intr.id == interfaceId) {
          intr.clinicName = location;
          intr.purpose = purpose;
          intr.stDate = startDate;
          intr.endDate = endDate;
          intr.startTime = startTime;
          intr.endTime = endTime;
        }
      });
    } catch (error) {
      _errorMessage = 'Error updating clinic: $error';
    } finally {
      _isUpdatingClinic = false;
      notifyListeners();
    }
  }

  Future<void> deleteSchedule(int interfaceId) async{
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final isDeleted = await _homeGetService.deleteSchedule(interfaceId);

      if(isDeleted){
        _doctorProfile?.data?.docIntr?.removeWhere((intr) => intr.id == interfaceId);
        notifyListeners(); // Notify listeners to update the UI
      }

    } catch (error) {
      _errorMessage = 'Error deleting appointment: $error';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get a list of active clinics
  List<ClinicDtos> getClinics() {
    return doctorProfile?.data?.clinicDtos
        ?.where((clinic) => clinic.clinicStatus == "Active")
        .toList() ?? [];
  }

  // Get list of all clinics
  List<ClinicDtos> getAllClinics(){
    print("Doctor clinics: ${doctorProfile?.data?.clinicDtos}");
    return doctorProfile?.data?.clinicDtos ?? [];
  }


  int? getDoctorId(){
    return doctorProfile?.data?.id;
  }

}
