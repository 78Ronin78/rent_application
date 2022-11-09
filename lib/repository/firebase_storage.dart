import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:rent_application/helpers/firebase_constants.dart';
import 'package:rent_application/repository/firestore_srevice.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class StorageRepo {
  // FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: 'gs://meetingchat-2d401.appspot.com');
  // final firebaseDB = FirebaseFirestore.instance;
  // var _auth = FirebaseAuth.instance;

  dowloadImageUserProfile() async {
    fbStorage.ref().child('users/123/avatar.*');
  }

  // Загрузка фото пользователем по одной фотографии
  Future<void> uploadImage(File image, String uid) async {
    DateTime time = DateTime.now();

    // Кидаем фотку на модерацию
    await fbStorage.ref('validPhoto/$uid/${time.toString()}').putFile(image);

    FirestoreService.addPhotoInValid(
        time, 'validPhoto/$uid/${time.toString()}', uid);
  }

  // Загрузка несколько фотографий сразу, для карусели
  Future<void> uploadAllImages(Asset asset, String uid) async {
    DateTime time = DateTime.now();
    ByteData byteData =
        await asset.getByteData(); // requestOriginal is being deprecated
    List<int> imageData = byteData.buffer.asUint8List();
    await fbStorage
        .ref('validPhoto/$uid/${time.toString()}')
        .putData(imageData);
    FirestoreService.addPhotoInValid(
        time, 'validPhoto/$uid/${time.toString()}', uid);
  }

  // Установка аватара из слайдера фотографий
  Future<void> setAvatar(String url, String uid) async {
    fbFirestore.collection('apartments').doc(uid).update({'avatar': url});
  }

  // Загрузка аватара пользователем (по кнопке фотоаппарата в профиле), аватар хранится независимо от других фоток
  // Аватар изначально загружается на модерацию
  Future<void> uploadAvatar(File image, String uid) async {
    DateTime time = DateTime.now();
    //await fbStorage.ref('validAvatar/$uid/validAvatar').putFile(image);
    await fbStorage.ref('avatar/$uid/avatar').putFile(image);
    // Ссылка на аву которая еще на модерации
    String downloadUrl =
        //await fbStorage.ref('validAvatar/$uid/validAvatar').getDownloadURL();
        await fbStorage.ref('avatar/$uid/avatar').getDownloadURL();

    // Меняем поле у юзера что некая аватарка находится на валидации и ссылка на нее
    //что бы отобразить у пользователя
    /*await fbFirestore
        .collection(USERS)
        .doc(uid)
        .update({'validAvatar': downloadUrl});
    FirestoreService.addAvatarValid(time, 'validAvatar/$uid/validAvatar');*/
    await fbFirestore
        .collection(USERS)
        .doc(uid)
        .update({'avatar': downloadUrl});
    FirestoreService.addAvatarValid(time, 'avatar/$uid/avatar');
  }

  // Удаление фото из слайдера
  Future<void> deleteImage(String url, String uid) async {
    // Если удалить фото из слайдера а оно стоит на аватаре, аватарка устанавливается рандомно как при регистрации
    var res = await fbFirestore.collection(USERS).doc(uid).get();
    String urlAvatar = res['avatar'];
    if (urlAvatar == url) {
      print('Выполняется условие с совпадением аватаров');
      String newImageUrl = await randomGenerateAvatar();
      fbFirestore.collection(USERS).doc(uid).update({'avatar': newImageUrl});
    } else {
      print('Выполняется другое условие');
      // Удалении фото по url, пока не знаю как сделать лучше чем это , сначала получаем url каждой
      // фотографии находящейся в папке /images/uid/
      // И сравниваем каждый url с тем что пришли в параметрах
      //  Если совпадает удаляем фотографию
      var response =
          await fbStorage.ref().child('validPhoto').child(uid).listAll();
      print('Количество фотографий: ${response.items.length}');
      print('Количество фотографий: ${response.items}');
      await Future.forEach(response.items, (element) async {
        String ur = await fbStorage.ref(element.fullPath).getDownloadURL();
        if (ur == url) {
          print('Ссылки не совпадают');
          await fbStorage.ref().child(element.fullPath).delete();
        } else {
          print('Ссылки совпадают');
        }
      });
    }
  }

  // Удаление аватара по кнопке в профиле
  // Если аватарка была выбрана из тех картинок что в слайдере, фото  останется в слайдере
  // а сама ава поменяется на рандомную как при регистрации
  // Если аватарка была загружена на прямую через профиль
  // То она останется в storage/avatar/uid/mainPhoto ее можно не удалять тк
  // в следующий раз если пользователь обновит аву то она в starage/avatar/uid просто перезапишется
  Future<void> removeAvatar(String uid) async {
    String newImageUrl = await randomGenerateAvatar();
    fbFirestore.collection(USERS).doc(uid).update({
      'avatar': newImageUrl,
    });
  }

  Future<void> removeAvatarValid(String uid) async {
    fbFirestore.collection(USERS).doc(uid).update({'validAvatar': null});
  }

  // Просто рандом заранее добавленых аватаров для присвоения при регистрации или при удалении аватара
  Future<String> randomGenerateAvatar() async {
    var rng = new Random();
    var allListImage = await fbStorage.ref().child('avatar').listAll();
    int i = rng.nextInt(allListImage.items.length);
    String downloadURL = await fbStorage
        .ref('avatar/${allListImage.items[i].name}')
        .getDownloadURL();
    return downloadURL;
  }
}

StorageRepo storageRepo = StorageRepo();
