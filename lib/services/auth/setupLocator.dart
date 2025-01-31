import 'package:food_delivery/services/database/firestore_service.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';
import 'user_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService(FirebaseAuth.instance));
  locator.registerLazySingleton(
      () => FirestoreService(FirebaseFirestore.instance));
  locator.registerLazySingleton(() =>
      UserRepository(locator<AuthService>(), locator<FirestoreService>()));
}
