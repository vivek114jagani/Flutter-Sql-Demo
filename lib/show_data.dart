import 'package:flutter/material.dart';
import 'helper/database_helper.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  DatabaseHelper db = DatabaseHelper.instance;

  List<Map<String, Object?>>? userData = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    userData = await db.getData();
    setState(() {});
    // ignore: avoid_print
    print(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: userData?.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                "${userData?[index]['firstname']} ${userData?[index]['lastname']}"),
            subtitle: Text("${userData?[index]['email']}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    db.updateRecord("vivek", "jagani", "vivekjagani@gmail.com",
                        id: "${userData?[index]['id']}");
                    userData = await db.getData();
                    setState(() {});
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async {
                    db.deleterecord("${userData?[index]['id']}");
                    userData = await db.getData();
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
