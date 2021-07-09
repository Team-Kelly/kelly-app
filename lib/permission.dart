import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.notification,
    Permission.location,
    Permission.accessMediaLocation,
    //Permission.calendar
  ].request();

  bool permitted = true;

  statuses.forEach((permission, permissionStatus) {
    if (permissionStatus.isDenied){
      permitted = false;
    }
  });
  return permitted;
}