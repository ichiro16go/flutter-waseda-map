import 'package:flutter/material.dart';
import '../pages/postPage.dart';

class PostButton extends StatelessWidget {
  const PostButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostPage()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(155, 0, 63, 1),
          padding: const EdgeInsets.all(10),
          shape: const CircleBorder(),
          minimumSize: const Size(80, 80),
        ),
        child: const Icon(
          Icons.post_add,
          color: Colors.white,
          size: 36.0,
        ));
  }
}
