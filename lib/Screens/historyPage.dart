import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  // final List<String> historyItems;

  // const HistoryPage({super.key, required this.historyItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      // body: ListView.builder(
      //   // itemCount: historyItems.length,
        
      // ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item),
      ),
      body: Center(
        child: Text('Detail untuk $item'),
      ),
    );
  }
}
