import 'package:flutter/material.dart';
import 'package:me312/header.dart';
import 'package:me312/colors.dart' as color;
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'main.dart';

class Pair {
  final double cash;
  final double ratio;

  Pair(this.cash, this.ratio);
}

class Final extends StatefulWidget {
  final Map data;
  const Final({super.key, required this.data});

  @override
  State<Final> createState() => _FinalState();
}

class _FinalState extends State<Final> {

  late List<Pair> data;

  double calculatePercentage(double r1, double r2, double r3) {
    double percent = (r3 - r2) / (r1 - r2);
    if (percent < 0) {
      return 0;
    } else if (percent > 1) {
      return 1;
    } else {
      return percent;
    }
  }

  List<Pair> calculateRatios(double d1, double e1, double d2, double e2) {
    double r1 = (d1 + d2 + e2) / e1;
    double r2 = (d1 + d2) / (e1 + e2);
    return [Pair(0, r1), Pair(calculatePercentage(r1, r2, widget.data['d/e']) * 100, widget.data['d/e']), Pair(100, r2)];
  }

  @override
  void initState() {
    super.initState();
    data = calculateRatios(widget.data['acquirer_debt'], widget.data['acquirer_equity'], widget.data['current_debt'], widget.data['equity']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.AppColor.formBackground,
        body: SafeArea(
            child: SingleChildScrollView(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                    child: Column(
                        children: [
                          const Header(),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Post Acquisition Leverage Ratios based on Deal Structure",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: color.AppColor.finalText,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    RotatedBox(
                                      quarterTurns: 3,
                                      child: Text(
                                        "Leverage Ratio",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: color.AppColor.finalText,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width - 50,
                                      child: SfSparkLineChart.custom(
                                        //Enable the trackball
                                        trackball: const SparkChartTrackball(
                                            activationMode: SparkChartActivationMode.tap),
                                        //Enable marker
                                        marker: const SparkChartMarker(
                                            displayMode: SparkChartMarkerDisplayMode.all),
                                        //Enable data label
                                        labelDisplayMode: SparkChartLabelDisplayMode.all,
                                        xValueMapper: (int index) => data[index].cash,
                                        yValueMapper: (int index) => data[index].ratio,
                                        dataCount: 3,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Cash Based Acquisition (%)",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: color.AppColor.finalText,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 40),
                                  child: Center(
                                    child: ElevatedButton(
                                      onPressed: (){
                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) => const MyApp()),
                                                (Route route) => false
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(140, 39),
                                        backgroundColor: color.AppColor.workerLoginButton,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      ),
                                      child: const Text(
                                        "End Preview",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 13,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}