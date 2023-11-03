import 'package:barberapp/src/utils/getDeviceInfo.dart';
import 'package:flutter/material.dart';

avatar(context, [AssetImage avatarUrl]) {
  if (avatarUrl != null) {
    return CircleAvatar(
      backgroundImage: avatarUrl,
      radius: getDeviceHeight(context) * 0.06,
      backgroundColor: Colors.white,
    );
  }
  return CircleAvatar(
    radius: getDeviceHeight(context) * 0.05,
    backgroundColor: Colors.white,
  );
}
