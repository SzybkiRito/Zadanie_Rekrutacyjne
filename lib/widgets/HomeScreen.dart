import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zadanie_rekrutacyjne/widgets/ResultScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

dynamic findOutlier(List<int> table) {
  if (table.length < 3) throw ArgumentError('Pass more numbers into array');
  bool isEven = table.where((e) => e.isEven).length > table.length / 2;
  int outlier = table.firstWhere((element) => isEven ? element.isOdd : element.isEven);

  return outlier;
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController numbersController = TextEditingController();
  bool error = false;

  @override
  void dispose() {
    numbersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: numbersController,
                decoration: const InputDecoration(
                  hintText: 'e.g. 2, 4, 0, 100, 4, 11, 2602, 36',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
              error
                  ? const SizedBox(
                      height: 40,
                      child: Text(
                        'Wpisz poprawny ciag cyfr',
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    )
                  : const SizedBox(
                      height: 20,
                    ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    var pattern = RegExp(r'^-?\d+(,\s-?\d+)*$');

                    if (pattern.hasMatch(numbersController.text)) {
                      List<String> userNumbers = numbersController.text.split(', ');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            result: findOutlier(userNumbers.map(int.parse).toList()),
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        error = true;
                      });
                    }
                  },
                  child: const Text('Wyszukaj'),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
