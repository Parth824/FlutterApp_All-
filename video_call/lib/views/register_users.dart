import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/views/widgets/register_uder_item.dart';

class RegisterUsersScreen extends StatefulWidget {
  const RegisterUsersScreen({Key? key}) : super(key: key);

  @override
  State<RegisterUsersScreen> createState() => _RegisterUsersScreenState();
}

class _RegisterUsersScreenState extends State<RegisterUsersScreen> {
  List<String> chatList = [
    "Kurt Bates ",
    "Patricia Sanders ",
    "Alex",
    "Kimberly Called you...",
    "Kathy Messaged you",
    "David  Messaged you",
    "Stephanie Calling you...",
    "Alex Messaged you",
    "Kimberly Called you...",
    "Kathy Messaged you",
    "David  Messaged you"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset("assets/images/background.png"),
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Constants.registeredUsers,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: 100,
              left: 0,
              child: Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFFFFDFB),
                          Color(0xFFF3F4FF),
                        ],
                      )),
                  child: Stack(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: chatList.length,
                          itemBuilder: (context, index) {
                            return RegisterUserItem(
                              title: chatList[index],
                            );
                          }),
                      Positioned(
                        bottom: 0,
                        child: InkWell(
                          onTap: null,
                          child: Image.asset(
                            "assets/images/bottom.png",
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
