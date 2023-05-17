import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Flutter"),
        centerTitle: false,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
              onPressed: () => debugPrint("Hello Scaffold"),
              icon: const Icon(
                Icons.sms,
                color: Colors.white,
                size: 32,
              )),
        ],
      ),
      body: ListView(
        children: [
          Image.asset('assets/images/etihad.jpg'),
          // const SizedBox(
          //   height: 20,
          // ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Etihad Stadium",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Manchester, England",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
                const Icon(
                  Icons.star,
                  size: 30,
                  color: Colors.orange,
                ),
                const Text(
                  "5.0",
                  style: TextStyle(fontSize: 18),
                ),
              ],
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // // use whichever suits your need
              // children: const <Widget>[
              //   Text(
              //     "Emirates Stadium",
              //     style: TextStyle(fontSize: 20),
              //   ),
              //   Icon(
              //     Icons.star,
              //     size: 30,
              //     color: Colors.orange,
              //   ),
              // ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.phone,
                          size: 30,
                          color: Colors.cyan,
                        ),
                        Text(
                          "Call",
                          style: TextStyle(fontSize: 16, color: Colors.cyan),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          CupertinoIcons.location_fill,
                          size: 30,
                          color: Colors.cyan,
                        ),
                        Text(
                          "Route",
                          style: TextStyle(fontSize: 16, color: Colors.cyan),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          CupertinoIcons.share_up,
                          size: 30,
                          color: Colors.cyan,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(fontSize: 16, color: Colors.cyan),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "The City of Manchester Stadium in Manchester, England, also known as the Etihad Stadium for sponsorship reasons, is the home of Premier League club Manchester City F.C., with a domestic football capacity of 53,400, making it the 6th-largest football stadium in England and tenth-largest in the United Kingdom.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
