import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
Future<bool> requestPermission() async {
    bool gotPermissions = false;

    if (Platform.isAndroid) {
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        var release = androidInfo.version.release; // Version number, example: Android 12
        var sdkInt = androidInfo.version.sdkInt; // SDK, example: 31
        var manufacturer = androidInfo.manufacturer;
        var model = androidInfo.model;

        print('Android $release (SDK $sdkInt), $manufacturer $model');

        var storage = await Permission.storage.status;

        if (storage != PermissionStatus.granted) {
            await Permission.storage.request();
        }

        if (sdkInt >= 30) {
            var storageExternal = await Permission.manageExternalStorage.status;

            if (storageExternal != PermissionStatus.granted) {
                await Permission.manageExternalStorage.request();
            }

            storageExternal = await Permission.manageExternalStorage.status;

            if (storageExternal == PermissionStatus.granted 
                && storage == PermissionStatus.granted) {
                gotPermissions = true;
            }
        } else {
            // (SDK < 30)
            storage = await Permission.storage.status;

            if (storage == PermissionStatus.granted) {
                gotPermissions = true;
            }
        }
    } else if (Platform.isIOS) {
        var iosInfo = await DeviceInfoPlugin().iosInfo;
        var systemName = iosInfo.systemName; // Example: iOS
        var version = iosInfo.systemVersion; // Version number, example: 14.0
        var name = iosInfo.name; // Device name, example: iPhone
        var model = iosInfo.model; // Model, example: iPhone 12

        print('$systemName $version, $name $model');

        var photos = await Permission.photos.status;

        if (photos != PermissionStatus.granted) {
            await Permission.photos.request();
        }

        photos = await Permission.photos.status;

        if (photos == PermissionStatus.granted) {
            gotPermissions = true;
        }
    }

    return gotPermissions;
}