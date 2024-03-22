import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/opening_hours_model.dart';
import '../../models/product_model.dart';
import '../../models/restaurant_model.dart';
import 'base_restaurant_repository.dart';

class RestaurantRepository extends BaseRestaurantRepository {
  final FirebaseFirestore _firebaseFirestore;

  RestaurantRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addRestaurant(Restaurant restaurant) async {
    await _firebaseFirestore
        .collection('restaurants')
        .add(restaurant.toDocument());
  }

  @override
  Future<void> editRestaurantSettings(Restaurant restaurant) async {
    await _firebaseFirestore
        .collection('restaurants')
        .doc('MbyvrvKY1hdNohNU11EL')
        .update(restaurant.toDocument());
  }

  @override
  Future<void> editRestaurantOpeningHours(
    List<OpeningHours> openingHours,
  ) async {
    await _firebaseFirestore
        .collection('restaurants')
        .doc('MbyvrvKY1hdNohNU11EL')
        .update({
      'openingHours': openingHours.map(
        (openingHour) {
          return openingHour.toDocument();
        },
      ).toList(),
    });
  }

  @override
  Future<void> editProducts(List<Product> products) async {
    await _firebaseFirestore
        .collection('restaurants')
        .doc('MbyvrvKY1hdNohNU11EL')
        .update({
      'products': products.map(
        (product) {
          return product.toDocument();
        },
      ).toList(),
    });
  }

  @override
  Stream<Restaurant> getRestaurant() {
    return _firebaseFirestore
        .collection('restaurants')
        .doc('MbyvrvKY1hdNohNU11EL')
        .snapshots()
        .map((snapshot) {
      return Restaurant.fromSnapshot(snapshot);
    });
  }
}
