import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget dpWidget({double radius, url, File image}) {
  return url != null
      ? Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xff00263b), width: 5)),
          child: CircleAvatar(
              backgroundColor: Colors.black,
              maxRadius: radius,
              backgroundImage: image != null
                  ? FileImage(image)
                  : (CachedNetworkImageProvider(
                      url = url,
                    ))),
        )
      : Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        );
}
