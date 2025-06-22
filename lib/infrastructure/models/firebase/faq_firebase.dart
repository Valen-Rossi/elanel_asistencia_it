
import 'package:elanel_asistencia_it/domain/entities/faq.dart';

class FAQFromFirebase {
  final String id;
  final String title;
  final String description;
  final String type;

  FAQFromFirebase({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
  });

  factory FAQFromFirebase.fromJson(String id, Map<String, dynamic> json) {
    return FAQFromFirebase(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? FAQType.other.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
    };
  }
  
}