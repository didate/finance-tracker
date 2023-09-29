import 'package:finance/lite/transaction.impl.dart';
import 'package:finance/model/solde.model.dart';
import 'package:finance/model/transaction.model.dart';
import 'package:finance/notifier.dart';
import 'package:finance/utils.dart';
import 'package:flutter/material.dart';

import '../colory.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final transactionService = TransactionImpl();
  late List<Transaction> _transactions;
  late ScrollController _scrollController;

  late List<Solde> soldes;

  late Solde depense;
  late Solde entree;

  late int _pageNumber;
  final int _numberOfPostsPerRequest = 50;
  late bool _error;
  late bool _isLastPage;
  late bool _loading;
  late bool _preventCall;

  @override
  void initState() {
    super.initState();
    entree = Solde(nature: '', amount: 0);
    depense = Solde(nature: '', amount: 0);

    _pageNumber = 1;
    _transactions = [];
    _loading = true;
    _error = false;
    _isLastPage = false;
    _preventCall = false;
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      // nextPageTrigger will have a value equivalent to 80% of the list size.
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      // _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
      if (_scrollController.position.pixels > nextPageTrigger) {
        if (!_preventCall) {
          _loading = true;
          getTransactions();
          setState(() {
            _preventCall = true;
          });
        }
      }
    });

    Notifier.valueNotifier.addListener(
      () {
        print("notifier");
        getTransactions();
      },
    );

    getSolde();

    getTransactions();
  }

  void getSolde() async {
    try {
      soldes = await transactionService.getSolde();
      setState(() {
        depense = soldes.firstWhere((element) => element.nature == 'DEPENSE');
        entree = soldes.firstWhere((element) => element.nature == 'ENTREE');
      });
    } catch (e) {
      print(e);
    }
  }

  void getTransactions() async {
    try {
      print('getTran');
      final operations = await transactionService.findAll(_pageNumber);
      setState(() {
        _isLastPage = _transactions.length < _numberOfPostsPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _transactions.addAll(operations);
        // Notifier.add(operations);
        _preventCall = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: Notifier.valueNotifier,
              builder: (context, values, child) {
                return Column(
                  children: [
                    SizedBox(height: 300, child: _head()),
                    Expanded(child: buildListTransaction()),
                    if (_preventCall) const CircularProgressIndicator()
                  ],
                );
              })),
    );
  }

  Widget buildListTransaction() {
    if (_transactions.isEmpty) {
      if (_loading) {
        return const Center(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(child: errorDialog(size: 20));
      }
    }
    return ListView.builder(
        controller: _scrollController,
        itemCount: _transactions.length, //+ (_isLastPage ? 0 : 1),
        itemBuilder: (context, index) {
          final transaction = _transactions[index];
          return get(transaction);
        });
  }

  ListTile get(Transaction transaction) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: transaction.nature == 'ENTREE'
            ? const Icon(
                Icons.call_received,
                color: Colors.green,
                size: 20,
              )
            : const Icon(
                Icons.call_made,
                color: Colors.red,
                size: 20,
              ),
      ),
      title: Text(
        transaction.category!,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(Utils.getDate(transaction.createdAt!)),
      trailing: Text(
        '${Utils.getCurrencyFormat(transaction.amount)}',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: transaction.nature == 'DEPENSE' ? Colors.red : Colors.green),
      ),
    );
  }

  Widget _head() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                  color: Colory.greenLight,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: const Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 35, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Good afternoon',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 224, 223, 223))),
                            Text('Diallo Mamadou',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 120,
          child: Container(
            height: 170,
            width: 320,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(47, 125, 121, 0.3),
                    offset: Offset(0, 6),
                    blurRadius: 12,
                    spreadRadius: 6,
                  )
                ],
                color: Colory.greendark,
                borderRadius: BorderRadius.circular(15)),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Balance',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white)),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                        '${Utils.getCurrencyFormat(entree.amount - depense.amount)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Color.fromARGB(255, 85, 145, 141),
                          child: Icon(
                            Icons.call_received,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text('Income',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color.fromARGB(255, 216, 216, 216))),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Color.fromARGB(255, 85, 145, 141),
                          child: Icon(
                            Icons.call_made,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text('Expense',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color.fromARGB(255, 216, 216, 216))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${Utils.getCurrencyFormat(entree.amount)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white)),
                    Text('${Utils.getCurrencyFormat(depense.amount)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white)),
                  ],
                ),
              )
            ]),
          ),
        )
      ],
    );
  }

  Widget errorDialog({required double size}) {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred when fetching the posts.',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _loading = true;
                  _error = false;
                  getSolde();
                  getTransactions();
                });
              },
              child: const Text(
                "Retry",
                style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
              )),
        ],
      ),
    );
  }
}
