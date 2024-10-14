import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:menumemory/models/visit.dart';

class VisitCard extends StatefulWidget {
  Visit visit;
  VisitCard({super.key, required this.visit});

  @override
  State<VisitCard> createState() => _VisitCardState();
}

class _VisitCardState extends State<VisitCard> {

  bool isMinimized = false;
  bool seeAll = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: widget.visit==null ? CircularProgressIndicator() : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Text(widget.visit!.restaurant_info.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    SizedBox(width: 10,),
                    Text(DateFormat("dd MMM yyyy  K:ma").format(widget.visit.datetime),
                      )
                  ],
                ),
                IconButton(onPressed: () {
                  setState(() {
                    isMinimized = !isMinimized;
                  });
                }, icon: Icon(isMinimized ? Icons.arrow_drop_up_sharp : Icons.arrow_drop_down_sharp))
              ],
            ),
            if (!isMinimized)
            ...widget.visit!.order.sublist(0, seeAll ? widget.visit!.order.length : 2).map((order) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(order.dish.name, style: TextStyle(fontSize: 20),),
                    SizedBox(width: 10),
                    Text("${order.rating}/5")
                  ],
                ),
                Text('"${order.review_text!}"', style: TextStyle(fontSize: 16),),
                SizedBox(height: 5),
                Divider(thickness: 1,color: Colors.grey)
              ],
            )),
            if (!isMinimized)
            Center(child: TextButton(onPressed: (){
              setState(() {
                seeAll = !seeAll;
              });
            }, child: Text(seeAll ? "See less" : "See more")))
          ],
        ),
      ),
    );
  }
}
