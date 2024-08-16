import 'package:all_sensors/all_sensors.dart';
import 'package:flutter/material.dart';

class SensroChecker extends StatefulWidget {
  const SensroChecker({Key? key}) : super(key: key);

  @override
  _SensroCheckerState createState() => _SensroCheckerState();
}

class _SensroCheckerState extends State<SensroChecker> {
  final List<double> _accelerometerValues = [0, 0, 0];
  final double _shakeThreshold = 15.0;

  bool _isShakeDetected(AccelerometerEvent event) {
    double magnitude =
        event.x * event.x + event.y * event.y + event.z * event.z;
    magnitude = magnitude / (9.81 * 9.81);
    return magnitude > _shakeThreshold;
  }

  void _showReportIssueModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Report a Bug or Issue',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Describe the issue',
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Handle the submit action
                        Navigator.pop(context);
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents!.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues[0] = event.x;
        _accelerometerValues[1] = event.y;
        _accelerometerValues[2] = event.z;
      });

      if (_isShakeDetected(event)) {
        _showReportIssueModal();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.white,
    ));
  }
}
