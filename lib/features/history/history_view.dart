
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'history_manager.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<HistoryManager>(context, listen: false).clearHistory();
            },
            tooltip: 'Clear History',
          ),
        ],
      ),
      body: Consumer<HistoryManager>(
        builder: (context, historyManager, child) {
          if (historyManager.history.isEmpty) {
            return const Center(
              child: Text('No history yet.'),
            );
          }

          return ListView.builder(
            itemCount: historyManager.history.length,
            itemBuilder: (context, index) {
              final historyItem = historyManager.history[index];
              return ListTile(
                title: Text(historyItem),
              );
            },
          );
        },
      ),
    );
  }
}
