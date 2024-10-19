import 'package:flutter/material.dart';
import 'package:travelapp/core/resources/colors.dart';
import 'package:travelapp/core/resources/dimens.dart';
import 'package:travelapp/core/resources/text_styles.dart';
import 'package:travelapp/features/home/data/Services/firebase_services.dart';
import 'package:travelapp/features/home/data/model/detail_model.dart';
import 'package:travelapp/features/home/presentation/widgets/search_bar.dart';
import 'package:travelapp/routes/routes.dart';
import 'package:travelapp/routes/routes_extension.dart';

class ItemGridView extends StatefulWidget {
  final String gridType;

  const ItemGridView({super.key, required this.gridType});

  @override
  ItemGridViewState createState() => ItemGridViewState();
}

class ItemGridViewState extends State<ItemGridView> {
  late FirebaseServices firebaseServices;
  late TextEditingController searchBarTextEditingController;
  List<DetailModel> lisDetailTableModel = [];
  List<DetailModel> filteredList = [];
  List<String> availableFilters = [];

  @override
  void initState() {
    searchBarTextEditingController = TextEditingController();
    firebaseServices = FirebaseServices();
    getListData();
    super.initState();
  }

  void getListData() async {
    String collectionName = "";
    if (widget.gridType == 'Travel Destinations') {
      collectionName = 'destinations';
    } else {
      collectionName = widget.gridType.toLowerCase();
    }
    lisDetailTableModel =
        await firebaseServices.fetchAllData(collectionName: collectionName);

    if (lisDetailTableModel.isNotEmpty) {
      setState(() {
        filteredList = lisDetailTableModel; // Initially, display all items.

        // Extract unique categories for filters
        availableFilters =
            lisDetailTableModel.map((item) => item.category).toSet().toList();
      });
    }
  }

  // Filter function based on search text and category filter
  void filterSearchResults(String query, {String? selectedFilter}) {
    List<DetailModel> tempList = [];
    if (query.isNotEmpty || selectedFilter != null) {
      tempList = lisDetailTableModel.where((item) {
        final matchesSearch =
            item.title.toLowerCase().contains(query.toLowerCase());
        final matchesCategory =
            selectedFilter == null || item.category == selectedFilter;
        return matchesSearch && matchesCategory;
      }).toList();
    } else {
      tempList = lisDetailTableModel;
    }

    setState(() {
      filteredList = tempList;
    });
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
        title: Text(widget.gridType, style: TextStyles(context).appBarText),
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
                  filterSearchResults(searchString);
                },
                availableFilters: availableFilters, // Pass dynamic filters here
              ),
              const SizedBox(
                height: 8.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
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
                                item.imageUrls.first,
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
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    item.description,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey.shade800,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
