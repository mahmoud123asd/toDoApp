import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/views/widgets/build_statistics_items.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Report',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 24),
              GetBuilder<TaskController>(
                builder: (controller) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BuildStatisticsItems(
                              color: Colors.green,
                              value: '${controller.totalUncompletedTasks}',
                              label: 'Live Tasks'),
                          BuildStatisticsItems(
                              color: Colors.orange,
                              value: '${controller.totalCompletedTasks}',
                              label: 'Completed'),
                          BuildStatisticsItems(
                              color: Colors.blue,
                              value: '${controller.totalCreatedTasks}',
                              label: 'Created'),
                        ],
                      ),
                      const SizedBox(height: 48),
                      Center(
                        child: SizedBox(
                          width: 230,
                          height: 230,
                          child: CircularStepProgressIndicator(
                            totalSteps: controller.totalCreatedTasks == 0
                                ? 1
                                : controller.totalCreatedTasks,
                            currentStep: controller.totalCompletedTasks,
                            stepSize: 20,
                            selectedColor: purple,
                            unselectedColor: Colors.grey[200],
                            padding: 0,
                            width: 150,
                            height: 150,
                            selectedStepSize: 22,
                            roundedCap: (_, __) => true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${controller.efficiency}%',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.0,
                                ),
                                Text(
                                  'Efficiency',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
