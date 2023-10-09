// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:finance/colory.dart';
import 'package:finance/model/transaction.model.dart';
import 'package:finance/utils.dart';

typedef SlidableActionCallback = void Function(BuildContext context);

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final SlidableActionCallback onEdit;
  final SlidableActionCallback onDelete;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: onEdit,
          backgroundColor: Colory.greendark,
          foregroundColor: Colors.white,
          icon: Icons.edit,
        ),
        SlidableAction(
          onPressed: onDelete,
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
        ),
      ]),
      child: _item(transaction),
    );
  }

  Widget _item(Transaction transaction) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 0.1),
      ),
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${transaction.category}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Visibility(
                  visible: transaction.description != '',
                  child: Text(
                    transaction.description!,
                    style: const TextStyle(fontSize: 12),
                  ))
            ],
          ),
          Text(
            Utils.getCurrencyFormat(transaction.amount!),
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
