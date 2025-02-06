import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../firebase_options.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _controller = TextEditingController();
  int _characterCount = 0;
  final int _maxCharacters = 280;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> getImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = pickedFile;
    });
  }

  Future<void> getImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateCharacterCount);
  }

  void _updateCharacterCount() {
    setState(() {
      _characterCount = _controller.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('新規投稿'),
        actions: [TextButton(onPressed: () {}, child: const Text('投稿する'))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'いまどうしてる？',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            if (_image != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.file(
                  File(_image!.path),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: getImageFromGallery,
                ),
                const Spacer(),
                Text(
                  '$_characterCount / $_maxCharacters',
                  style: TextStyle(
                    color: _characterCount > _maxCharacters
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
