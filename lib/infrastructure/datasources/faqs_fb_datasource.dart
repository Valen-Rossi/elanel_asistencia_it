import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elanel_asistencia_it/domain/datasources/faqs_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/faq.dart';
import 'package:elanel_asistencia_it/infrastructure/mappers/faq_mapper.dart';
import 'package:elanel_asistencia_it/infrastructure/models/firebase/faq_firebase.dart';


class FAQsFbDatasource extends IFAQsDatasource{

  final _db = FirebaseFirestore.instance.collection('faqs');

  @override
  Future<List<FAQ>> getFAQs() async {
    final snap = await _db.get();
    return snap.docs
        .map((d) => FAQMapper.toEntity(
            FAQFromFirebase.fromJson(d.id, d.data())))
        .toList();
  }
  
  @override
  Future<void> addFAQ(FAQ faq) async {
    final docRef = _db.doc(); // genera un nuevo id
    final newFAQ = faq.copyWith(id: docRef.id); // copiás el ticket con ese id

    final faqFb = FAQMapper.toFirebase(newFAQ);
    await docRef.set(faqFb.toJson());
  }
  
  @override
  Future<void> deleteFAQ(String id) async {
    await _db.doc(id).delete();
  }
  
  @override
  Future<void> updateFAQ(FAQ faq) async {
    final fb = FAQMapper.toFirebase(faq);
    await _db.doc(faq.id).update(fb.toJson());
  }
  
}