import 'dart:math';
import 'package:flutter/material.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/resources/string_manager.dart';
import '/presentation/resources/values_manager.dart';
import '../../resources/constants_manager.dart';
import '../../common/widgets/login_signup.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.blue,
                    ColorManager.deepPurple,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    AppConstants.gradiantStopsValue1,
                    AppConstants.gradiantStopsValue2
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSize.s100),
                    Container(
                      margin: const EdgeInsets.all(AppMargin.m20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p40, vertical: AppPadding.p8),
                      transform: Matrix4.rotationZ(-AppConstants.rotationValue *
                          (pi / AppConstants.degree180))
                        ..translate(-AppConstants.shiftingValue),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s20),
                          color: ColorManager.lightBlue,
                          boxShadow: const [
                            BoxShadow(
                                color: ColorManager.black38,
                                blurRadius: AppConstants.blurRadius,
                                offset:
                                    Offset(AppConstants.dx, AppConstants.dy))
                          ]),
                      child: Text(
                        StringsManager.maShop,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Flexible(
                      child: LoginSignup(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
