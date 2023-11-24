import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tubes/domain/entities/login_register.dart';

final loginRegisterProvider = StateNotifierProvider<LoginAndRegister, AuthState>((ref) {
  return LoginAndRegister(ref);
});