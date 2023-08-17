import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final String wday;
  final double amt;
  final double amtPercentage;
  Bar(this.wday, this.amt, this.amtPercentage);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (ctx, constraints) => Column(children: [
              Container(
                  height: constraints.maxHeight*0.15,
                  child: FittedBox(child: Text("₹${amt.toStringAsFixed(0)}"))),
              SizedBox(
                height: constraints.maxHeight*0.05,
              ),
              Container(
                  height: constraints.maxHeight*0.60,
                  width: 10,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromRGBO(237, 232, 232, 1),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: amtPercentage,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: constraints.maxHeight*0.05,
              ),
              Container(height: constraints.maxHeight*0.15,child: FittedBox(child: Text(wday))),
            ]));
  }
}
