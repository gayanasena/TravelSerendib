import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelapp/core/resources/colors.dart';
import 'package:travelapp/core/resources/dimens.dart';
import 'package:travelapp/core/resources/text_styles.dart';
import 'package:travelapp/features/common/cubit/custom_loading/custom_loading_cubit.dart';
import 'package:travelapp/features/common/widgets/custom_loading.dart';
import 'package:travelapp/features/home/data/Services/firebase_services.dart';
import 'package:travelapp/features/home/data/model/detail_model.dart';
import 'package:travelapp/features/home/presentation/cubit/cubit/page_indicator_cubit.dart';
import 'package:travelapp/features/home/presentation/pages/user_profile_view.dart';
import 'package:travelapp/features/home/presentation/widgets/carousel_card.dart';
import 'package:travelapp/features/home/presentation/widgets/category_grid.dart';
import 'package:travelapp/features/home/presentation/widgets/destination_card.dart';
import 'package:travelapp/features/home/presentation/widgets/service_grid.dart';
import 'package:travelapp/features/home/presentation/widgets/title_text.dart';
import 'package:travelapp/features/home/presentation/widgets/user_image_avatar.dart';
import 'package:travelapp/features/home/presentation/widgets/weather_card.dart';
import 'package:travelapp/routes/routes.dart';
import 'package:travelapp/routes/routes_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseServices firebaseServices;
  late FlutterSecureStorage secureStorage;
  late CustomLoadingCubit customLoadingCubit;
  late String userImageUrl = '';

  List<DetailModel> lisRatedDetailModel = [];
  List<DetailModel> lisUpComingEvents = [];

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    customLoadingCubit = CustomLoadingCubit();
    secureStorage = const FlutterSecureStorage();
    firebaseServices = FirebaseServices();
    setUserImage();
    getPopulerDestinationsListData();
    getUpcomingEventsListData();
    super.initState();
  }

  void setUserImage() async {
    userImageUrl = await secureStorage.read(key: 'userImageUrl') ?? '';
  }

  void getPopulerDestinationsListData() async {
    String collectionName = 'destinations';

    List<DetailModel> lisDetailModel =
        await firebaseServices.fetchAllData(collectionName: collectionName);

    if (lisDetailModel.isNotEmpty) {
      setState(() {
        lisRatedDetailModel =
            lisDetailModel.where((item) => item.rating >= 4.0).toList();
      });
    }
  }

  void getUpcomingEventsListData() async {
    String collectionName = 'events';

    // Fetch data from Firebase
    List<DetailModel> lisDetailModel =
        await firebaseServices.fetchAllData(collectionName: collectionName);

    if (lisDetailModel.isNotEmpty) {
      DateTime now = DateTime.now();
      int currentMonth = now.month;

      // Map of season months to their respective month numbers
      Map<String, int> monthMap = {
        'January': 1,
        'February': 2,
        'March': 3,
        'April': 4,
        'May': 5,
        'June': 6,
        'July': 7,
        'August': 8,
        'September': 9,
        'October': 10,
        'November': 11,
        'December': 12,
      };

      // Filter events that are in the current month or in the future months
      setState(() {
        lisUpComingEvents = lisDetailModel.where((item) {
          int eventMonth = monthMap[item.season] ?? 0;
          return eventMonth >= currentMonth; // Filter future events
        }).toList();
      });
    }
  }

  void setCurrentUserData() async {
    final imageUrl = await secureStorage.read(key: 'userImageUrl') ?? '';

    // Update state only if necessary
    setState(() {
      userImageUrl = imageUrl;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationColors(context).appBackground,
      body: Stack(
        children: [
          CustomScrollView(slivers: [
            SliverAppBar(
              pinned: false,
              automaticallyImplyLeading: false,
              backgroundColor: ApplicationColors(context).appWhiteBackground,
              expandedHeight: 85,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.defaultPadding),
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.mQTopSafeArea,
                      ),
                      Container(
                        padding: const EdgeInsets.all(Dimens.defaultPadding),
                        decoration: BoxDecoration(
                          color: ApplicationColors(context).appWhiteBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ApplicationColors(context)
                                  .shadowContainers
                                  .withOpacity(0.1),
                              offset: const Offset(0, 4),
                              blurRadius: Dimens.defaultPadding,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Travel Serendib',
                              style: TextStyles(context).homeHeaderTitle,
                            ),
                            Wrap(children: [
                              GestureDetector(
                                  onTap: () {
                                    showUserBottomSheet();
                                  },
                                  child:
                                      UserImageAvatar(imageUrl: userImageUrl)),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (lisUpComingEvents.isNotEmpty)
                      ? const TitleText(titleText: "Upcoming Events")
                      : Container(),
                  (lisUpComingEvents.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: Dimens.defaultPadding),
                          child: CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: 200.0,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.easeInOut,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                context
                                    .read<PageIndicatorCubit>()
                                    .setPageIndex(index: index);
                              },
                            ),
                            items: lisUpComingEvents.map((item) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.toNamed(
                                          ScreenRoutes.toItemDetailScreen,
                                          args: item);
                                    },
                                    child: CarouselCard(
                                      imageUrl: item.imageUrls.first,
                                      text: item.title,
                                      location: item.location,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        )
                      : Container(),
                  (lisUpComingEvents.isNotEmpty)
                      ? const SizedBox(height: 16.0)
                      : Container(),
                  // Page Indicator
                  (lisUpComingEvents.isNotEmpty)
                      ? Align(
                          alignment: Alignment.center,
                          child: BlocBuilder<PageIndicatorCubit,
                              PageIndicatorState>(
                            builder: (context, state) {
                              if (state is PageIndicatorInitial) {
                                return AnimatedSmoothIndicator(
                                  activeIndex: state.pageIndex,
                                  count: lisUpComingEvents.length,
                                  effect: const ExpandingDotsEffect(
                                    activeDotColor: primaryColor,
                                    dotHeight: 9,
                                    dotWidth: 9,
                                    spacing: 6,
                                  ),
                                  onDotClicked: (index) {
                                    _carouselController.animateToPage(index);
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        )
                      : Container(),
                  const TitleText(titleText: "Today’s Weather"),
                  // const WeatherUpdateWidget(),
                  const WeatherUpdateWidget(),
                  (lisRatedDetailModel.isNotEmpty)
                      ? const TitleText(titleText: "Populer destinations")
                      : Container(),
                  (lisRatedDetailModel.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.all(Dimens.defaultPadding),
                          child: SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: lisRatedDetailModel.length,
                              itemBuilder: (context, index) {
                                final destination = lisRatedDetailModel[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.toNamed(
                                        ScreenRoutes.toItemDetailScreen,
                                        args: destination);
                                  },
                                  child: PopularDestinationCard(
                                    title: destination.title,
                                    location: destination.location,
                                    imageUrl: destination.imageUrls.first,
                                    rating: destination.rating,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  const TitleText(titleText: "Discover Your Next Adventure"),
                  SizedBox(
                    height: 400,
                    child: CategoryGrid(
                      onCategoryTap: (category) {
                        if (category == "Event Calendar") {
                          context.toNamed(
                            ScreenRoutes.toEventCalenderScreen,
                          );
                        } else {
                          context.toNamed(ScreenRoutes.toItemGridScreen,
                              args: category);
                        }
                      },
                    ),
                  ),
                  const TitleText(titleText: "Services"),
                  const ServiceGrid()
                ],
              ),
            )
          ]),
          BlocBuilder<CustomLoadingCubit, CustomLoadingInitial>(
            bloc: customLoadingCubit,
            builder: (context, state) {
              return CustomLoading(isLoading: state.isLoading);
            },
          )
        ],
      ),
    );
  }

  void showUserBottomSheet() {
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
          child: const Scaffold(
            body: UserProfileScreen(),
          ),
        );
      },
    );
  }
}
