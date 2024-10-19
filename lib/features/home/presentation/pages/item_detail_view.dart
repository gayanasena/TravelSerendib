import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelapp/core/resources/colors.dart';
import 'package:travelapp/core/resources/text_styles.dart';
import 'package:travelapp/features/home/data/model/detail_model.dart';
import 'package:travelapp/features/home/presentation/widgets/detail_carousel_card.dart';
import 'package:travelapp/features/home/presentation/widgets/title_text.dart';

class ItemDetailPage extends StatefulWidget {
  final DetailModel detailModel;

  const ItemDetailPage({
    super.key,
    required this.detailModel,
  });

  @override
  ItemDetailPageState createState() => ItemDetailPageState();
}

class ItemDetailPageState extends State<ItemDetailPage> {
  bool isFavorite = false;
  double rating = 0.0;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void openMap() {
    // Implement navigation to map screen or external map application here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          widget.detailModel.title,
          style: TextStyles(context).appBarText,
          maxLines: 2, // Allows title to wrap into two lines.
          overflow: TextOverflow.ellipsis, // Prevents overflow in the app bar.
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      backgroundColor: ApplicationColors(context).appWhiteBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Image section
            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOut,
                enlargeCenterPage: false,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {},
              ),
              items: widget.detailModel.imageUrls.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return DetailCarouselCard(
                      imageUrl: imageUrl,
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Title and rating section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Wrap title in Expanded to allow flexible space
                  Expanded(
                    child: Text(
                      widget.detailModel.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2, // Allows title to wrap into two lines.
                      overflow:
                          TextOverflow.visible, // Ensure the full title shows.
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Rating section
                  RatingBar.builder(
                    initialRating: widget.detailModel.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 22,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        this.rating = rating;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Location, Category, and Season section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 22,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          widget.detailModel.location,
                          style: TextStyles(context).detailViewCategory,
                          overflow: TextOverflow.ellipsis, // Prevents overflow
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.category,
                        size: 22,
                        color: Color.fromARGB(255, 117, 117, 117),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Category: ${widget.detailModel.category}',
                          style: TextStyles(context).detailViewCategory,
                          overflow: TextOverflow.ellipsis, // Prevents overflow
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade400,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16.0,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'Best Season: ${widget.detailModel.season}',
                      style: TextStyles(context)
                          .detailViewCategory
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // Description section
            const Padding(
              padding: EdgeInsetsDirectional.only(start: 8.0, bottom: 8.0),
              child: TitleText(titleText: "Description"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.detailModel.description,
                style: TextStyles(context).detailViewDescriptionText,
                overflow: TextOverflow.ellipsis, // Prevents overflow
              ),
            ),
            const SizedBox(height: 16),

            // Suggestion note section
            const Padding(
              padding: EdgeInsetsDirectional.only(start: 8.0, bottom: 8.0),
              child: TitleText(titleText: "Suggestions"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.detailModel.suggestionNote,
                style: TextStyles(context).detailViewDescriptionText,
                overflow: TextOverflow.ellipsis, // Prevents overflow
              ),
            ),
            const SizedBox(height: 24),

            // Open map button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {
                    onViewMapClick();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                      Text(
                        ' View in map',
                        style: TextStyles(context).buttonText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void onViewMapClick() {}
}
