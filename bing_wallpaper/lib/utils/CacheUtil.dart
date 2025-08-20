import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheHelper{
  static const _TAG = "CacheHelper";

  static Future<File?> getImageCacheFile(String uri) async {
    var fileInfo = await DefaultCacheManager().getFileFromCache(uri);
    var cachedFile = fileInfo?.file;
    return cachedFile;
  }

  static Future<void> saveImageToDevice(
      BuildContext context,
      String uri,
      ) async {
    try {
      var cachedFile = await getImageCacheFile(uri);
      if (cachedFile == null) {
        return;
      }
      var save = false;
      if (save) {
        var uuid = Uuid();
        var id = uuid.v4();
        String newPath =
            '${(await getApplicationDocumentsDirectory()).path}/$id.jpg';
        await cachedFile.copy(newPath);
        if (context.mounted) {
          showContentDialog(context, "", '');
        }
      }
    } catch (e) {
      if (context.mounted) {
        showContentDialog(context, "", "");
      }
    }
  }

  static void showContentDialog(
      BuildContext context,
      String title,
      String message,
      ) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          Button(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.pop(context, 'User deleted file');
              // Delete file here
            },
          ),
          FilledButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
  }
}