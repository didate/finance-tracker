import 'package:finance/config.dart';
import 'package:finance/lite/category.impl.dart';
import 'package:finance/lite/transaction.impl.dart';
import 'package:finance/model/category.model.dart';
import 'package:finance/model/transaction.model.dart';
import 'package:finance/notifier.dart';
import 'package:finance/service/transaction.service.dart';
import 'package:flutter/material.dart';

import '../colory.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController motifCtrl = TextEditingController();
  FocusNode ex = FocusNode();

  final TextEditingController amountCtrl = TextEditingController();
  FocusNode amount = FocusNode();

  DateTime date = DateTime.now();
  Category? selectedCategory;
  String? selectedNature;

  final List<String> nature = [
    'ENTREE',
    'DEPENSE',
  ];

  bool _saving = false;

  List<Category> categories = [];

  TransactionService transactionService = TransactionImpl();
  late Transaction transaction;

  @override
  void initState() {
    super.initState();
    _loadMetaData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final categoryService = CategoryImpl();

  Future<List<Category>> getCategories() async {
    return await categoryService.findAll();
  }

  _loadMetaData() async {
    categories = await getCategories();

    transaction = ModalRoute.of(context)!.settings.arguments as Transaction;
    print(transaction);
    setState(() {
      if (transaction != null) {
        amountCtrl.text = '${transaction.amount}';
        motifCtrl.text = '${transaction.description}';
        selectedNature = transaction.nature;
        if (categories.isNotEmpty) {
          selectedCategory = categories
              .where((element) => element.id == transaction.categoryId)
              .first;
        }
      }
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
          natureField(),
          const SizedBox(
            height: 30,
          ),
          selectedNature == 'DEPENSE'
              ? Column(
                  children: [
                    categoryField(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : Container(),
          amountField(),
          const SizedBox(
            height: 30,
          ),
          motifField(),
          const SizedBox(
            height: 30,
          ),
          /*  dateTime(),
          const Spacer(), */
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
      onTap: () async {
        setState(() {
          _saving = true;
        });
        var t = Transaction(
            amount: int.parse(amountCtrl.text),
            categoryId: selectedNature == 'DEPENSE'
                ? selectedCategory?.id
                : Config.incomeCategoryId,
            nature: selectedNature!,
            description: motifCtrl.text,
            version: 1);
        if (transaction.id == null) {
          t = await transactionService.save(t);
        } else {
          t.id = transaction.id;
          t.version = transaction.version++;
          t = await transactionService.update(t);
        }

        setState(() {
          _saving = false;
        });

        Notifier.increment();
        Navigator.of(context).pop(t);
      },
      child: _saving
          ? const CircularProgressIndicator()
          : Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colory.greenLight),
              width: 120,
              height: 50,
              child: const Text(
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
        border: Border.all(width: 2, color: const Color(0xffC5C5C5)),
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
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
    );
  }

  Padding natureField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: const Color(0xffC5C5C5))),
        child: DropdownButton<String>(
          value: selectedNature,
          items: nature
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Text(
                          '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}',
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ))
              .toList(),
          selectedItemBuilder: (context) => nature
              .map((e) => Row(
                    children: [
                      Text(
                        '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}',
                      )
                    ],
                  ))
              .toList(),
          hint: const Text(
            'Name',
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {
            setState(() {
              selectedNature = value;
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Amount',
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xffC5C5C5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Colory.greenLight))),
      ),
    );
  }

  Padding motifField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        focusNode: ex,
        controller: motifCtrl,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Reason',
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Color(0xffC5C5C5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(width: 2, color: Colory.greenLight))),
      ),
    );
  }

  Padding categoryField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: const Color(0xffC5C5C5))),
        child: DropdownButton<Category>(
          value: selectedCategory,
          items: categories
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.libelle,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ))
              .toList(),
          hint: const Text(
            'Category',
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
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
          decoration: const BoxDecoration(
              color: Colory.greenLight,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Column(children: [
            const SizedBox(
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
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Adding',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const Icon(
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
