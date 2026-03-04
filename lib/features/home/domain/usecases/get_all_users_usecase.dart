import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/features/home/domain/repository/home_repository.dart';

class GetAllUsersUsecase implements Usecase<List<User>, NoParams> {
  final HomeRepository homeRepository;
  GetAllUsersUsecase(this.homeRepository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await homeRepository.getAllUsers();
  }
}
