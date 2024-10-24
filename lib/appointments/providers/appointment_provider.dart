import 'package:code/appointments/models/fetch_appointment_model.dart';
import 'package:code/appointments/service/appointment_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/payment_info_model.dart';

class AppointmentProvider with ChangeNotifier {
  final AppointmentService _service = AppointmentService();

  AppointmentList? _appointmentList;
  PaymentInfoModel? _paymentInfoModel;
  Map<String, int>? _appointmentCounts;
  Map<String, int>? _clinicWiseAppointmentCounts;
  bool _isLoading = false;
  bool _isUpdating = false;
  bool _isUpdatingVisitStatus = false;
  bool _isUpdatingAppointment = false;
  bool _isDeletingAppointment = false;
  bool _isMakingAppointmentPayment = false;
  bool _isInProcess = true;
  String? _errorMessage;

  AppointmentList? get appointments => _appointmentList;

  PaymentInfoModel? get paymentInfoModel => _paymentInfoModel;

  Map<String, int>? get appointmentCounts => _appointmentCounts;
  Map<String, int>? get clinicWiseAppointmentCounts => _clinicWiseAppointmentCounts;

  bool get isLoading => _isLoading;

  bool get isUpdating => _isUpdating;

  bool get isUpdatingVisitStatus => _isUpdatingVisitStatus;

  bool get isUpdatingAppointment => _isUpdatingAppointment;
  bool get isDeletingAppointment => _isDeletingAppointment;

  bool get isMakingAppointmentPayment => _isMakingAppointmentPayment;

  bool get isInProcess => _isInProcess;

  String? get errorMessage => _errorMessage;

  Future<void> fetchAllAppointments(String date) async {

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _appointmentList = await _service.fetchAllAppointments(date);
      _appointmentList = _sortAppointmentsByTime(_appointmentList);
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
      _appointmentList = _sortAppointmentsByTime(_appointmentList);
    } catch (error) {
      _errorMessage = 'Error fetching appointments: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  AppointmentList _sortAppointmentsByTime(AppointmentList? appointmentList) {
    if (appointmentList == null || appointmentList.data == null) {
      return appointmentList!;
    }

    final DateFormat timeFormatter = DateFormat('HH:mm:ss');

    appointmentList.data!.sort((a, b) {
      final timeA = timeFormatter.parse(a.appointmentTime ?? '00:00:00');
      final timeB = timeFormatter.parse(b.appointmentTime ?? '00:00:00');
      return timeA.compareTo(timeB);
    });

    return appointmentList;
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


  Future<void> bookAppointment(
      int clinicId,
      String name,
      String abha,
      String age,
      String contact,
      String address,
      String guardian,
      String gender,
      String appointmentDate,
      String appointmentTime,
      String clinicLocation) async{

    _isInProcess = true;
    _errorMessage = null;
    notifyListeners();

    try{

      await _service.addNewAppointment(clinicId, name, abha, age, contact, address, guardian, gender, appointmentDate, appointmentTime, "UNPAID", clinicLocation);

      _appointmentList = await _service.fetchAllAppointments(appointmentDate);
      _appointmentList = _sortAppointmentsByTime(_appointmentList);

    }catch (error) {
      _errorMessage = 'Error booking appointment: $error';
      notifyListeners();
    } finally {
      _isInProcess = false;
      notifyListeners();
    }

  }

  Future<void> updateAppointmentInfo(
      int appointmentId,
      String name,
      String abha,
      int age,
      String contact,
      String address,
      String guardianName,
      String gender,
      String appointmentDate,
      String appointmentTime,
      String clinicLocation) async {
    _isUpdatingAppointment = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.updateAppointmentInfo(appointmentId, name, abha, age,
          contact, address, guardianName, gender, appointmentDate, appointmentTime, clinicLocation);
      // Update the payment status in the local list
      _appointmentList?.data?.forEach((appointment) {
        if (appointment.id == appointmentId) {
          appointment.name = name;
          appointment.abhaNumber = abha;
          appointment.age = age;
          appointment.contact = contact;
          appointment.address = address;
          appointment.guardianName = guardianName;
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

  Future<void> deleteAppointment(int appointmentId, String paymentStatus) async{
    _isDeletingAppointment = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final isDeleted = await _service.deleteAppointment(appointmentId, paymentStatus);

      if(isDeleted){
        _appointmentList?.data?.removeWhere((appointment) => appointment.id == appointmentId);
        notifyListeners(); // Notify listeners to update the UI
      }

    } catch (error) {
      _errorMessage = 'Error deleting appointment: $error';
      notifyListeners();
    } finally {
      _isDeletingAppointment = false;
      notifyListeners();
    }
  }

  Future<void> makeAppointmentPayment(
      int appointmentId, String modeOfPayment, String amount, String appointmentDate, int clinicId, int doctorId) async {
    _isMakingAppointmentPayment = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.createAppointmentPayment(
          appointmentId, modeOfPayment, amount, appointmentDate, clinicId, doctorId);
      // Update the payment status in the local list
      _appointmentList?.data?.forEach((appointment) {
        if (appointment.id == appointmentId) {
          appointment.paymentStatus = 'PAID';
        }
      });
      // notifyListeners();
    } catch (error) {
      _errorMessage = 'Error making payment: $error';
      // notifyListeners();
    } finally {
      _isMakingAppointmentPayment = false;
      notifyListeners(); // Notify listeners to update the UI
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

  Future<void> getAppointmentPaymentInfo(int appointmentId) async {
    _isInProcess = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _paymentInfoModel = await _service.getAppointmentPayment(appointmentId);
    } catch (error) {
      _errorMessage = 'Error fetching payment info: $error';
    } finally {
      _isInProcess = false;
      notifyListeners();
    }
  }

  Future<void> updateAppointmentPayment(
      int appointmentId, String modeOfPayment, String amount, String appointmentDate, int clinicId, int doctorId) async {
    _isInProcess = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _service.updateAppointmentPayment(
           appointmentId, modeOfPayment, amount, appointmentDate, clinicId, doctorId);

      _paymentInfoModel = await _service.getAppointmentPayment(appointmentId);
      notifyListeners(); // Notify listeners to update the UI
    } catch (error) {
      _errorMessage = 'Error updating payment: $error';
      notifyListeners();
    } finally {
      _isInProcess = false;
      notifyListeners();
    }
  }


  Future<void> fetchCalendarAppointmentCount(int docId, String startDate, String endDate) async{

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final counts = await _service.fetchCalendarAppointmentCount(docId, startDate, endDate);
      print('Counts Fetched for Calendar: $counts');  // Add this line to verify fetched data
      _appointmentCounts = counts;
    } catch (e) {
      _errorMessage = 'Failed to load appointment counts: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchClinicWiseAppointmentCount(String localDate) async{

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final clinicAppointCount = await _service.fetchClinicWiseAppointmentCount(localDate);
      print('Counts Fetched for clinic: $clinicAppointCount');  // Add this line to verify fetched data
      _clinicWiseAppointmentCounts = clinicAppointCount;
    } catch (e) {
      _errorMessage = 'Failed to load appointment counts: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}

