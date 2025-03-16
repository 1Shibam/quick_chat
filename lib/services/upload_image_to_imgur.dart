import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quick_chat/Exports/common_exports.dart';
import 'package:quick_chat/Exports/widgets_export.dart';

Future<String?> uploadImageToImgur(BuildContext context, File imageFile) async {
  try {
    print('tried uploading image');
    final Dio dio = Dio(BaseOptions(
        baseUrl: 'https://api.imgur.com/3',
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5)));
    final cliendId = dotenv.env['IMGUR_CLIENT_ID'];
    print(cliendId);
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
    print('Image file path: ${imageFile.path}');

    print("Sending request to Imgur...");
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("📤 Sending request to: ${options.uri}");
        print("📝 Headers: ${options.headers}");
        print("📦 Data: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("✅ Response received: ${response.statusCode}");
        print("📄 Response Data: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print("❌ Dio Error: ${e.message}");
        print("⚠️ Error Type: ${e.type}");
        print("📄 Error Response: ${e.response?.data}");
        return handler.next(e);
      },
    ));

    final response = await dio.post('/image',
        data: formData, options: Options(headers: headers));
    print("Request sent.");

    if (response.statusCode == 200) {
      final String imageUrl = response.data['data']['link'];
      print('uploaded image url - $imageUrl');
      return imageUrl;
    } else {
      print("Failed to upload image: ${response.statusMessage}");
      return null;
    }
  } catch (e) {
    if (context.mounted) {
      buildSnackBar(context, 'Something went wrong to imgur',
          bgColor: AppColors.errorRedAccent);
    }
    rethrow;
  }
}
