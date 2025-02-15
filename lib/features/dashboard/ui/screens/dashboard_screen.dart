import 'package:flutter/material.dart';
import 'package:qma/features/common/ui/widgets/responsive_layout.dart';
import 'package:qma/features/dashboard/ui/widgets/attendance_line_chart.dart';
import 'package:qma/features/dashboard/ui/widgets/class_attendance_bar_chart.dart';
import 'package:qma/features/dashboard/ui/widgets/events_list.dart';
import 'package:qma/features/dashboard/ui/widgets/fee_payment_status_chart.dart';
import 'package:qma/features/dashboard/ui/widgets/finance_chart.dart';
import 'package:qma/features/dashboard/ui/widgets/gender_pie_chart.dart';
import 'package:qma/features/dashboard/ui/widgets/notices_list.dart';
import 'package:qma/features/dashboard/ui/widgets/present_absent_pie_chart.dart';
import 'package:qma/features/dashboard/ui/widgets/recent_admissions_list.dart';
import 'package:qma/features/dashboard/ui/widgets/summary_cards.dart';
import 'package:qma/features/dashboard/ui/widgets/unpaid_fees_list.dart';
import 'package:qma/features/dashboard/ui/widgets/upcoming_events_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _mobileDashboard(),
      tablet: _desktopDashboard(),
      desktop: _desktopDashboard(),
    );
  }

  // Desktop dashboard
  Widget _desktopDashboard() {
    return Column(
      children: [
        // Summary Cards
        SummaryCards(),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: GenderPieChart()),
                          Expanded(child: PresentAbsentPieChart()),
                        ],
                      ),
                      AttendanceLineChart(),
                      ClassAttendanceBarChart(),
                      FeePaymentStatusChart(),
                      FinanceChart(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UnpaidFeesList(),
                      RecentAdmissionsList(),
                      NoticesList(),
                      EventsList(),
                      UpcomingEventsList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // Mobile dashboard
  Widget _mobileDashboard() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SummaryCards(),
            SizedBox(height: 16),
            GenderPieChart(),
            SizedBox(height: 16),
            PresentAbsentPieChart(),
            SizedBox(height: 16),
            AttendanceLineChart(),
            SizedBox(height: 16),
            ClassAttendanceBarChart(),
            SizedBox(height: 16),
            FeePaymentStatusChart(),
            SizedBox(height: 16),
            UnpaidFeesList(),
            SizedBox(height: 16),
            RecentAdmissionsList(),
            SizedBox(height: 16),
            FinanceChart(),
            SizedBox(height: 16),
            NoticesList(),
            SizedBox(height: 16),
            EventsList(),
            SizedBox(height: 16),
            UpcomingEventsList(),
          ],
        ),
      ),
    );
  }
}
