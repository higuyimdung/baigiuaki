import 'package:flutter/material.dart';

class Modalbottom extends StatelessWidget {
  Modalbottom({Key? key, required this.AddTask}) : super(key: key);

  final Function AddTask;

  TextEditingController controller = TextEditingController();
  void _handleonclick() {
    final name = controller.text;
    AddTask(name);
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
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                onPressed: _handleonclick, child: const Text('Thêm công việc')),
          ),
        ]),
      ),
    );
  }
}
