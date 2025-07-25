import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:umraah_app/core/theme/app_colors.dart';
import 'package:umraah_app/core/theme/app_styles.dart';
import 'package:umraah_app/core/theme/app_theme.dart';
import 'package:umraah_app/presentation/home/view/umraah_packages_view/model/umraah_package_model.dart';

class PackageDetailView extends StatelessWidget {
  final UmrahPackageModel pkg;
  const PackageDetailView({super.key, required this.pkg});

  @override
  Widget build(BuildContext context) {
 final hiegt = MediaQuery.of(context).size.height;
 final width = MediaQuery.of(context).size.width;
    final List<String> parts = pkg.date.split('•');
final String duration = parts[0].trim(); 
final String hotel = parts.length > 1 ? parts[1].trim() : '';

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(centerTitle: true, title: Text("Umraah App")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pkg.title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(pkg.agency, style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  pkg.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(pkg.price, style: TextStyle(fontSize: 20)),
              SizedBox(height: 25),
              _reusbaleRow(title: "Duration:", lastTile: duration),
             
              _reusbaleRow(title: "Accommodation:", lastTile: hotel),
              SizedBox(height: 20),
                Container(
                  height: hiegt * 0.17,
                  width: double.infinity,
                  decoration: roundedDecoration,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description", style: TextStyle(fontSize: 20)),
                        SizedBox(height: 10),
                        Text(
                          "Include Package. confrommation including transportation between hotel and holy sites, and sugeted its.",
                          style: TextStyle(fontSize: 14),
                        ),
                      
                      ],
                    ),
                  ),
                ),
                   SizedBox(height: 14),
                ElevatedButton(
                  style: AppTheme.elevatedButtonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Book Now"),
                ),
            ],
                
          ),
        ),
      ),
    );
  }
}

class _reusbaleRow extends StatelessWidget {
  final String title;
  final String lastTile;
  const _reusbaleRow({super.key, required this.title, required this.lastTile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title, style: TextStyle(fontSize: 20)), Text(lastTile)],
      ),
    );
  }
}
