import 'package:rent_application/helpers/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_application/main.dart';

class FirestoreService {
  static Future getUserById(String uid) async {
    DocumentSnapshot doc = await fbFirestore.collection('users').doc(uid).get();
    return doc.data();
  }

  static Future<bool> initCurrentUser(String uid) async {
    try {
      bool value =
          await fbFirestore.collection('users').doc(uid).get().then((result) {
        if (result.exists) {
          return true;
        } else {
          return false;
        }
      });
      return value;
    } catch (e) {
      return false;
    }
  }

  static Future<void> addHomePhone(String address, String code) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('homePhones').doc();
    ref.set({'id': ref.id, 'address': address, 'code': code});
  }

  static Future getHomePhones(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('homePhones').doc(id).get();
    return doc.data();
  }

  // Добавление фото на модерацию , создание ссылки на фото
  static Future<void> addPhotoInValid(
      DateTime date, String url, String appartmentUid) async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection('loadPhoto').doc();
    ref.set({'date': date, 'uid': appartmentUid, 'url': url, 'id': ref.id});
  }
}
