import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqf_database_tuts/services/db_helper.dart';

class DatabaseScreen extends StatelessWidget {
  const DatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper.instance.insertRecord(
                  {
                    DatabaseHelper.columnName: "fourth column",
                  },
                );
                log('record created with column name');
              },
              child: const Text('Create'),
            ),
            ElevatedButton(
              onPressed: () async {
                var dbquery = await DatabaseHelper.instance.queryDatabase();
                log('$dbquery');
                log('Readed Record');
              },
              child: const Text('Read'),
            ),

            // for updating the record which is in map form...
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper.instance.updateRecord(
                  {
                    DatabaseHelper.columnId: 1,
                    DatabaseHelper.columnName: "ali",
                  },
                );
                log('record updated');
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper.instance.deleteRecord(2);
                log('record deleted');
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
