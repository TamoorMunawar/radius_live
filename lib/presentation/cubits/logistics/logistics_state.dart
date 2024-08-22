import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/logictis/logistics.dart';
import '../../../domain/repository/logistics_repo.dart';

// States
abstract class BuyAssetState {}

class BuyAssetInitial extends BuyAssetState {}

class BuyAssetLoading extends BuyAssetState {}

class BuyAssetLoaded extends BuyAssetState {
  final List<BuyAssetHistory> assets;

  BuyAssetLoaded(this.assets);
}

class BuyAssetError extends BuyAssetState {
  final String message;

  BuyAssetError(this.message);
}

// Cubit
class BuyAssetCubit extends Cubit<BuyAssetState> {
  final BuyAssetRepository repository;

  BuyAssetCubit(this.repository) : super(BuyAssetInitial());

  Future<void> fetchAssets() async {
    try {
      emit(BuyAssetLoading());
      var assets = await repository.fetchBuyAssets();
      if (assets.isEmpty) {
        print("Assets list is empty after fetching");
      } else {
        print("Fetched ${assets.length} assets");
      }
      emit(BuyAssetLoaded(assets));
    } catch (e) {
      print('Error in fetchAssets: $e');
      emit(BuyAssetError(e.toString()));
    }
  }

}
