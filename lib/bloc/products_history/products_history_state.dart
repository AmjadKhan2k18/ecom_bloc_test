part of 'products_history_bloc.dart';

abstract class RecentProductsState extends Equatable {
  const RecentProductsState();

  @override
  List<Object> get props => [];
}

class RecentProductsInitial extends RecentProductsState {}

class RecentProductsLoaded extends RecentProductsState {
  final Map<String, ProductDetail> recents;
  const RecentProductsLoaded(this.recents);

  @override
  List<Object> get props => [recents];
}
