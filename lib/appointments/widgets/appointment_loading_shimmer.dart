import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppointmentShimmer extends StatelessWidget {
  const AppointmentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin:
                const EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(height: 22.0, width: 90.0,  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),),
                          Container(height: 20.0, width: 20.0, color: Colors.white,),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    Container(height: 25.0, width: 100.0, color: Colors.white,),
                      const SizedBox(height: 8.0),
                      Container(height: 15.0, width: 120.0, color: Colors.white,),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(height: 20.0, width: 40.0, color: Colors.white,),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(height: 12.0, width: 60.0, color: Colors.white,),
                                const SizedBox(width: 8.0,),
                                Container(height: 20.0, width: 20.0, color: Colors.white,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
