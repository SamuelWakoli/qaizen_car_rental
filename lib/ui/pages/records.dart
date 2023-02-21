import 'package:flutter/material.dart';

//todo: if service request is/was approved(bool), show records
//TODO use PDFs only for records
class RecordsPage extends StatefulWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Records'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 810),
          child: ListView(
            children: const [
              ListTile(
                title: Text('Tesla Model X'),
                subtitle: Text("""
Date:
Duration: 
Service: 
"""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
