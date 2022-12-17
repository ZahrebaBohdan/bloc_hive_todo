import 'package:bloc_hive_todo/constants.dart';
import 'package:flutter/material.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BottomSheet(
          // enableDrag: false,
          backgroundColor: Colors.transparent,
          onClosing: () {},
          builder: ((context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'New task',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: TextField(
                              style: const TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                hintText: 'Add todo',
                                hintStyle: TextStyle(color: Colors.amber[600]),
                                filled: true,
                                fillColor: Colors.amber[100],
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              minLines: 1,
                              maxLines: null,
                              controller: _inputController,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: FloatingActionButton(
                          backgroundColor: kPrimaryColor,
                          onPressed: () {
                            Navigator.of(context).pop(_inputController.text);
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
