import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<String> historyItems;

  const HistoryPage({super.key, required this.historyItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(historyItems[index]),
            onTap: () {
              // Navigasi ke halaman yang sesuai
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(item: historyItems[index]),
                ),
              );
            },
          );
        },
      ),
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
