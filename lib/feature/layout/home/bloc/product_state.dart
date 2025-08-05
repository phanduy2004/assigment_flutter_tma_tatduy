import 'package:equatable/equatable.dart';

import '../../../../core/models/product.dart';



enum ProductStatus { initial, loading, success, error }

class ProductState extends Equatable {
  final ProductStatus status;
  final String? errorMessage;
  final List<Product> product;

  const ProductState._({
    required this.status,
    this.errorMessage,
    this.product = const [],
  });

  factory ProductState.initial() =>
      const ProductState._(status: ProductStatus.initial);

  ProductState copyWith({
    ProductStatus? status,
    String? errorMessage,
    List<Product>? product,
  }) =>
      ProductState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        product: product ?? this.product,
      );


  @override
  List<Object?> get props => [status, errorMessage, product];
}
