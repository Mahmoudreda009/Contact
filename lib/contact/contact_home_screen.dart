import 'package:flutter/material.dart';
import 'package:contact_app/contact/widgets/add_user_bottom_sheet.dart';
import 'package:contact_app/contact/widgets/user_model.dart';
import 'package:lottie/lottie.dart';

class ContactHomeScreen extends StatefulWidget {
  @override
  State<ContactHomeScreen> createState() => _ContactHomeScreenState();
}

class _ContactHomeScreenState extends State<ContactHomeScreen> {
  List<User> users = [];

  void addUser(User user) {
    setState(() {
      users.add(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF29384D),
      floatingActionButton: Stack(
        children: [
          if (users.length > 1)
            Positioned(
              bottom: 80,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    users.removeLast();
                  });
                },
                backgroundColor: Colors.red,
                child: const Icon(Icons.delete, size: 30),
              ),
            ),

          if (users.length < 6)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: const Color(0xFF29384D),
                    isScrollControlled: true,
                    builder: (_) => AddUserBottomSheet(onAddUser: addUser),
                  );
                },
                backgroundColor: const Color(0xFFFFF1D4),
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Color(0xFF29384D),
                ),
              ),
            ),
        ],
      ),

      appBar: AppBar(
        leading: Image.asset("assets/Group 6.png"),
        leadingWidth: 200,
        toolbarHeight: 50,
        backgroundColor: const Color(0xFF29384D),
        elevation: 0.0,
      ),

      body: users.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/empty_list.json', height: 400),
                  const Text(
                    'There is No Contacts Added Here',
                    style: TextStyle(
                      color: Color(0xFFFFF1D4),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                mainAxisExtent: 240,
              ),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFFFF1D4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                            child: Image.file(
                              user.image!,
                              width: double.infinity,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFFF1D4),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.all(4),
                              child: Text(
                                user.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF29384D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 18,
                                    color: Color(0xFF29384D),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      user.email,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xFF29384D),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.wifi_calling_3_rounded,
                                    size: 18,
                                    color: Color(0xFF29384D),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      user.phone,
                                      style: const TextStyle(
                                        color: Color(0xFF29384D),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    users.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 16,
                                  color: Color(0xFFFFF1D4),
                                ),
                                label: const Text(
                                  "Delete",
                                  style: TextStyle(color: Color(0xFFFFF1D4)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  minimumSize: const Size(double.infinity, 35),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
