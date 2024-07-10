import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_task_app/data/models/task.dart';
import 'package:to_do_task_app/presentation/views/task/bloc/task_bloc.dart';
import 'package:to_do_task_app/presentation/views/task/bloc/task_event.dart';
import 'package:to_do_task_app/presentation/views/task/bloc/task_state.dart';
import 'package:to_do_task_app/presentation/views/task/constant/filter_item.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskListView();
  }
}

class _TaskListView extends State<TaskListView> {
  List<Task> tasks = List.empty(growable: true);
  List<Task> filterTask = List.empty(growable: true);
  TextEditingController nameController = TextEditingController();
  final TextEditingController menuController = TextEditingController();
  FilterItem? selectedMenu;
  int selectedIndex = -1;
  bool isFilterApplied = false;
  @override
  void initState() {
    BlocProvider.of<TaskBloc>(context).add(GetTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Task List'),
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        builder: (context, state) {
          return getBody(context, state);
        },
        listener: (context, state) {
          if (state is TaskLoadedState) {
            tasks.add(Task(name: state.taskEntity.taskName ?? '', status: "P"));
          }
        },
      ),
    );
  }

  Widget getBody(BuildContext context, TaskState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
                hintText: 'Task Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ))),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    //
                    String name = nameController.text.trim();
                    if (name.isNotEmpty) {
                      setState(() {
                        nameController.text = '';
                        tasks.add(Task(name: name, status: 'P'));
                      });
                    }
                    //
                  },
                  child: const Text('Add')),
              ElevatedButton(
                  onPressed: () {
                    //
                    String name = nameController.text.trim();
                    if (name.isNotEmpty) {
                      setState(() {
                        nameController.text = '';

                        tasks[selectedIndex].name = name;
                        selectedIndex = -1;
                      });
                    }
                    //
                  },
                  child: const Text('Update')),
              DropdownMenu<FilterItem>(
                initialSelection: menuItems.first,
                controller: menuController,
                width: 150,
                hintText: "Select Item",
                requestFocusOnTap: true,
                label: const Text('Select Item'),
                onSelected: (FilterItem? menu) {
                  selectedMenu = menu;
                  if (menu?.status == 'Completed') {
                    isFilterApplied = true;
                    List<Task> mlist = [];
                    tasks.map((e) {
                      if (e.status == 'C') {
                        mlist.add(Task(name: e.name, status: e.status));
                      }
                    }).toList();
                    filterTask = mlist;
                  } else if (menu?.status == 'Pending') {
                    isFilterApplied = true;
                    List<Task> mlist = [];
                    tasks.map((e) {
                      if (e.status == "P") {
                        mlist.add(Task(name: e.name, status: e.status));
                      }
                    }).toList();
                    filterTask = mlist;
                  } else {
                    isFilterApplied = false;
                  }
                  setState(() {});
                },
                dropdownMenuEntries: menuItems
                    .map<DropdownMenuEntry<FilterItem>>((FilterItem menu) {
                  return DropdownMenuEntry<FilterItem>(
                    value: menu,
                    label: menu.status,
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          tasks.isEmpty
              ? const Text(
                  'No Task yet..',
                  style: TextStyle(fontSize: 22),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: isFilterApplied == true
                        ? filterTask.length
                        : tasks.length,
                    itemBuilder: (context, index) => getRow(index),
                  ),
                )
        ],
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            tasks[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isFilterApplied == true
                  ? filterTask[index].name
                  : tasks[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 120,
          child: Row(
            children: [
              Checkbox(
                value: isFilterApplied == true
                    ? filterTask[index].status == 'C'
                        ? true
                        : false
                    : tasks[index].status == 'C'
                        ? true
                        : false,
                onChanged: (value) {
                  setState(() {
                    isFilterApplied == true
                        ? filterTask[index].status = value == true ? 'C' : 'P'
                        : tasks[index].status = value == true ? 'C' : 'P';
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: InkWell(
                    onTap: () {
                      //
                      nameController.text = isFilterApplied == true
                          ? filterTask[index].name
                          : tasks[index].name;

                      setState(() {
                        selectedIndex = index;
                      });
                      //
                    },
                    child: const Icon(Icons.edit)),
              ),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      isFilterApplied == true
                          ? filterTask.removeAt(index)
                          : tasks.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
