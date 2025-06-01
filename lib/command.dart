// lib/command.dart

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_app/result.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

/// Comando que não recebe parâmetros (ex.: obter cidade atual)
class Command0<T> extends ChangeNotifier {
  Command0(this._action);

  final CommandAction0<T> _action;
  bool _isExecuting = false;
  Object? _lastError;

  bool get isExecuting => _isExecuting;
  Object? get lastError => _lastError;

  Future<Result<T>> execute() async {
    if (_isExecuting) {
      return Result.error(Exception('Command0 is already running'));
    }
    _isExecuting = true;
    _lastError = null;
    notifyListeners();

    try {
      final result = await _action();
      if (result is Error<T>) {
        _lastError = result.error;
      }
      return result;
    } catch (e) {
      _lastError = e;
      return Result.error(e as Exception);
    } finally {
      _isExecuting = false;
      notifyListeners();
    }
  }
}

/// Comando que recebe um parâmetro A (ex.: obter clima com nome da cidade)
class Command1<T, A> extends ChangeNotifier {
  Command1(this._action);

  final CommandAction1<T, A> _action;
  bool _isExecuting = false;
  Object? _lastError;

  bool get isExecuting => _isExecuting;
  Object? get lastError => _lastError;

  Future<Result<T>> execute(A arg) async {
    if (_isExecuting) {
      return Result.error(Exception('Command1 is already running'));
    }
    _isExecuting = true;
    _lastError = null;
    notifyListeners();

    try {
      final result = await _action(arg);
      if (result is Error<T>) {
        _lastError = result.error;
      }
      return result;
    } catch (e) {
      _lastError = e;
      return Result.error(e as Exception);
    } finally {
      _isExecuting = false;
      notifyListeners();
    }
  }
}
