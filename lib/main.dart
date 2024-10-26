import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showTip = true;
  final _indexOfTipItem = 10;

  final List<String> _items = List.generate(50, (i) => '${i + 1}');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // other slivers
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (_indexOfTipItem == index && _showTip) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _buildItem(_items[index]),
                        Positioned(
                          left: 16,
                          right: 16,
                          top: 48,
                          child: _buildTip(),
                        ),
                      ],
                    );
                  }
                  return _buildItem(_items[index]);
                },
                childCount: _items.length,
              ),
            ),
            // other slivers
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String text) {
    return Container(
      width: double.infinity,
      color: Colors.black26,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }

  Widget _buildTip() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.amber),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Here is tip text or something else. Tips may be higher. Must be displayed under all items',
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => setState(() => _showTip = false),
              child: const Text('ok'),
            ),
          )
        ],
      ),
    );
  }
}
