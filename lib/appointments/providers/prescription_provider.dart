import 'package:code/appointments/service/prescription_service.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class PrescriptionProvider with ChangeNotifier {
  final PrescriptionService _prescriptionService = PrescriptionService();

  List<Uint8List> _mediaItems = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Uint8List> get mediaItems => _mediaItems;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchPrescriptions(String contact) async {

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _mediaItems = await _prescriptionService.fetchPrescription(contact);
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
