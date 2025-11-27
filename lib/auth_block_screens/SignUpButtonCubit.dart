import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButtonCubit extends Cubit<int>
{
  SignUpButtonCubit():super(0);

  void addIndex(int index)
  {
    emit(index);
  }
}