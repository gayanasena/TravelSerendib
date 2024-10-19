import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelapp/core/resources/colors.dart';
import 'package:travelapp/core/resources/dimens.dart';
import 'package:travelapp/core/resources/text_styles.dart';
import 'package:travelapp/features/home/data/model/detail_model.dart';
import 'package:travelapp/features/home/presentation/widgets/detail_carousel_card.dart';
import 'package:travelapp/features/home/presentation/widgets/google_maps_view.dart';
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

  void openMap({String? mapUrl}) {
    double lat = 0.0;
    double long = 0.0;

    if (mapUrl != null) {
      if (mapUrl.isNotEmpty) {
        final regex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
        final match = regex.firstMatch(mapUrl);
        if (match != null) {
          final latitude = double.parse(match.group(1)!);
          final longitude = double.parse(match.group(2)!);

          lat = latitude;
          long = longitude;
        } else {
          lat = 37.7749;
          long = -122.4194;
        }
        showMapBottomSheet(
            long: long,
            lat: lat,
            title: widget.detailModel.title,
            description: '');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          widget.detailModel.title,
          style: TextStyles(context).appBarText,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
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

            // Image Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOut,
                enlargeCenterPage: false,
                viewportFraction: 0.9,
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

            // Title and Rating Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.detailModel.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
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

            // Location, Category, and Season Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLocationRow(),
                  const SizedBox(height: 8),
                  buildCategoryRow(),
                  const SizedBox(height: 8),
                  buildSeasonRow(),
                ],
              ),
            ),

            // Description Section
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0),
              child: TitleText(titleText: "Description"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.detailModel.description,
                style: TextStyles(context).detailViewDescriptionText,
              ),
            ),

            const SizedBox(height: 16),

            // Suggestions Section
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: TitleText(titleText: "Suggestions"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.detailModel.suggestionNote,
                style: TextStyles(context).detailViewDescriptionText,
              ),
            ),

            const SizedBox(height: 24),

            // Open Map Button
            (widget.detailModel.mapUrl != null)
                ? Padding(
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
                          openMap(mapUrl: widget.detailModel.mapUrl);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.map, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              ' View in map',
                              style: TextStyles(context).buttonText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildLocationRow() {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 22, color: Colors.red),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            widget.detailModel.location,
            style: TextStyles(context).detailViewCategory,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget buildCategoryRow() {
    return Row(
      children: [
        const Icon(Icons.category,
            size: 22, color: Color.fromARGB(255, 117, 117, 117)),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            'Category: ${widget.detailModel.category}',
            style: TextStyles(context).detailViewCategory,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget buildSeasonRow() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent.shade400,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today, size: 16.0, color: Colors.white),
          const SizedBox(width: 6.0),
          Text(
            'Best Season: ${widget.detailModel.season}',
            style: TextStyles(context)
                .detailViewCategory
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  showMapBottomSheet(
      {required double long,
      required double lat,
      required String title,
      required String description}) {
    showModalBottomSheet(
      clipBehavior: Clip.antiAlias,
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.defaultBottomSheetRadius),
              topRight: Radius.circular(Dimens.defaultBottomSheetRadius))),
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: context.mQHeight * 0.8,
          ),
          child: Scaffold(
            body: MapScreen(
              description: description,
              latitude: lat,
              longitude: long,
              title: title,
            ),
          ),
        );
      },
    );
  }
}
