import 'money.dart';

List<Money> geter() {
  Money upwork = Money();
  upwork.name = 'upwork';
  upwork.fee = '650';
  upwork.time = 'today';
  upwork.image = 'transportation.png';
  upwork.buy = false;

  Money starbucks = Money();
  starbucks.buy = true;
  starbucks.fee = '15';
  starbucks.image = 'food.png';
  starbucks.name = 'starbucks';
  starbucks.time = 'today';
  Money trasfer = Money();
  trasfer.buy = true;
  trasfer.fee = '100';
  trasfer.image = 'transfer.png';
  trasfer.name = 'trasfer for sam';
  trasfer.time = 'jan 30,2022';
  Money education = Money();
  education.buy = true;
  education.fee = '100';
  education.image = 'education.png';
  education.name = 'education for sam';
  education.time = 'jan 31,2022';
  return [upwork, starbucks, education, trasfer, upwork, starbucks, trasfer];
}
