import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:usanacaixaapp/data/models/order_details_model.dart';
import 'package:usanacaixaapp/data/utils/format.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key, required this.statusHistoryList});

  final List<StatusHistory> statusHistoryList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: statusHistoryList.length,
      itemBuilder: (context, index) {
        final statusHistory = statusHistoryList[index];
        return TimelineTile(
          alignment: TimelineAlign.center,
          isFirst: index == 0,
          isLast: index == statusHistoryList.length - 1,
          indicatorStyle: IndicatorStyle(
            width: 40,
            height: 40,
            indicator: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                '${index + 1}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          beforeLineStyle: LineStyle(
            color: Colors.blue,
            thickness: 2,
          ),
          afterLineStyle: LineStyle(
            color: Colors.blue,
            thickness: 2,
          ),
          startChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formatDateTime(statusHistory.createdAt),
              style: TextStyle(fontSize: 12),
            ),
          ),
          endChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              statusHistory.status,
              style: TextStyle(fontSize: 14),
            ),
          ),
        );
      },
    );
  }
}
