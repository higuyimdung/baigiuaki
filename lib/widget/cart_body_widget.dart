import 'dart:html';

import 'package:dunghaha/modal/item.dart';
import 'package:flutter/material.dart';

class Cartbody extends StatefulWidget {
  Cartbody({super.key, required this.item, required this.handleDelete});
  var item;
  final Function handleDelete;

  @override
  State<Cartbody> createState() => _CartbodyState();
}

class _CartbodyState extends State<Cartbody> {
  Color checkngay(DataItems chon) {
    if (DateTime.now().isAfter(chon.deadline))
      return Colors.red;
    else
      return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.green),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            widget.item.name + '${widget.item.deadline}',
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 88, 50, 50),
                fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              widget.handleDelete(widget.item.id);
            },
            child: Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 20,
            ),
          )
        ]),
      ),
    );
  }
}
