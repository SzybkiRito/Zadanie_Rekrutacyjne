import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zadanie_rekrutacyjne/widgets/result_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int findOutlier(List<int> table) {
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
                  hintText: '2, 4, 0, 100, 4, 11, 2602, 36',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
              error
                  ? SizedBox(
                      height: 40,
                      child: Text(
                        AppLocalizations.of(context)!.errorDigitSequence,
                        style: const TextStyle(fontSize: 20, color: Colors.red),
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
                    var secondPattern = RegExp(r'^-?\d+(,-?\d+)*$');

                    if (pattern.hasMatch(numbersController.text) || secondPattern.hasMatch(numbersController.text)) {
                      List<String> userNumbers = pattern.hasMatch(numbersController.text)
                          ? numbersController.text.split(', ')
                          : numbersController.text.split(',');
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
                  child: Text(AppLocalizations.of(context)!.search),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
