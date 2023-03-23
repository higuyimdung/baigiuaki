import 'dart:html';

import 'package:dunghaha/modal/item.dart';
import 'package:flutter/material.dart';

import 'widget/cart_body_widget.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<DataItems> items = [];

  void _handleaddtask(String name, DateTime time) {
    final newItem =
        DataItems(id: DateTime.now().toString(), name: name, deadline: time);

    setState(() {
      items.add(newItem);
    });
  }

  void _handleDelete(String id) {
    items.removeWhere((item) => item.id == id);
    setState(() {
      items.removeWhere((item) => item.id == id);
    });
  }

  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Danh sách công việc',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: items
                .map((item) => Cartbody(
                      item: item,
                      handleDelete: _handleDelete,
                    ))
                .toList(),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            isScrollControlled: true,
            context: context,
            builder: (BuildContext content) {
              return Modalbottom(AddTask: _handleaddtask);
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}

class Modalbottom extends StatefulWidget {
  Modalbottom({Key? key, required this.AddTask}) : super(key: key);
  final Function AddTask;

  @override
  State<Modalbottom> createState() => _ModalbottomState();
}

class _ModalbottomState extends State<Modalbottom> {
  DateTime currentDate = DateTime.now();

  TextEditingController controller = TextEditingController();

  void _handleonclick(BuildContext context) {
    final name = controller.text;

    if (name.isEmpty) {
      return;
    }
    widget.AddTask(name, currentDate);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'công việc')),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2050));
                if (pickedDate != null && pickedDate != currentDate) {
                  print(pickedDate);
                  setState(() {
                    currentDate = pickedDate;
                  });
                }
              },
              child: Text('${currentDate}')),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                onPressed: () => _handleonclick(context),
                child: const Text('Thêm công việc')),
          ),
        ]),
      ),
    );
  }
}
