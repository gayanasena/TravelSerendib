import 'package:flutter/material.dart';
import 'package:travelapp/core/resources/colors.dart';
import 'package:travelapp/core/resources/dimens.dart';
import 'package:travelapp/core/resources/text_styles.dart';
import 'package:travelapp/features/home/data/model/grid_view_model.dart';
import 'package:travelapp/features/home/presentation/widgets/search_bar.dart';
import 'package:travelapp/routes/routes.dart';
import 'package:travelapp/routes/routes_extension.dart';

class ItemGridView extends StatefulWidget {
  final String gridViewType;

  const ItemGridView({super.key, required this.gridViewType});

  @override
  ItemGridViewState createState() => ItemGridViewState();
}

class ItemGridViewState extends State<ItemGridView> {
  late TextEditingController searchBarTextEditingController;
  final List<GridViewModel> lisGridItem = [
    GridViewModel(
      id: 1,
      title: 'Beautiful Beach',
      description: 'Relax by the ocean with beautiful views.',
      imageUrl: 'https://picsum.photos/300/200?random=1',
    ),
    GridViewModel(
      id: 2,
      title: 'Mountain Adventure',
      description: 'Explore stunning mountains and trails.',
      imageUrl: 'https://picsum.photos/300/200?random=2',
    ),
    GridViewModel(
      id: 3,
      title: 'City Exploration',
      description: 'Discover vibrant city life and culture.',
      imageUrl: 'https://picsum.photos/300/200?random=3',
    ),
    GridViewModel(
      id: 4,
      title: 'Historical Sites',
      description: 'Visit places of historical significance.',
      imageUrl: 'https://picsum.photos/300/200?random=4',
    ),
  ];

  @override
  void initState() {
    super.initState();
    searchBarTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    searchBarTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.gridViewType, style: TextStyles(context).appBarText),
        elevation: 0,
      ),
      body: Container(
        color: ApplicationColors(context).appBackground,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.defaultPadding),
          child: Column(
            children: [
              CustomSearchBar(
                controller: searchBarTextEditingController,
                onChanged: (searchString) {
                  // Implement search functionality if needed
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2.0,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: lisGridItem.length,
                  itemBuilder: (context, index) {
                    final item = lisGridItem[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.white,
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          context.toNamed(ScreenRoutes.toItemDetailScreen,
                              args: item);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              child: Image.network(
                                item.imageUrl,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    item.description,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
