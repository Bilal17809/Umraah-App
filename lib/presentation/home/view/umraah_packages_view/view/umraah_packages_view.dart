import 'package:flutter/material.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/presentation/home/view/package_detail_view/view/package_detail_view.dart';
import 'package:umraah_app/presentation/home/view/umraah_packages_view/model/umraah_package_model.dart';

class UmraahPackagesView extends StatelessWidget {
  UmraahPackagesView({super.key});

  final List<UmrahPackageModel> packages = [
    UmrahPackageModel(
      imageUrl: 'assets/images/ummrahpic.jpg',
      title: '7-Day Umrah Package',
      agency: 'Al-Faith Travels',
      date: '7 days • 4-star hotel',
      price: '\$1,200 per person',
      tag: 'View Details',
      tagColor: Colors.green,
      // onTap: () => Get.to(() => SignUpView()),
    ),
    UmrahPackageModel(
      imageUrl: 'assets/images/ummrahpic.jpg',
      title: '5-Day Umrah Package',
      agency: 'Nobel Journey',
      date: '7 days • 3-star hotel',
      price: '\$950 per person',
      tag: 'View Details',
      tagColor: Colors.green,
    ),
    UmrahPackageModel(
      imageUrl: 'assets/images/ummrahpic.jpg',
      title: '7-Day Umrah Package',
      agency: 'Rehman Tours',
      date: '5 days • 5-star hotel',
      price: '\$950 per person',
      tag: 'View Details',
      tagColor: Colors.green,
      // onTap: () => Get.to(() => PackageView()),
    ),
    UmrahPackageModel(
      imageUrl: 'assets/images/ummrahpic.jpg',
      title: '7-Day Umrah Package',
      agency: 'Al-Faith Travels',
      date: '10 days • 8-star hotel',
      price: '\$18, 000 per person',
      tag: 'View Details',
      tagColor: Colors.green,
      // onTap: () => Get.to(() => PackageView()),
    ),
  ];

  late UmrahPackageModel selectedPackage;

  void gotoUmrahpackageDetails(
    UmrahPackageModel package,
    BuildContext context,
  ) {
    selectedPackage = package;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PackageDetailView(pkg: package)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: true,
        title: Text("Umrah App"),
      ),
      backgroundColor: kWhite,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Umrah Packages'),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  final pkg = packages[index];
                  return UmrahPackageCard(
                    imageUrl: pkg.imageUrl,
                    title: pkg.title,
                    agency: pkg.agency,
                    date: pkg.date,
                    price: pkg.price,
                    tag: pkg.tag,
                    tagColor: pkg.tagColor,
                    onTap: () => gotoUmrahpackageDetails(pkg, context),
                  );
                },
              ),
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
      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                        // if (tag == null)
                        //   Text(
                        //     "\$1,200",
                        //     style: const TextStyle(fontWeight: FontWeight.bold),
                        //   ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
