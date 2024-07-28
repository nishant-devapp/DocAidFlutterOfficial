import 'package:code/appointments/models/fetch_appointment_model.dart';
import 'package:code/appointments/service/appointment_service.dart';
import 'package:flutter/material.dart';

class AppointmentProvider with ChangeNotifier {
  final AppointmentService _service = AppointmentService();

  // List<AppointmentList> _appointmentList = [];
  AppointmentList? _appointmentList;
  bool _isLoading = false;
  bool _isUpdating = false;
  bool _isUpdatingVisitStatus = false;
  bool _isUpdatingAppointment = false;
  String? _errorMessage;
  int? _selectedClinicId;
  String? _selectedDate;

  AppointmentList? get appointments => _appointmentList;

  bool get isLoading => _isLoading;

  bool get isUpdating => _isUpdating;

  bool get isUpdatingVisitStatus => _isUpdatingVisitStatus;

  bool get isUpdatingAppointment => _isUpdatingAppointment;

  String? get errorMessage => _errorMessage;

  void setSelectedDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedClinicId(int clinicId) {
    _selectedClinicId = clinicId;
    notifyListeners();
  }

  Future<void> fetchAllAppointments(String date) async {
    // if (_appointmentList != null) {
    //   return;
    //   notifyListeners();
    // }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _appointmentList = await _service.fetchAllAppointments(date);
    } catch (error) {
      _errorMessage = 'Error fetching appointments: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchClinicAppointments(int clinicId, String date) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _appointmentList = await _service.fetchClinicAppointments(clinicId, date);
    } catch (error) {
      _errorMessage = 'Error fetching appointments: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> unpayAppointment(int appointmentId) async {
    _isUpdating = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.unpayAppointment(appointmentId);
      // Update the payment status in the local list
      _appointmentList?.data?.forEach((appointment) {
        if (appointment.id == appointmentId) {
          appointment.paymentStatus = 'UNPAID';
        }
      });
      notifyListeners(); // Notify listeners to update the UI
    } catch (error) {
      _errorMessage = 'Error updating payment status: $error';
      notifyListeners();
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  Future<void> updateAppointmentVisitStatus(
      int appointmentId, bool isVisited) async {
    _isUpdatingVisitStatus = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.changeVisitStatus(appointmentId, isVisited);
      // Update the payment status in the local list
      _appointmentList?.data?.forEach((appointment) {
        if (appointment.id == appointmentId) {
          appointment.appointmentvisitStatus =
              isVisited ? 'VISITED' : 'NOT_VISITED';
        }
      });
      notifyListeners(); // Notify listeners to update the UI
    } catch (error) {
      _errorMessage = 'Error updating visit status: $error';
      notifyListeners();
    } finally {
      _isUpdatingVisitStatus = false;
      notifyListeners();
    }
  }

  Future<void> updateAppointmentInfo(
      int appointmentId,
      String name,
      String abha,
      int age,
      String contact,
      String gender,
      String appointmentDate,
      String appointmentTime,
      String clinicLocation) async {
    _isUpdatingAppointment = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.updateAppointmentInfo(appointmentId, name, abha, age,
          contact, gender, appointmentDate, appointmentTime, clinicLocation);
      // Update the payment status in the local list
      _appointmentList?.data?.forEach((appointment) {
        if (appointment.id == appointmentId) {
          appointment.name = name;
          appointment.abhaNumber = abha;
          appointment.age = age;
          appointment.contact = contact;
          appointment.gender = gender;
          appointment.appointmentDate = appointmentDate;
          appointment.appointmentTime = appointmentTime;
          appointment.clinicLocation = clinicLocation;
        }
      });
      notifyListeners(); // Notify listeners to update the UI
    } catch (error) {
      _errorMessage = 'Error updating appointment: $error';
      notifyListeners();
    } finally {
      _isUpdatingVisitStatus = false;
      notifyListeners();
    }
  }
}
