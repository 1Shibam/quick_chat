import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/Exports/widgets_export.dart';

Future<String?> uploadImageToImgur(BuildContext context, File imageFile) async {
  try {
    final Dio dio = Dio(BaseOptions(
        baseUrl: 'https://api.imgur.com/3',
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5)));
    final cliendId = dotenv.env['IMGUR_CLIENT_ID'];
    if (cliendId == null || cliendId.isEmpty) {
      throw Exception("Error - IMGUR_CLIENT_ID is missing");
    }

    //preparing headers -
    final headers = {'Authorization': 'Client-ID $cliendId'};
    //Preparing form data -
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: 'profileUpload.jpg',
      ),
      'type': 'image',
      'title': 'Profile Picture',
      'description': 'uploaded via quick Chat App' 
    });

    final response = await dio.post('/image',
        data: formData, options: Options(headers: headers));

    if (response.statusCode == 200) {
      final String imageUrl = response.data['data']['link'];
      debugPrint('uploaded image url - $imageUrl');
      return imageUrl;
    } else {
      debugPrint("Failed to upload image: ${response.statusMessage}");
      return null;
    }
  } catch (e) {
    if (context.mounted) {
      buildSnackBar(context, 'Something went wrong',
          bgColor: AppColors.errorRedAccent);
    }
    rethrow;
  }
}
