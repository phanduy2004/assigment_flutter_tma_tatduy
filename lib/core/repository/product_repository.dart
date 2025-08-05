
import '../models/failure.dart';
import '../models/product.dart';
import '../models/either.dart';

abstract class ProductRepository{
  Future<Either<Failure,List<Product>>> getProducts();
}