import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final DownloadStatus status = controller.status;
        final bool isNotDownloaded = status == DownloadStatus.notDownloaded;
        final double totalSize = controller.ressource.size.toDouble();
        final double downloadedSize = totalSize * controller.progress;
        final double percent = controller.progress * 100;

        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: isNotDownloaded ? controller.startDownload : null,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.ressource.name,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.text,
                          fontSize: 22,
                        ),
                      ),
                      if (!isNotDownloaded) ...[
                        const SizedBox(height: 6),
                        Text(
                          _statusText(
                            status,
                            percent,
                            downloadedSize,
                            totalSize,
                          ),
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.textLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(_statusIcon(status), color: AppColors.iconNormal),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _statusIcon(DownloadStatus status) {
    if (status == DownloadStatus.notDownloaded) {
      return Icons.download;
    }

    if (status == DownloadStatus.downloading) {
      return Icons.downloading;
    }

    return Icons.folder;
  }

  String _statusText(
    DownloadStatus status,
    double percent,
    double downloadedSize,
    double totalSize,
  ) {
    if (status == DownloadStatus.downloading) {
      return "${percent.toStringAsFixed(1)} % completed - "
          "${downloadedSize.toStringAsFixed(1)} of ${totalSize.toStringAsFixed(0)} MB";
    }

    return "100.0 % completed - "
        "${totalSize.toStringAsFixed(1)} of ${totalSize.toStringAsFixed(0)} MB";
  }
}
