import 'package:flutter/material.dart';

class Notifier {
  static ValueNotifier<int> valueNotifier = ValueNotifier(0);

  /* static void insert(Transaction t) {
    valueNotifier.value.insert(0, t);
  }

  static void add(List<Transaction> ts) {
    valueNotifier.value.addAll(ts);
  } */

  static void increment() {
    valueNotifier.value++;
  }
}
