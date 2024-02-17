import 'package:flutter/material.dart';

import '/presentation/common/base_viewmodel.dart';
import '../../common/error_message.dart';
import '/app/app_prefs.dart';
import '/domain/models/auth.dart';
import '/domain/usecase/login_usecase.dart';
import '/presentation/resources/routes_manager.dart';
import '../../../domain/usecase/register_usecase.dart';

enum AuthMode { Login, SignUP }

class AuthViewModel extends BaseViewModel {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final AppPreference _appPreference;

  bool showPassword = false;

  final GlobalKey<FormState> formKey = GlobalKey();
  final passwordController = TextEditingController();

  AuthMode authMode = AuthMode.Login;
  Map<String, String> authData = {'email': "", 'password': ""};

  AuthViewModel(this._loginUseCase, this._registerUseCase, this._appPreference);

//!-----------------------------------------------------------------------------

  void login(String email, String password, BuildContext context) async {
    (await _loginUseCase.excute(AuthRequest(email, password))).fold((failure) {
      showErrorDialog(failure.message, context);
      isLoading = false;
      notifyListeners();
    }, (authData) {
      _appPreference.setUserLoggedIn(authData);
      Navigator.of(context).pushReplacementNamed(Routes.home);
    });
    isLoading = false;
    notifyListeners();
  }

  void register(String email, String password, BuildContext context) async {
    (await _registerUseCase.excute(AuthRequest(email, password))).fold(
        (failure) {
      showErrorDialog(failure.message, context);
      isLoading = false;
      notifyListeners();
    }, (authData) {
      _appPreference.setUserLoggedIn(authData);
      Navigator.of(context).pushReplacementNamed(Routes.home);
    });
    isLoading = false;
    notifyListeners();
  }

//!-----------------------------------------------------------------------------
  void changePassVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void submit(context) {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      formKey.currentState!.save();

      isLoading = true;
      notifyListeners();

      if (authMode == AuthMode.Login) {
        login(authData['email']!, authData['password']!, context);
      } else {
        register(authData['email']!, authData['password']!, context);
      }
    } else {
      return;
    }
  }
}
