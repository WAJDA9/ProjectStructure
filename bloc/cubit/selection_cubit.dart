import 'package:flutter_bloc/flutter_bloc.dart';

enum Selection { email, phone }

class SelectionCubit extends Cubit<Selection> {
  SelectionCubit() : super(Selection.email);

  void selectEmail() => emit(Selection.email);
  void selectPhone() => emit(Selection.phone);
}
