import 'package:fpdart/fpdart.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase implements Usecase<User, SignUpUseCaseParams> {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(SignUpUseCaseParams params) async {
    return await authRepository.signUpUser(
      email: params.email,
      fullName: params.fullName,
      password: params.password,
      bio: params.bio,
    );
  }
}

class SignUpUseCaseParams {
  final String email;
  final String password;
  final String fullName;
  final String bio;

  SignUpUseCaseParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.bio,
  });
}
