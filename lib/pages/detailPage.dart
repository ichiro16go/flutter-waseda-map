import 'package:flutter/material.dart';
import '../type/type.dart';
import '../compornents/timelineChips.dart';
import '../testData/testData.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<Event> _posts = Testdata().events;
  final List<EventPhotos> photos = Testdata().event_photos;
  Map<String, String> texts = {
    "title": "title",
    "description": "description",
    "site": "site",
  };

  void edit_info(String key){
    TextEditingController controller = TextEditingController(text: texts[key]);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${key}を編集", textAlign: TextAlign.center,),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "新しいテキストを入力"),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text("キャンセル"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text("保存"),
                  onPressed: () {
                    setState(() {
                      texts[key] = controller.text;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.grey[300],
            child: const Center(child: Text('photo')),
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(texts["title"]!, style: const TextStyle(fontSize: 24)),
              ),
              SizedBox(
                height: 24,
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                          onPressed: () {
                            edit_info("title");
                          },
                          icon: Icon(Icons.edit),
                          iconSize: 24,
                        ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(texts["description"]!),
              ),
              SizedBox(
                  height: 14,
                  child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                          onPressed: () {edit_info("description");},
                          icon: Icon(Icons.edit),
                          iconSize: 14,
                        ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(texts["site"]!),
              ),
              SizedBox(
                height: 14,
                child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                        onPressed: () {edit_info("site");},
                        icon: Icon(Icons.edit),
                        iconSize: 14,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('timeline', style: TextStyle(fontSize: 18)),
          Expanded(
            child:ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return Timelinechips(
                    event: _posts[index], event_photos: photos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
