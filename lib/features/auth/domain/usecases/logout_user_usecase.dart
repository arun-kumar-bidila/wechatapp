import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/auth/domain/repository/auth_repository.dart';


class LogoutUserUsecase implements Usecase<String, NoParams> {
  final AuthRepository authRepository;
  LogoutUserUsecase(this.authRepository);
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.logooutUser();
  }
}
