abstract class Failure{
  final String message;

  Failure({required this.message});
}
class ProductFailure extends Failure{
  ProductFailure({required super.message});
}