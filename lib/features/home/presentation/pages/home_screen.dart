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
import 'package:travelapp/features/home/presentation/widgets/carousel_card.dart';
import 'package:travelapp/features/home/presentation/widgets/user_image_avatar.dart';

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
        imageUrl: "https://picsum.photos/200/300",
        locationTitle: "Kandy"),
    CarouselModel(
        title: "Item 2",
        imageUrl: "https://picsum.photos/200/300",
        locationTitle: "Kandy"),
    CarouselModel(
        title: "Item 3",
        imageUrl: "https://picsum.photos/200/300",
        locationTitle: "Kandy"),
    CarouselModel(
        title: "Item 4",
        imageUrl: "https://picsum.photos/200/300",
        locationTitle: "Kandy"),
    CarouselModel(
        title: "Item 5",
        imageUrl: "https://picsum.photos/200/300",
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
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listenWhen: (previous, current) => current != previous,
      listener: (context, state) async {
        if (state is ConnectivityInitial) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.isConnected
                    ? 'Internet connected.'
                    : 'Internet disconnected.',
                style: TextStyles(context).snackBarText,
              ),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Curved edges
              ),
            ),
          );
          if (state.isConnected) {
            //  Connected actions
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ApplicationColors(context).white,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.all(Dimens.defaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.all(
                            Dimens.defaultPadding * 1),
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
                              UserImageAvatar(imageUrl: userImageUrl),
                            ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 0, 0, 8.0),
                        child: Text(
                          'Upcoming Events to catch...',
                          style: TextStyles(context).homeCarouselHeaderText,
                        ),
                      ),
                      CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: 250.0,
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
                      const SizedBox(height: 16.0),
                      // Page Indicator
                      Align(
                        alignment: Alignment.center,
                        child:
                            BlocBuilder<PageIndicatorCubit, PageIndicatorState>(
                          builder: (context, state) {
                            if (state is PageIndicatorInitial) {
                              return AnimatedSmoothIndicator(
                                activeIndex: state.pageIndex,
                                count: carouselItemsModel.length,
                                effect: const ExpandingDotsEffect(
                                  activeDotColor: Colors.blueAccent,
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
                    ],
                  ),
                ),
              ),
              BlocBuilder<CustomLoadingCubit, CustomLoadingInitial>(
                bloc: customLoadingCubit,
                builder: (context, state) {
                  return CustomLoading(isLoading: state.isLoading);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
