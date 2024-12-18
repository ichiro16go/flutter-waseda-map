import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../type/type.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({
    super.key,
    required this.event,
    required this.event_photos,
  });

  final Event event;
  final EventPhotos event_photos;

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  List<String> photos = [
    'https://i.pinimg.com/736x/97/b6/61/97b6613b005a1abfef9a10acae7ff698.jpg',
    'https://i.pinimg.com/736x/dc/36/51/dc3651f0fa684ee2b2e5ec3fe4258433.jpg',
    'https://i.pinimg.com/736x/18/b8/01/18b8015b44ada986137d9e572fe66cf9.jpg'
  ];
  late final Uri nativeUrlTwitter;
  late final Uri webUrlTwitter;
  late final Uri nativeUrlInstagram;
  late final Uri webUrlInstagram;
  @override
  void initState() {
    super.initState();
    nativeUrlTwitter =
        Uri.parse('twitter://user?screen_name=${widget.event.twitter}');
    webUrlTwitter = Uri.parse('https://twitter.com/${widget.event.twitter}');
    nativeUrlInstagram =
        Uri.parse('instagram://user?screen_name=${widget.event.instagram}');
    webUrlInstagram = Uri.parse('https://instagram.com/${widget.event.instagram}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // コンテンツ部分
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),

                ///イベントタイトル
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    widget.event.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 38),
                  ),
                ),

                ///写真
                Center(
                  child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: PageView.builder(
                        itemCount: photos.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.black,
                            child: Center(
                              child: Image.network(
                                photos[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      )),
                ),

                //詳細情報
                Container(
                  child: Text(
                    widget.event.detail ?? '詳細情報がありません',
                    style: const TextStyle(),
                  ),
                ),
                //SNSへつながるボタン
                Container(
                  child: Row(
                    children: [
                      //twitterボタン
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          onPressed: () async {
                            if (await canLaunchUrl(nativeUrlTwitter)) {
                              await launchUrl(
                                nativeUrlTwitter,
                                mode: LaunchMode.externalApplication,
                              );
                            } else if (await canLaunchUrl(webUrlTwitter)) {
                              await launchUrl(
                                webUrlTwitter,
                                mode: LaunchMode.platformDefault,
                              );
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.black),
        
        
                        ),
                      ),
                      //isntagramボタン
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          onPressed: () async {
                            if (await canLaunchUrl(nativeUrlInstagram)) {
                              await launchUrl(
                                nativeUrlInstagram,
                                mode: LaunchMode.externalApplication,
                              );
                            } else if (await canLaunchUrl(webUrlInstagram)) {
                              await launchUrl(
                                webUrlInstagram,
                                mode: LaunchMode.platformDefault,
                              );
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 左上に戻るボタン
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // 前の画面に戻る
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back, // 左矢印アイコン
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
