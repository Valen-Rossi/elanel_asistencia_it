import 'package:elanel_asistencia_it/domain/entities/faq.dart';
import 'package:elanel_asistencia_it/infrastructure/models/firebase/faq_firebase.dart';

class FAQMapper {

  static FAQ toEntity(FAQFromFirebase fb) {
    return FAQ(
      id: fb.id,
      title: fb.title,
      description: fb.description,
      type: FAQTypeX.fromString(fb.type),
    );
  }

  static FAQFromFirebase toFirebase(FAQ f) {
    return FAQFromFirebase(
      id: f.id,
      title: f.title,
      description: f.description,
      type: f.type.name,
    );
  }
}