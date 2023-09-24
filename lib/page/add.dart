import 'package:finance/model/add.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final box = Hive.box<AddData>('data');
  final TextEditingController explainCtrl = TextEditingController();
  FocusNode ex = FocusNode();

  final TextEditingController amountCtrl = TextEditingController();
  FocusNode amount = FocusNode();

  DateTime date = DateTime.now();
  String? selectedItem;
  String? selectedItemi;
  final List<String> _item = [
    'food',
    'transfer',
    'transportation',
    'education',
  ];

  final List<String> _itemi = [
    'Income',
    'Expand',
  ];

  @override
  void initState() {
    super.initState();
    ex.addListener(() {
      setState(() {});
    });
    amount.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          backgroundContainer(context),
          Positioned(
            top: 120,
            child: mainContainer(),
          )
        ],
      )),
    );
  }

  Container mainContainer() {
    return Container(
      height: 550,
      width: 340,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          nameField(),
          const SizedBox(
            height: 30,
          ),
          explainField(),
          const SizedBox(
            height: 30,
          ),
          amountField(),
          const SizedBox(
            height: 30,
          ),
          how(),
          const SizedBox(
            height: 30,
          ),
          dateTime(),
          const Spacer(),
          save(),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  GestureDetector save() {
    return GestureDetector(
      onTap: () {
        var add = AddData(
            name: selectedItem!,
            explain: explainCtrl.text,
            amount: amountCtrl.text,
            IN: selectedItemi!,
            datetime: date);

        box.add(add);
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xff368983)),
        width: 120,
        height: 50,
        child: Text(
          'Save',
          style: TextStyle(
              fontFamily: 'f',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
    );
  }

  Container dateTime() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Color(0xffC5C5C5)),
      ),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          if (newDate == Null) return;
          setState(() {
            date = newDate!;
          });
        },
        child: Text(
          'Date : ${date.year}/${date.month}/${date.day}',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
    );
  }

  Padding how() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Color(0xffC5C5C5))),
        child: DropdownButton<String>(
          value: selectedItemi,
          items: _itemi
              .map((e) => DropdownMenuItem(
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (context) => _itemi
              .map((e) => Row(
                    children: [
                      Text(
                        '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}',
                      )
                    ],
                  ))
              .toList(),
          hint: Text(
            'Name',
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {
            setState(() {
              selectedItemi = value;
            });
          },
        ),
      ),
    );
  }

  Padding amountField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        keyboardType: TextInputType.number,
        focusNode: amount,
        controller: amountCtrl,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'amount',
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xffC5C5C5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xff368983)))),
      ),
    );
  }

  Padding explainField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        focusNode: ex,
        controller: explainCtrl,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'explain',
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xffC5C5C5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xff368983)))),
      ),
    );
  }

  Padding nameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Color(0xffC5C5C5))),
        child: DropdownButton<String>(
          value: selectedItem,
          items: _item
              .map((e) => DropdownMenuItem(
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            child: Image.asset('images/${e}.png'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (context) => _item
              .map((e) => Row(
                    children: [
                      Container(
                        width: 40,
                        child: Image.asset('images/${e}.png'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}',
                      )
                    ],
                  ))
              .toList(),
          hint: Text(
            'Name',
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {
            setState(() {
              selectedItem = value;
            });
          },
        ),
      ),
    );
  }

  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
              color: Color(0xff368983),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Adding',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.attach_file_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ]),
        )
      ],
    );
  }
}
