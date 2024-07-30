import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:physio_app/bloc/forgot%20password/forgot_password_bloc.dart';
import 'package:physio_app/bloc/home/home_screen_bloc.dart';
import 'package:physio_app/bloc/injury/injury_bloc.dart';
import 'package:physio_app/bloc/player/player_bloc.dart';
import 'package:physio_app/models/player.dart';
import 'package:physio_app/ui/add_injury.dart';
import 'package:physio_app/ui/add_player_screen.dart';
import 'package:physio_app/ui/all_players_screen.dart';
import 'package:physio_app/ui/auth/code_verification_screen.dart';
import 'package:physio_app/ui/auth/create_password_screen.dart';
import 'package:physio_app/ui/auth/forgot_password_screen.dart';
import 'package:physio_app/ui/auth/login_screen.dart';
import 'package:physio_app/ui/edit_player.dart';
import 'package:physio_app/ui/home_screen.dart';
import 'package:physio_app/ui/injury_details.dart';
import 'package:physio_app/ui/add_injury_details.dart';
import 'package:physio_app/ui/player_profile.dart';

class AppRouter {
  PlayerBloc palyerBloc = PlayerBloc();
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case '/home':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: HomeScreenBloc(),
                  child: const HomeScreen(),
                ));
      case '/player profile':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                     BlocProvider(
                      create:(_) => PlayerBloc(),
                      ),
                      BlocProvider(
                      create:(_) => InjuryBloc(),
                      ),
                  ],
                  child: PlayerProfile(
                    player: settings.arguments as Player,
                  ),
                ));

      case '/forgot_password_screen':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => ForgotPasswordBloc(),
                  child: ForgotPassword(),
                ));
      case '/add player':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => PlayerBloc(),
                  child: const AddPlayerScreen(),
                ));
      case '/code_verification_screen':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: ForgotPasswordBloc(),
                  child: CodeVerificationScreen(
                    email: settings.arguments as String,
                  ),
                ));
      case '/All players':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => PlayerBloc(),
                  child: const AllPlayersScreen(),
                ));
      case '/injury details':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => InjuryBloc(),
                  child: const InjuryDetailsScreen(
                      // injury: settings.arguments as Injury,

                      ),
                ));
      case '/add injury':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => InjuryBloc(),
                  child: const AddInjuryScreen(),
                ));
      case '/add_injury_2':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => InjuryBloc(),
                  child: const AddInjuryDetails(),
                ));
      case'/new_password_screen':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => ForgotPasswordBloc(),
                  child: const CreatePasswordScreen(),
                ));
      case '/edit_player':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => PlayerBloc(),
                  child:  ModifyPlayerScreen(
                    player: settings.arguments as Player,
                  ),
                ));
    }
      

    return null;
  }
}
