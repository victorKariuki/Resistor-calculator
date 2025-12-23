import 'package:flutter/material.dart';
import 'history_manager.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await HistoryManager.getHistory();
    setState(() {
      _history = history;
    });
  }

  Future<void> _clearHistory() async {
    await HistoryManager.clearHistory();
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _history.isEmpty ? null : _clearHistory,
            tooltip: 'Clear History',
          ),
        ],
      ),
      body: _history.isEmpty
          ? const Center(child: Text('You have no recent calculations.'))
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final calculation = _history[index];
                return ListTile(title: Text(calculation));
              },
            ),
    );
  }
}
