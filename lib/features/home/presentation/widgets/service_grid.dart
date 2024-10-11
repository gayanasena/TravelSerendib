import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/core/resources/colors.dart';
import 'package:travelapp/core/resources/dimens.dart';

class ServiceGrid extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {"title": "Translate", "icon": Icons.translate},
    {"title": "Book a ride", "icon": Icons.local_taxi},
  ];

  ServiceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.defaultPadding),
      child: SizedBox(
        height: 100, // Adjust height to fit the tile size
        child: GridView.count(
          crossAxisCount: 2, // 2 items in a single row
          childAspectRatio: 3.0, // Adjust the aspect ratio to make tiles wide
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          children: services.map((service) {
            return GestureDetector(
              onTap: () {
                // Handle tap, for example, navigate to a service details page
                if (kDebugMode) {
                  print("Tapped on: ${service['title']}");
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryColor, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      service['icon'],
                      color: Colors.white,
                      size: 24.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      service['title'],
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
