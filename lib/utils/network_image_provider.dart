import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:ui';

class NetworkImageProvider extends ImageProvider<NetworkImageProvider> {
  final String imageUrl;
  final Map<dynamic, dynamic>? headers;

  NetworkImageProvider(this.imageUrl, {this.headers});

  @override
  Future<NetworkImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<NetworkImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(
      NetworkImageProvider key, ImageDecoderCallback decode) {
    final Completer<ImageInfo> completer = Completer();

    _loadImage().then((Uint8List? data) async {
      if (data != null) {
        final codec = await decode(await ImmutableBuffer.fromUint8List(data));
        completer
            .complete(ImageInfo(image: (await codec.getNextFrame()).image));
      } else {
        completer.completeError('Failed to load image');
      }
    }).catchError((e) {
      completer.completeError(e);
    });

    return OneFrameImageStreamCompleter(completer.future);
  }

  Future<Uint8List?> _loadImage() async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print("Image request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error loading image: $e");
    }
    return null;
  }
}
