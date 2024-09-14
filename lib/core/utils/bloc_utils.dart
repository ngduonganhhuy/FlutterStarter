import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aes_room/core/utils/injection.dart';

class BlocUtils {
  static void add<T extends BlocEventSink>(dynamic event) {
    Injection.navKey.currentContext!.read<T>().add(event);    
  }
}
