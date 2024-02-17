import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/resources/constants_manager.dart';
import '/presentation/resources/string_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../auth_screen/viewmodel/viewmodel.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: AppConstants.animationDuration));
    slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.1), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: animationController, curve: Curves.fastOutSlowIn));
    opacityAnimation = Tween<double>(begin: 0.0, end: 1.00).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dS = MediaQuery.sizeOf(context);
    var authViewModel = context.read<AuthViewModel>();
    return Container(
      width: dS.width,
      height: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p15),
      child: Form(
        key: authViewModel.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s25),
                color: ColorManager.white,
              ),
              padding: const EdgeInsets.all(AppPadding.p12),
              child: TextFormField(
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: StringsManager.email,
                    prefixIcon: Icon(Icons.email, color: ColorManager.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: ColorManager.black87),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return StringsManager.enterEmail;
                    }
                    if (!value.contains('@')) {
                      return StringsManager.invalidEmail;
                    }
                    return null;
                  },
                  onSaved: (inputValue) {
                    authViewModel.authData['email'] = inputValue!;
                  }),
            ),
            const SizedBox(height: AppSize.s20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s25),
                color: ColorManager.white,
              ),
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Selector<AuthViewModel, bool>(
                  selector: (_, auth) => auth.showPassword,
                  builder: (context, showPass, _) {
                    return TextFormField(
                        controller:
                            context.read<AuthViewModel>().passwordController,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          hintText: StringsManager.password,
                          prefixIcon: const Icon(Icons.no_encryption_outlined,
                              color: ColorManager.grey),
                          suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<AuthViewModel>()
                                    .changePassVisibility();
                              },
                              icon: showPass
                                  ? const Icon(Icons.visibility_sharp,
                                      color: Colors.grey)
                                  : const Icon(Icons.visibility_off,
                                      color: Colors.grey)),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: ColorManager.black87),
                        obscureText: showPass ? false : true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return StringsManager.enterPassword;
                          }
                          if (value.length <= 5) {
                            return StringsManager.enterValidPassword;
                          }
                          return null;
                        },
                        onSaved: (inputValue) {
                          context.read<AuthViewModel>().authData['password'] =
                              inputValue!;
                        });
                  }),
            ),
            const SizedBox(height: AppSize.s20),
            AnimatedContainer(
              constraints: BoxConstraints(
                  maxHeight:
                      authViewModel.authMode == AuthMode.SignUP ? 110 : 0,
                  maxWidth:
                      authViewModel.authMode == AuthMode.SignUP ? dS.width : 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s25),
                color: ColorManager.white,
              ),
              padding: const EdgeInsets.all(AppPadding.p12),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeIn,
              child: FadeTransition(
                opacity: opacityAnimation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      hintText: StringsManager.confirmPassword,
                      prefixIcon: Icon(Icons.no_encryption_outlined,
                          color: ColorManager.grey),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: ColorManager.black87),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: context.watch<AuthViewModel>().showPassword
                        ? false
                        : true,
                    enabled: authViewModel.authMode == AuthMode.SignUP,
                    validator: authViewModel.authMode == AuthMode.SignUP
                        ? (value) {
                            if (value!.isEmpty) {
                              return StringsManager.pleaseConfirmPassword;
                            }
                            if (value !=
                                authViewModel.passwordController.text) {
                              return StringsManager.passwordMatching;
                            }
                            return null;
                          }
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s30),
            context.watch<AuthViewModel>().isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: dS.width,
                    child: ElevatedButton(
                      onPressed: () {
                        authViewModel.submit(context);
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: AppPadding.p20)),
                          backgroundColor:
                              MaterialStateProperty.all(ColorManager.lightBlue),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s22)))),
                      child: Text(
                        authViewModel.authMode == AuthMode.Login
                            ? StringsManager.login
                            : StringsManager.signup,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: ColorManager.white),
                      ),
                    ),
                  ),
            const SizedBox(height: AppSize.s10),
            TextButton(
              onPressed: () {
                setState(() {
                  switch (authViewModel.authMode) {
                    case AuthMode.Login:
                      authViewModel.authMode = AuthMode.SignUP;
                      animationController.forward();
                      break;
                    case AuthMode.SignUP:
                      authViewModel.authMode = AuthMode.Login;
                      animationController.reverse();
                      break;
                  }
                });
              },
              child: Text(
                authViewModel.authMode == AuthMode.Login
                    ? StringsManager.dontHaveAcc
                    : StringsManager.haveAcc,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: ColorManager.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
