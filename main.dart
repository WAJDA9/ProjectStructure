import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:physio_app/Repositories/user_repository.dart';
import 'package:physio_app/bloc/auth/auth_bloc.dart';
import 'package:physio_app/const/colors.dart';
import 'package:physio_app/const/utils.dart';
import 'package:physio_app/router/app_router.dart';
import 'package:physio_app/services/api_service.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeUtil.init(context);
    var router = AppRouter();
    return SafeArea(
      child: BlocProvider(
        create: (context) => AuthBloc(UserRepository(apiService: ApiService())),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.inter().fontFamily,
            scaffoldBackgroundColor: AppColors.backGroundColor,
          ),
          title: 'Physio App',
          onGenerateRoute: router.onGenerateRoute,
        ),
      ),
    );
  }
}
