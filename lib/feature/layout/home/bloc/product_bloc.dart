

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/feature/layout/home/bloc/product_event.dart';
import 'package:hello/feature/layout/home/bloc/product_state.dart';

import '../../../../core/repository/product_repository.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState>{
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}): super(ProductState.initial()){
    on<GetProductEvent>(onGetProductEvent);
  }


  Future onGetProductEvent(GetProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    var result = await productRepository.getProducts();
    result.fold((l) {
      emit(state.copyWith(status: ProductStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(status: ProductStatus.success, product: r));
    });
  }

}