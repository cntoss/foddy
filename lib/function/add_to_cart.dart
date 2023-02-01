import 'dart:convert';

import 'package:foody/user/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:foody/product/mode/product_model.dart';
import 'package:flutter/material.dart';
import '../common/app_constant.dart';

class AddToCart {
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<UserModel> checkUser(
      {String? phone,
      String? displayName,
      String? address,
      String? profileImage}) async {
    try {
      String uuId = FirebaseAuth.instance.currentUser!.uid;
      DataSnapshot data = await database.ref('Users/$uuId').get();
      if (data.value != null) {
        return UserModel.fromJson(jsonDecode(jsonEncode(data.value)));
        
      } else {
        UserModel user = UserModel(
            id: uuId,
            phone: phone,
            userDisplayName: displayName,
            address: address,
            profileUrl: profileImage);
        await database.ref('$UserModel/${user.id}').set(user.toJson());
        return user;
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      rethrow;
    }
  }

  Future updateUser(UserModel user) async {
    try {
      await database.ref('$userModel/${user.id}').set(user.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUser(String id) async {
    try {
      DataSnapshot data = await database.ref('Users/$id').get();
      if (data.value != null) {
        return UserModel.fromJson(jsonDecode(jsonEncode(data.value)));
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addProduct(ProductModel productModel) async {
    try {
      //  DataSnapshot userData = await FirebaseDatabase.instance.ref('Products').get();
      DatabaseReference reference =
          FirebaseDatabase.instance.ref().child('Products').push();
      productModel.id = reference.key;
      await reference
          .update(productModel.toJson())
          .onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      throw Exception(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateProduct(ProductModel productModel) async {
    try {
      DatabaseReference reference =
          FirebaseDatabase.instance.ref().child('Products/${productModel.id}');
      await reference.set(productModel.toJson()).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      throw Exception(e);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteProduct(String ref) async {
    try {
      DatabaseReference reference =
          FirebaseDatabase.instance.ref().child('Products/$ref');
      await reference.remove();
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      throw Exception(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeFile(String? url) async {
    if (url != null) {
      try {
        await firebase_storage.FirebaseStorage.instance
            .refFromURL(url)
            .delete();
      } on FirebaseException catch (e) {
        debugPrint(e.toString());
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
