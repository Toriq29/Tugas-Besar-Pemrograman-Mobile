import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/domain/usecase/user_usecase.dart';

final loginRegisterProvider = StateNotifierProvider<LoginAndRegister, AuthState>((ref) {
  return LoginAndRegister(ref);
});