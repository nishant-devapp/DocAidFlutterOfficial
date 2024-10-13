import 'package:code/accounts/model/account_model.dart';
import 'package:code/accounts/model/subscription_history_model.dart';
import 'package:code/accounts/model/visit_model.dart';
import 'package:code/accounts/service/account_service.dart';
import 'package:flutter/cupertino.dart';

import '../../home/models/home_get_model.dart';

class AccountProvider extends ChangeNotifier {

  final AccountService _accountService = AccountService();
  VisitModel? _todayVisit, _thisMonthVisit;
  AmountModel? _todayEarning, _thisMonthEarning;
  SubscriptionHistoryModel? _subscriptionHistory;
  List<ClinicDtos> _clinics = [];
  Map<int, Map<String, dynamic>> _weeklyGraphData = {};
  bool _isFetchingVisit = false;
  bool _isFetchingWeeklyGraph = false;
  bool _isFetchingSubscriptionHistory = false;
  bool _isFetchingEarning = false;
  String? _errorMessage;

  List<ClinicDtos> get clinics => _clinics;
  Map<int, Map<String, dynamic>> get weeklyGraphData => _weeklyGraphData;
  VisitModel? get todayVisit => _todayVisit;

  VisitModel? get thisMonthVisit => _thisMonthVisit;

  AmountModel? get todayEarning => _todayEarning;
  SubscriptionHistoryModel? get subscriptionHistory => _subscriptionHistory;

  AmountModel? get thisMonthEarning => _thisMonthEarning;

  bool get isFetchingVisit => _isFetchingVisit;
  bool get isFetchingSubscriptionHistory => _isFetchingSubscriptionHistory;
  bool get isFetchingEarning => _isFetchingEarning;
  bool get isFetchingWeeklyGraph => _isFetchingWeeklyGraph;

  String? get errorMessage => _errorMessage;

  void loadClinics(List<ClinicDtos> clinics) {
    _clinics = clinics;
    notifyListeners();
  }

  Future<void> fetchTodayVisit() async {
    _isFetchingVisit = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _todayVisit = await _accountService.countTodayVisit();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isFetchingVisit = false;
      notifyListeners();
    }
  }

  Future<void> fetchThisMonthVisit() async {
    _isFetchingVisit = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _thisMonthVisit = await _accountService.countThisMonthVisit();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isFetchingVisit = false;
      notifyListeners();
    }
  }

  Future<void> fetchTodayEarning() async {
    _isFetchingEarning = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _todayEarning = await _accountService.countTodayEarning();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isFetchingEarning = false;
      notifyListeners();
    }
  }

  Future<void> fetchThisMonthEarning() async {
    _isFetchingEarning = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _thisMonthEarning = await _accountService.countThisMonthEarning();
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isFetchingEarning = false;
      notifyListeners();
    }
  }

  Future<void> fetchSubscriptionHistory(int doctorId) async {

    if (_subscriptionHistory != null) {
      return;
    }

    _isFetchingSubscriptionHistory = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _subscriptionHistory = await _accountService.fetchSubscriptionHistory(doctorId);
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isFetchingSubscriptionHistory = false;
      notifyListeners();
    }
  }

  // Future<void> fetchWeeklyDataForClinics() async {
  //   _isFetchingWeeklyGraph = true;
  //   _errorMessage = null;
  //   notifyListeners();
  //
  //   try {
  //     for (ClinicDtos clinic in _clinics) {
  //         final data = await _accountService.fetchWeeklyGraphByClinicId(clinic.id!);
  //         _weeklyGraphData[clinic.id!] = data; // Store income data by clinic ID
  //
  //     }
  //   } catch (error) {
  //     _errorMessage = error.toString();
  //   } finally {
  //     _isFetchingWeeklyGraph = false;
  //     notifyListeners();
  //   }
  // }

}
