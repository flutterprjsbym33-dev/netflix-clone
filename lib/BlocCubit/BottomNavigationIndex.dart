import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationIndex extends Cubit<int>
{
  BottomNavigationIndex():super(0);

  void addIndex(int index)
  {
    emit(index);
  }
}