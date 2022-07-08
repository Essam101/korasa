import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop/screens/customer/state_management/customre_state.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<CustomerState>(context, listen: true).isLoading
        ? Container(
            height: 800,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: Provider.of<CustomerState>(context, listen: true).isLoading,
              child: ListView.builder(
                itemBuilder: (_, __) => Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(height: 100, width: double.infinity),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 50, width: 80),
                          Container(height: 50, width: 80),
                          SizedBox(width: 40),
                          Container(height: 50, width: 80)
                        ],
                      )
                    ],
                  ),
                ),
                itemCount: 6,
              ),
            ),
          )
        : Container();
  }
}
