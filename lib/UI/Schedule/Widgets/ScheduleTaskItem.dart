import 'package:flutter/material.dart';

class ScheduleTaskItem extends StatelessWidget {
  ScheduleTaskItem({Key? key, required this.item}) : super(key: key);
  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Color(int.parse("${item['color']}"))),
      child: Row(
        children: [
          Column(
            children: [
              const Spacer(),
              Text(
                '${item['start_time']}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '${item['title']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(15),
              ),
              child: item['isCompleted']==1?const Icon(Icons.check,color: Colors.white,):Container(),
            ),
          ),

        ],
      ),
    );
  }
}
