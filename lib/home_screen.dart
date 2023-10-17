import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  State<HomeScreen> createState() => _MyAppState();
}

class _MyAppState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Whats App"),
          centerTitle: false,
          bottom: TabBar(tabs: [
            Tab(
              child: Icon(Icons.camera_alt),
            ),
            Tab(
              child: Text("Chat"),
            ),
            Tab(
              child: Text("Status"),
            ),
            Tab(
              child: Text("Call"),
            ),
          ]),
          actions: [
            Icon(Icons.search),
            SizedBox(
              width: 10,
            ),
            PopupMenuButton(
                icon: Icon(Icons.more_vert_outlined),
                itemBuilder: ((context) => [
                      PopupMenuItem(
                        child: Text("New Group"),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text("Settings"),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text("Logout"),
                        value: 3,
                      ),
                    ])),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Text("Camera"),
            ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://media.licdn.com/dms/image/C4D03AQHfZkyxrWabkA/profile-displayphoto-shrink_800_800/0/1640246842450?e=1684368000&v=beta&t=VwxjOfJgPFffF-c4gPtHgmiZlU73U5hhLnV93Q2YxSs"),
                  ),
                  title: Text("Mahmood Rasheed"),
                  subtitle: Text("Last seen at 12:00 AM"),
                  trailing: Text("4:00 PM"),
                );
              },
              itemCount: 100,
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.teal,
                          width: 3,
                        )),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://media.licdn.com/dms/image/C4D03AQHfZkyxrWabkA/profile-displayphoto-shrink_800_800/0/1640246842450?e=1684368000&v=beta&t=VwxjOfJgPFffF-c4gPtHgmiZlU73U5hhLnV93Q2YxSs"),
                    ),
                  ),
                  title: Text("Mahmood Rasheed"),
                  subtitle: Text("20m ago"),
                );
              },
              itemCount: 100,
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://media.licdn.com/dms/image/C4D03AQHfZkyxrWabkA/profile-displayphoto-shrink_800_800/0/1640246842450?e=1684368000&v=beta&t=VwxjOfJgPFffF-c4gPtHgmiZlU73U5hhLnV93Q2YxSs"),
                  ),
                  title: Text("Mahmood Rasheed"),
                  subtitle: Text(index % 2 == 0
                      ? "You missed audio call"
                      : "You missed video call"),
                  trailing:
                      Icon(index % 2 == 0 ? Icons.phone : Icons.video_call),
                );
              },
              itemCount: 100,
            ),
          ],
        ),
      ),
    );
  }
}
