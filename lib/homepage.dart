import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guessthenumber/provider/numberProvider.dart';
import 'package:provider/provider.dart';

class Myhomepage extends StatelessWidget {
  const Myhomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var numberProvider = Provider.of<NumberProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        child: const Icon(CupertinoIcons.refresh),
        onPressed: () {
          numberProvider.refresh();
          numberProvider.showRandoms();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Guess the number!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        numberProvider.removed(index);
                        if (numberProvider.seen[index] == false) {
                          showDialog(
                              context: context,
                              builder: (_) => CupertinoAlertDialog(
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              numberProvider.refresh();
                                              numberProvider.showRandoms();
                                            },
                                            child: const Text('try again')),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    CupertinoColors.systemGrey),
                                            onPressed: () {
                                              exit(0);
                                            },
                                            child: const Text('Exit the game'))
                                      ],
                                    ),
                                  ));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 80,
                        child: Text(
                          numberProvider.randomNumbers[index].toString(),
                          style: TextStyle(
                              color: numberProvider.show
                                  ? CupertinoColors.white
                                  : CupertinoColors.darkBackgroundGray),
                        ),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 20,
                                  spreadRadius: 3,
                                  color: CupertinoColors.black)
                            ],
                            color: numberProvider.seen[index]
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.darkBackgroundGray,
                            border: Border.all(
                                color: numberProvider.seen[index]
                                    ? CupertinoColors.white
                                    : CupertinoColors.activeBlue,
                                width: 3)),
                      ),
                    );
                  },
                  itemCount: 9,
                ),
              ),
              Center(
                child: numberProvider.won
                    ? const Text(
                        'You won',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )
                    : const Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future lost() async {
  //   return
  // }
}
