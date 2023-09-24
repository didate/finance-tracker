import 'package:finance/data/top.dart';
import 'package:finance/data/utility.dart';
import 'package:finance/model/add.dart';
import 'package:finance/widgets/chart.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List periodType = ['Day', 'Week', 'Month', 'Year'];
  final List<dynamic> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];
  List f = [today(), week(), month(), year()];
  List<AddData> a = [];

  int indexColor = 0;
  ValueNotifier kj = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
        builder: (context, dynamic value, child) {
          a = f[value];
          return custom();
        },
        valueListenable: kj,
      )),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Statistics',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                        4,
                        (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  indexColor = index;
                                  kj.value = index;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: indexColor == index
                                        ? const Color.fromARGB(
                                            255, 47, 125, 121)
                                        : Colors.white),
                                alignment: Alignment.center,
                                child: Text(
                                  periodType[index],
                                  style: TextStyle(
                                      color: indexColor == index
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 47, 125, 121),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Expense',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_downward_sharp,
                              color: Colors.grey,
                            )
                          ]),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Chart(index: indexColor),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Spending',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.swap_vert,
                      size: 25,
                      color: Colors.grey,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'images/${a[index].name}.png',
                height: 40,
              ),
            ),
            title: Text(
              a[index].name,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${day[a[index].datetime.weekday - 1]} ${a[index].datetime.month}/${a[index].datetime.day}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: Text(
              '\$ ${a[index].amount}',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: a[index].IN == 'Income' ? Colors.red : Colors.green),
            ),
          );
        }, childCount: a.length))
      ],
    );
  }
}
