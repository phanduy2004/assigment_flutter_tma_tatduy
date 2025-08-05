import 'package:dio/dio.dart';

import '../datasource/product_remote_datasource.dart';
import '../models/either.dart';
import '../models/failure.dart';
import '../models/product.dart';
import '../repository/product_repository.dart';


class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource productRemoteDatasource;

  ProductRepositoryImpl({required this.productRemoteDatasource});



  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      return Right(
        await productRemoteDatasource.getProducts(),
      );
    } on DioException catch (e) {
      return Left(ProductFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(ProductFailure(message: e.toString()));
    }// Khớp tên phương thức
  }
}