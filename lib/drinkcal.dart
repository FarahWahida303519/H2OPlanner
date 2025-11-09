import 'package:flutter/material.dart';

class drinkCal extends StatefulWidget {
  //use statefulwidget since the data will change
  const drinkCal({super.key});

  @override
  State<drinkCal> createState() => _drinkCal(); //create state obj
}

class _drinkCal extends State<drinkCal> {
  //control handle input user
  TextEditingController weightController = TextEditingController();

  //fix default selected values
  String temperature = 'Hot';
  String activity = 'Low';

  //variable store the output
  double waterResult = 0.0;

  //set the mesg result
  String result = 'Ideal Water Intake : 0.00 liters/day';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Drink Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 120, 164, 247),
        centerTitle: true,
      ),

      backgroundColor: Color.fromARGB(255, 226, 236, 255),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(
              20.0,
            ), //padding inside container(like its space inside box)
            margin: EdgeInsets.all(50.0), //outside container(space around box)

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(2, 4), //for position shadow
                ),
              ],
            ),

            height: 450,
            width: 500,

            child: Column(
              children: [
                // Weight Input
                SizedBox(height: 40), //space before the widget text field
                Row(
                  children: [
                    SizedBox(width: 120, child: Text('Weight : ')), //label
                    //input text field
                    SizedBox(
                      width: 180,
                      child: TextField(
                        controller: weightController,
                        keyboardType:
                            TextInputType.number, //numberic input only
                        decoration: InputDecoration(
                          hintText: 'kg', //placeholder
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixText: 'kg', // display "Kg" inside the box
                          suffixStyle: TextStyle(color: Colors.black),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ), //round input box
                          ),
                          filled: true, //fill bg box
                          fillColor: Colors.blue.shade50, // color background
                        ),
                      ),
                    ),
                  ],
                ),

                // Row with Temperature + Activity (using SizedBox for alignment)
                SizedBox(height: 45),
                Row(
                  children: [
                    // Temperature
                    const SizedBox(width: 120, child: Text('Temperature :')),//label
                    DropdownButton<String>(
                      value: temperature, //set the value
                      items: <String>['Hot', 'Cool'].map((String value) {
                        //create list to contain 2 string vlues. .map convert element into dropdownbutton
                        return DropdownMenuItem<String>(
                          value: value, //value behind dropdownbutton
                          child: Text(
                            value,
                          ), //user will see the Hot at dropdown button tempeature
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          temperature = newValue!; //update value when changes
                        });
                      },
                    ),

                    SizedBox(width: 100), // gap between temp & activity
                    // Activity
                    SizedBox(width: 80, child: Text('Activity :')),
                    DropdownButton<String>(
                      value: activity,
                      items: <String>['Low', 'High'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          activity = newValue!;
                        });
                      },
                    ),
                  ],
                ),

                // space before Buttons
                SizedBox(height: 85), //s
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // to center buttons
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: calculate, //will call calculate() when pressed
                      child: Text('Calculate'),
                    ),

                    SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: resetForm, //will call reset()when pressed
                      child: const Text('Reset'),
                    ),
                  ],
                ),

                // Result
                const SizedBox(height: 50),
                Container(
                  //container result
                  padding: const EdgeInsets.all(16), //inner padding
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      255,
                      181,
                      232,
                      255,
                    ), // light blue background
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightBlueAccent.withOpacity(0.5),
                        blurRadius: 6,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),

                  child: Text(
                    result, //show result/validationmessage
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center, // centers text inside the box
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Calculate function
  void calculate() {
    //Validation message
    if (weightController.text.isEmpty) {
      setState(() {
        result = 'Please enter your weight!';
      });

      return;
    } else if (weightController.text == '0') {
      setState(() {
        result = 'Please enter a valid weight!';
      });
      return;
    }

    double weight = double.parse(
      weightController.text,
    ); //convert strin into double
   
    waterResult = weight * 0.035;

    // Activity
    if (activity == 'Low') {
      waterResult += 0.5;
    } else {
      waterResult += 1.0;
    }

    // Temperature
    if (temperature == 'Hot') {
      waterResult += 0.50;
    }

    setState(() {
      result =
          'Ideal Water Intake : ${waterResult.toStringAsFixed(2)} liters/day';
    });
  }

  // Reset function
  void resetForm() {
    weightController.clear();
    temperature = 'Hot';
    activity = 'Low';
    waterResult = 0.0;
    result = 'Ideal Water Intake : 0.00 liters/day';
    setState(() {});
  }
}
