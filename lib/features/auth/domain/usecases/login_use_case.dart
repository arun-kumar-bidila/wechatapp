
import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase implements Usecase<User, LoginUseCaseParams> {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(LoginUseCaseParams params) async {
    return await authRepository.loginUser(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginUseCaseParams {
  final String email;
  final String password;
  LoginUseCaseParams({required this.email, required this.password});
}
