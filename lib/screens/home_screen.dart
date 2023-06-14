import 'package:flutter/material.dart';
import 'package:quizapp/utils/myStyle.dart';

import '../widges/home_card_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DashBoard"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("User Name",style: MyStyle.subTitleStyle(),),
                      const Text("username@mail.com")
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: HomeCardButton(
                  iconData: Icons.area_chart,
                  onTap: (){},
                  cardText: "View Result",
                ),
              ),
              const SizedBox(width: 8,),
              Expanded(
                flex: 1,
                child: HomeCardButton(
                  iconData: Icons.local_offer,
                  onTap: (){},
                  cardText: "View All Quiz",
                ),
              ),



            ],
          ),
        ],
      ),
    );
  }
}

