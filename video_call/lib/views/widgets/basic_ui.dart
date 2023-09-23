import 'package:flutter/material.dart';

class BasicUiWidget extends StatelessWidget {
  final Widget widget;
  final bool? showBackBtn;
  final Function()? onTap;

  const BasicUiWidget(
      {Key? key, required this.widget, this.showBackBtn = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset("assets/images/background.png"),
            showBackBtn!
                ? Positioned(
                    top: 50,
                    left: 12,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      ),
                    ))
                : const SizedBox(),
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
                      Positioned(
                        bottom: 0,
                        child: InkWell(
                          onTap: onTap,
                          child: Image.asset(
                            "assets/images/bottom.png",
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      Container(child: widget),
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
