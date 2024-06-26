import 'package:flutter/material.dart';
import 'package:organiza_app/custom_widgets/task_type_card.dart';
import 'package:organiza_app/custom_widgets/task_card.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndexNavbar = 0;

  List<Widget> listTaskCard = [
    const TaskCard(
      title: "Varrer Sala",
      subtitle: "15 Horas",
      countTasks: 0,
    ),
    const TaskCard(
      title: "Lavar Louça",
      subtitle: "13 Horas",
      countTasks: 0,
    ),
    const TaskCard(
      title: "Comer Salada",
      subtitle: "18 Horas",
      countTasks: 0,
    ),
    const TaskCard(
      title: "Lavar Louça",
      subtitle: "19 Horas",
      countTasks: 0,
    ),
  ]; //Temporary testing list, will come from the DB in the future.

  @override
  void initState() {
    super.initState();

    listTaskCard = addSizedBoxToList(listTaskCard, 10.0, 0.0);
  }

  List<Widget> addSizedBoxToList(
      List<Widget> list, double height, double width) {
    List<Widget> newList = [];

    for (var widget in list) {
      newList.add(widget);
      newList.add(SizedBox(
        width: width,
        height: height,
      ));
    }

    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleHome(),
        actions: [_actionsHome()],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  taskTypeCards(),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Recent Tasks",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: listTaskCard,
                  )
                ],
              ),
            ),
          ]),
    );
  }

  Column taskTypeCards() {
    return const Column(
      children: [
        Row(
          children: [
            TaskTypeCard(
              icon: Icons.refresh,
              title: "On going",
              color: Colors.blue,
              countTasks: 0,
            ),
            SizedBox(
              width: 20,
            ),
            TaskTypeCard(
              icon: Icons.av_timer,
              title: "In Process",
              color: Colors.orange,
              countTasks: 0,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            TaskTypeCard(
              icon: Icons.checklist,
              title: "Completed",
              color: Colors.green,
              countTasks: 0,
            ),
            SizedBox(
              width: 20,
            ),
            TaskTypeCard(
              icon: Icons.error_outline,
              title: "Canceled",
              color: Colors.red,
              countTasks: 0,
            ),
          ],
        )
      ],
    );
  }

  Container _titleHome() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
      child: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(right: 240.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black)),
                child: const Center(child: Text("Foto")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, ${widget.username}",
                      style: const TextStyle(fontSize: 22),
                    ),
                    const Text(
                      "Your daily adventure starts here!",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Padding _actionsHome() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        child: const Text("Actions"),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.checklist,
            size: 30,
          ),
          label: 'Check',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          label: 'add',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 30,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndexNavbar,
      selectedItemColor: Colors.blue.withOpacity(0.7),
      onTap: (int index) {
        setState(() {
          _selectedIndexNavbar = index;
        });
      },
    );
  }
}
