import 'package:hive/hive.dart';

part 'image.g.dart'; 

@HiveType(typeId: 3) 
class ImageMapping {
  @HiveField(0)
  int id;

  @HiveField(1)
  String imageFile;

  ImageMapping({required this.id, required this.imageFile});

}

