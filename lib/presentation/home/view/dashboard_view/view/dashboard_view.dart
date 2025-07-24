import 'package:flutter/material.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/presentation/home/view/package_view/view/package_view.dart';
import 'package:umraah_app/presentation/home/view/sign_up_view/view/sign_up_view.dart';
import 'package:umraah_app/presentation/home/view/umraah_packages_view/view/umraah_packages_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Dashboard'),
            const SizedBox(height: 10),
            UmrahPackageCard(
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpView()),
                  ),
              imageUrl: 'assets/images/ummrahpic.jpg',
              title: '5-Day Umrah Package',
              agency: 'Al-Faith Travels',
              date: 'March 15, 2024',
              price: '\$1,200 per person',
              tag: 'Details',
              tagColor: Colors.green,
            ),

            const SizedBox(height: 10),
            UmrahPackageCard(
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UmraahPackagesView()),
                  ),
              imageUrl: 'assets/images/ummrahpic.jpg',
              title: '5-Day Umrah Package',
              agency: 'April 5, 2024',
              date: 'April 5, 2024',
              price: '\$950 per person',
              tag: 'New',
              tagColor: Colors.green,
            ),

            const SizedBox(height: 20),
            const SectionTitle(title: 'Packages'),
            const SizedBox(height: 10),
            UmrahPackageCard(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PackageView()),
                  ),
              imageUrl: 'assets/images/ummrahpic.jpg',
              title: '7-Day Umrah Package',
              agency: '',
              date: 'March 15, 2024',
              price: "",
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class UmrahPackageCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String agency;
  final String date;
  final String? price;
  final String? tag;
  final Color? tagColor;
  final VoidCallback? onTap;
  const UmrahPackageCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.agency,
    required this.date,
    this.price,
    this.tag,
    this.tagColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: kWhite,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imageUrl,
                      height: 78,
                      width: 78,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        if (agency.isNotEmpty)
                          Text(
                            agency,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        if (agency.isNotEmpty) SizedBox(height: 14),
                        Text(date, style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 4),
                        if (tag == null)
                          Text(
                            "\$1,200",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (tag != null) SizedBox(height: 10),
              if (tag != null) Divider(color: Colors.grey.withOpacity(0.08)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$price',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (tag != null)
                      Text(
                        tag!,
                        style: TextStyle(color: tagColor ?? Colors.black),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
