import 'package:flutter/material.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  title:
                      Text('To get detailed records, please visit our office.'),
                ),
                ListTile(
                  title: Text('Tesla Model X'),
                  subtitle: Text("""
Duration: 11:00am. 21/02/2023 to 11:00am. 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Lexus LFA'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Toyota Prado'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Chauffeured
"""),
                ),
                ListTile(
                  title: Text('Toyota Prado (5 units)'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Wedding
"""),
                ),
                ListTile(
                  title: Text('Toyota Harrier'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Nissan Juke'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Lexus LFA'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Nissan Note'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Tesla Model X'),
                  subtitle: Text("""
Duration: 11:00am. 21/02/2023 to 11:00am. 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Lexus LFA'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Toyota Prado'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Chauffeured
"""),
                ),
                ListTile(
                  title: Text('Toyota Prado (5 units)'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Wedding
"""),
                ),
                ListTile(
                  title: Text('Toyota Harrier'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Nissan Juke'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Lexus LFA'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
                ),
                ListTile(
                  title: Text('Nissan Note'),
                  subtitle: Text("""
Duration: 08:00pm 21/02/2023 to 08:00pm 21/02/2023
Service: Self Drive
"""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
