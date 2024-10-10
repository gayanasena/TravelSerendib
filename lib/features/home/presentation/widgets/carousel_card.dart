import 'package:flutter/material.dart';
import 'package:travelapp/core/resources/colors.dart';

class CarouselCard extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String location;

  const CarouselCard({
    super.key,
    required this.imageUrl,
    required this.text,
    required this.location, // Added location parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: ApplicationColors(context).shimmerBackground,
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black54,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black54,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
