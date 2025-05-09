// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

void main() => runApp(HashLensApp());

class HashLensApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hash Lens',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF121212),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF1F1B24),
          secondary: Color(0xFF8E6FFF),
        ),
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.grey[300])),
      ),
      home: HashHome(),
    );
  }
}

class HashHome extends StatefulWidget {
  @override
  _HashHomeState createState() => _HashHomeState();
}

class _HashHomeState extends State<HashHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1F1B24),
        title: Text('Hash Lens'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, size: 24),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Coming soon!'),
                  duration: Duration(milliseconds: 800),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.history, size: 24),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Coming soon!'),
                  duration: Duration(milliseconds: 800),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.public, size: 24),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Coming soon!'),
                  duration: Duration(milliseconds: 800),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(0xFF8E6FFF),
          labelColor: Color(0xFF8E6FFF), // selected tab text/icon color
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(icon: Icon(Icons.text_fields), text: 'Text'),
            Tab(icon: Icon(Icons.insert_drive_file), text: 'File'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [HashTextPage(), FileHashPage()],
      ),
    );
  }
}

class HashTextPage extends StatefulWidget {
  @override
  _HashTextPageState createState() => _HashTextPageState();
}

class _HashTextPageState extends State<HashTextPage> {
  final _textController = TextEditingController();
  final _compareController = TextEditingController();
  String? _selectedAlgo = 'SHA-256';
  String _outputHash = '';

  final List<String> _algorithms = ['MD5', 'SHA-1', 'SHA-256', 'SHA-512'];

  void _generateHash() {
    final input = _textController.text;
    if (input.isEmpty || _selectedAlgo == null) {
      setState(() {
        _outputHash = '';
      });
      return;
    }

    List<int> bytes = utf8.encode(input);
    Digest digest;

    switch (_selectedAlgo) {
      case 'MD5':
        digest = md5.convert(bytes);
        break;
      case 'SHA-1':
        digest = sha1.convert(bytes);
        break;
      case 'SHA-256':
        digest = sha256.convert(bytes);
        break;
      case 'SHA-512':
        digest = sha512.convert(bytes);
        break;
      default:
        digest = sha256.convert(bytes);
    }

    setState(() {
      _outputHash = digest.toString();
    });
  }

  void _compareHash() {
    bool match = _compareController.text.trim() == _outputHash;
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            content: Text(
              match ? 'Hashes match!' : 'Hashes do not match.',
              style: TextStyle(
                color: match ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: IntrinsicWidth(
              child: DropdownButtonFormField<String>(
                value: _selectedAlgo,
                dropdownColor: Color(0xFF1F1B24),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF1F1B24),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0x9E9E9E)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF8E6FFF)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                items:
                    _algorithms
                        .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                        .toList(),
                onChanged: (val) => setState(() => _selectedAlgo = val),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            cursorColor: Colors.white,
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Enter text for hashing',
              labelStyle: TextStyle(color: Colors.grey[500]),
              floatingLabelStyle: TextStyle(color: Color(0xFF8E6FFF)),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              filled: true,
              fillColor: Color(0xFF1F1B24),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1F1B24)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF8E6FFF)),
              ),
            ),
            maxLines: null,
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8E6FFF),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: _generateHash,
              child: Text('Generate Hash from Text'),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text('Hash:', style: TextStyle(color: Colors.grey[300])),
              ),
              if (_outputHash.isNotEmpty)
                IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.all(4),
                  icon: Icon(Icons.copy, size: 20),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _outputHash));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF1F1B24),
              borderRadius: BorderRadius.circular(4),
            ),
            child: SelectableText(
              _outputHash,
              style: TextStyle(fontFamily: 'monospace'),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            cursorColor: Colors.white,
            controller: _compareController,
            decoration: InputDecoration(
              labelText: 'Enter hash for comparison',
              labelStyle: TextStyle(color: Colors.grey[500]),
              floatingLabelStyle: TextStyle(color: Color(0xFF8E6FFF)),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              filled: true,
              fillColor: Color(0xFF1F1B24),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1F1B24)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF8E6FFF)),
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8E6FFF),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: _compareHash,
              child: Text('Compare Hashes'),
            ),
          ),
        ],
      ),
    );
  }
}

class FileHashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'File Hash Checker coming soon',
        style: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}
