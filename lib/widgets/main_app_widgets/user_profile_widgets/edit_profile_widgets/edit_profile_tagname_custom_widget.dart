import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class TagNameCustomEditProfile extends StatefulWidget {
  final TextEditingController controller;

  const TagNameCustomEditProfile({super.key, required this.controller});

  @override
  State<TagNameCustomEditProfile> createState() =>
      _TagNameCustomEditProfileState();
}

class _TagNameCustomEditProfileState extends State<TagNameCustomEditProfile> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 150,
            child: TextField(
              controller: widget.controller,
              onTap: () {
                widget.controller.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: widget.controller.text.length,
                );
              },
              readOnly: !_isEditing,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                border: _isEditing
                    ? OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.header,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      )
                    : InputBorder.none,
              ),

              style: const TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              size: 20,
              color: AppColors.header,
            ),
            onPressed: () => setState(() => _isEditing = !_isEditing),
            padding: EdgeInsets.all(15),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
