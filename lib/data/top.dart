import 'package:finance/data/money.dart';

List<Money> geter_top() {
  Money snap_food = Money();
  snap_food.time = 'jan 30,2022';
  snap_food.image = 'food.png';
  snap_food.buy = true;
  snap_food.fee = '- \$ 100';
  snap_food.name = 'macdonald';
  Money snap = Money();
  snap.image = 'transfer.png';
  snap.time = 'today';
  snap.buy = true;
  snap.name = 'Transfer';
  snap.fee = '- \$ 60';

  return [snap_food, snap];
}
