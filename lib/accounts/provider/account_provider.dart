import 'package:code/accounts/model/account_model.dart';
import 'package:code/accounts/model/visit_model.dart';
import 'package:code/accounts/service/account_service.dart';
import 'package:flutter/cupertino.dart';

class AccountProvider extends ChangeNotifier {

  final AccountService _accountService = AccountService();
  VisitModel? _todayVisit, _thisMonthVisit;
  AmountModel? _todayEarning, _thisMonthEarning;
  bool _isFetchingVisit = false;
  bool _isFetchingEarning = false;
  String? _errorMessage;

  VisitModel? get todayVisit => _todayVisit;

  VisitModel? get thisMonthVisit => _thisMonthVisit;

  AmountModel? get todayEarning => _todayEarning;

  AmountModel? get thisMonthEarning => _thisMonthEarning;

  bool get isFetchingVisit => _isFetchingVisit;
  bool get isFetchingEarning => _isFetchingEarning;

  String? get errorMessage => _errorMessage;


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

}
