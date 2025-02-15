import 'package:flutter/material.dart';
import 'package:qma/features/dashboard/ui/widgets/summary_card.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: const Row(
          children: [
            SummaryCard(
              icon: Icons.school,
              title: "শীক্ষার্থী",
              value: "১০০০",
            ),
            SizedBox(width: 16),
            SummaryCard(
              icon: Icons.person,
              title: "শিক্ষক",
              value: "১০০০",
            ),
            SizedBox(width: 16),
            SummaryCard(
              icon: Icons.family_restroom,
              title: "পিতা/মাতা",
              value: "১০০০",
            ),
            SizedBox(width: 16),
            SummaryCard(
              icon: Icons.work,
              title: "কর্মচারী",
              value: "১০০০",
            ),
            SizedBox(width: 16),
            SummaryCard(
              icon: Icons.class_,
              title: "ক্লাস",
              value: "১০০০",
            ),
            SizedBox(width: 16),
            SummaryCard(
              icon: Icons.attach_money,
              title: "আজকের আয়",
              value: "১০০০",
            ),
            SizedBox(width: 16),
            SummaryCard(
              icon: Icons.money_off,
              title: "আজকের ব্যয়",
              value: "১০০০",
            ),
            SizedBox(width: 16),
            SummaryCard(
              icon: Icons.event,
              title: "আজকের ইভেন্ট",
              value: "১০০০",
            ),
            SizedBox(width: 16),
            SummaryCard(
              icon: Icons.event,
              title: "আগামী ইভেন্ট",
              value: "১০০০",
            ),
          ],
        ),
      ),
    );
  }
}
