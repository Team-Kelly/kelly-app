import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.notification,
    Permission.locationAlways,
    Permission.accessMediaLocation,
    Permission.manageExternalStorage,
    //Permission.accessMediaLocation,
    Permission.storage,
    Permission.bluetooth,
    //Permission.ignoreBatteryOptimizations,
    Permission.systemAlertWindow,
  ].request();

  bool permitted = true;

  statuses.forEach((permission, permissionStatus) {
    if (permissionStatus.isDenied){
      permitted = false;
    }
  });
  return permitted;
}

//https://github.com/Baseflow/flutter-permission-handler/blob/develop/permission_handler/example/android/app/src/main/AndroidManifest.xml