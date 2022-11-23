import 'brand.dart';

// enum MediaType{
//   image,
//   video,
// }
class Story{
  final String url;
  final String media;
  final Duration duration;

  Story({required this.url,required this.media,required this.duration});
  factory Story.fromMap(Map<String,dynamic> map){
    return Story(
      url:map['url'],
      media: map['media'],
      duration: Duration(seconds:map['duration'] ),
    );
  }
  Map<String,dynamic> toMap(){
    return{
      'url':url,
      'media':media,
      'duration':duration.inSeconds,
    };
  }
}