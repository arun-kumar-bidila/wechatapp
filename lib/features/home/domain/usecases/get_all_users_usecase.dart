import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/error/failure.dart';

import 'package:wechat/features/home/domain/entity/get_all_user_entity.dart';
import 'package:wechat/features/home/domain/repository/home_repository.dart';

class GetAllUsersUsecase implements Usecase<GetAllUserEntity, NoParams> {
  final HomeRepository homeRepository;
  GetAllUsersUsecase(this.homeRepository);

  @override
  Future<Either<Failure, GetAllUserEntity>> call(NoParams params) async {
    return await homeRepository.getAllUsers();
  }
}
