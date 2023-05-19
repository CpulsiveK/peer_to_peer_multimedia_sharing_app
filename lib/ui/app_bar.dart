import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/file_manager/file_manager_utils.dart';
import 'package:peer_to_peer_multimedia_sharing_application/ui/file_manager/homepage.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    actions: [
      IconButton(
        onPressed: () => createFolder(context),
        icon: const Icon(Icons.create_new_folder_outlined),
      ),
      IconButton(
        onPressed: () => sort(context),
        icon: const Icon(Icons.sort_rounded),
      ),
      IconButton(
        onPressed: () => selectStorage(context),
        icon: const Icon(Icons.sd_storage_rounded),
      )
    ],
    title: ValueListenableBuilder<String>(
      valueListenable: HomePage.controller.titleNotifier,
      builder: (context, title, _) => Text(title),
    ),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () async {
        await HomePage.controller.goToParentDirectory();
      },
    ),
  );
}
