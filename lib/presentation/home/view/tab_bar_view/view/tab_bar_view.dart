
import 'package:flutter/material.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/presentation/home/view/dashboard_view/view/dashboard_view.dart';


class AgencyDashboardScreen extends StatefulWidget {
  const AgencyDashboardScreen({super.key});

  @override
  State<AgencyDashboardScreen> createState() => _AgencyDashboardScreenState();
}

class _AgencyDashboardScreenState extends State<AgencyDashboardScreen> {
  
  int selectedTab = 0;

  final List<Widget> pages = [
    const DashboardView(),
    const Center(child: Text("Package view"),),
   const Center(child: Text("Booking View"),),
  const Center(child: Text("Profile View"),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        title: Center(child: const Text('Agency App')),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBarSection(
            selectedIndex: selectedTab,
            onTabSelected: (index) {
              setState(() {
                selectedTab = index;
              });
            },
          ),
        ),
      ),
      body: pages[selectedTab],
    );
  }
}

class TabBarSection extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TabBarSection({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ['Dashboard', 'Packages', 'Bookings', 'Profile'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tabs.length, (index) {
        return GestureDetector(
          onTap: () => onTabSelected(index),
          child: TabBarItem(
            title: tabs[index],
            isSelected: selectedIndex == index,
          ),
        );
      }),
    );
  }
}

class TabBarItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  const TabBarItem({super.key, required this.title, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
        if (isSelected)
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: SizedBox(
              height: 2,
              width: 60,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
          ),
      ],
    );
  }
}

