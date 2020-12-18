import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daloouser/src/widget/card/CardRiderActive.dart';
import 'package:flutter/material.dart';

class TeLoTraigoPage extends StatefulWidget{
  @override
  _TeLoTraigoPageState createState() => _TeLoTraigoPageState();
}

class _TeLoTraigoPageState extends State<TeLoTraigoPage> {
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("Rider").where("status",isEqualTo: true);
    
    return StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
    builder: (context, stream) {
      if (stream.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (stream.hasError) {
        return Center(child: Text(stream.error.toString()));
      }

      QuerySnapshot querySnapshot = stream.data;
      return ListView.builder(
        itemCount: querySnapshot.size,
        itemBuilder: (context, index) => CardRiderActive(querySnapshot.docs[index]),
      );
    });
  }
}