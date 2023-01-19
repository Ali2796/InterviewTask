import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Avatar {
  static getUserAvatar({required String url}) {
    return CircleAvatar(
      child: CachedNetworkImage(
        imageUrl: url,
        errorWidget: (context, url, error) => FaIcon(FontAwesomeIcons.camera),
        placeholder: (context, url) => FaIcon(FontAwesomeIcons.camera),
      ),
    );
  }
}
