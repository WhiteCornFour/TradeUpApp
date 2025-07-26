import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';

class UploadImageReport extends StatefulWidget {
  final VoidCallback onPressed;
  final List<File> imageList;

  const UploadImageReport({
    super.key,
    required this.onPressed,
    required this.imageList,
  });

  @override
  State<UploadImageReport> createState() => _UploadImageReportState();
}

class _UploadImageReportState extends State<UploadImageReport> {
  void _removeImage(File file) {
    setState(() {
      widget.imageList.remove(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.imageList.isEmpty
            ? Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('lib/assets/images/noimageavailable.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.imageList.map((file) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              file,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => _removeImage(file),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
        const SizedBox(width: 10),
        MaterialButton(
          color: AppColors.header,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: widget.onPressed,
          child: const Text(
            'Upload Now',
            style: TextStyle(
              color: AppColors.text,
              fontFamily: 'Roboto-Black',
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
