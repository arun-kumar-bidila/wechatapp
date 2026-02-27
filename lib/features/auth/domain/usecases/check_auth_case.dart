import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/features/auth/domain/repository/auth_repository.dart';

class CheckAuthCase implements Usecase<User, NoParams> {
  final AuthRepository authRepository;
  CheckAuthCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.checkAuth();
  }
}
