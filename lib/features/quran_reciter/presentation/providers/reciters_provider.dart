import 'package:flutter/material.dart';
import 'package:iccmw/features/quran_reciter/business/usecases/get_reciter_usecase.dart';
import 'package:iccmw/features/quran_reciter/data/models/reciter_model.dart';

class ReciterProvider with ChangeNotifier {
  final GetReciterUseCase _getReciterUseCase;
  List<ReciterModel>? _reciterList;
  ReciterModel? _selectedReciter;
  bool _isLoading = true;

  ReciterProvider(this._getReciterUseCase);

  List<ReciterModel>? get reciterList => _reciterList;
  ReciterModel? get selectedReciter => _selectedReciter;
  bool get isLoading => _isLoading;

  Future<void> fetchReciters() async {
    _isLoading = true;
    notifyListeners();

    try {
      _reciterList = await _getReciterUseCase.execute();
      if (_reciterList != null && _reciterList!.isNotEmpty) {
        _selectedReciter = _reciterList!.first;
      }
    } catch (e) {
      _reciterList = [];
      // print("Error fetching reciters: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectReciter(ReciterModel reciter) {
    _selectedReciter = reciter;
    notifyListeners();
  }
}
