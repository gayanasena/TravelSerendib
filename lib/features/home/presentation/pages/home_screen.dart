import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelapp/core/resources/colors.dart';
import 'package:travelapp/core/resources/dimens.dart';
import 'package:travelapp/core/resources/text_styles.dart';
import 'package:travelapp/features/common/cubit/connectivity_cubit/connectivity_cubit.dart';
import 'package:travelapp/features/common/cubit/custom_loading/custom_loading_cubit.dart';
import 'package:travelapp/features/common/widgets/custom_loading.dart';
import 'package:travelapp/features/home/data/model/carousel_model.dart';
import 'package:travelapp/features/home/presentation/cubit/cubit/page_indicator_cubit.dart';
import 'package:travelapp/features/home/presentation/pages/user_profile_view.dart';
import 'package:travelapp/features/home/presentation/widgets/carousel_card.dart';
import 'package:travelapp/features/home/presentation/widgets/category_grid.dart';
import 'package:travelapp/features/home/presentation/widgets/service_grid.dart';
import 'package:travelapp/features/home/presentation/widgets/title_text.dart';
import 'package:travelapp/features/home/presentation/widgets/user_image_avatar.dart';
import 'package:travelapp/features/home/presentation/widgets/wether_card.dart';
import 'package:travelapp/routes/routes.dart';
import 'package:travelapp/routes/routes_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CustomLoadingCubit customLoadingCubit;
  String userName = "User";
  final String userImageUrl = 'https://picsum.photos/200/300';

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  List<CarouselModel> carouselItemsModel = [
    CarouselModel(
        title: "Item 1",
        imageUrl: "https://picsum.photos/300/200",
        locationTitle: "Kandy"),
    CarouselModel(
        title: "Item 2",
        imageUrl: "https://picsum.photos/300/200",
        locationTitle: "Kandy"),
    CarouselModel(
        title: "Item 3",
        imageUrl: "https://picsum.photos/300/200",
        locationTitle: "Kandy"),
    CarouselModel(
        title: "Item 4",
        imageUrl: "https://picsum.photos/300/200",
        locationTitle: "Kandy"),
    CarouselModel(
        title: "Item 5",
        imageUrl: "https://picsum.photos/300/200",
        locationTitle: "Kandy")
  ];

  void carouselOnTap() {
    if (kDebugMode) {
      print("Clicked");
    }
  }

  @override
  void initState() {
    context.read<ConnectivityCubit>();
    customLoadingCubit = CustomLoadingCubit();
    super.initState();
  }

  @override
  void dispose() {
    // _carouselController.dispose();
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
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.mQTopSafeArea,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
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
                              blurRadius: 8.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Welcome $userName !',
                                style:
                                    TextStyles(context).homeScreenUserNameText,
                              ),
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
                  const TitleText(titleText: "Upcoming Events"),
                  Padding(
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
                      items: carouselItemsModel.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: carouselOnTap,
                              child: CarouselCard(
                                imageUrl: item.imageUrl,
                                text: item.title,
                                location: item.locationTitle,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Page Indicator
                  Align(
                    alignment: Alignment.center,
                    child: BlocBuilder<PageIndicatorCubit, PageIndicatorState>(
                      builder: (context, state) {
                        if (state is PageIndicatorInitial) {
                          return AnimatedSmoothIndicator(
                            activeIndex: state.pageIndex,
                            count: carouselItemsModel.length,
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
                  ),
                  const TitleText(titleText: "Today’s Weather"),
                  const WeatherUpdateWidget(),
                  const TitleText(titleText: "Discover Your Next Adventure"),
                  SizedBox(
                    height: 400,
                    child: CategoryGrid(
                      onCategoryTap: (category) {
                        context.toNamed(ScreenRoutes.toItemGridScreen,
                            args: category);
                      },
                    ),
                  ),
                  const TitleText(titleText: "Services"),
                  ServiceGrid()
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
          child: Scaffold(
            body: UserProfileScreen(
              userName: "User",
              userEmail: "User@gmail.com",
              profileImageUrl: userImageUrl,
              logout: () {},
            ),
          ),
        );
      },
    );
  }
}
