import 'dart:convert';

import 'package:dating/controllers/home_controller.dart';
import 'package:dating/model/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'package:get/get.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen();

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with TickerProviderStateMixin {
  // CardController? controller;
  final HomeController homeController = Get.put(HomeController());
  final CardSwiperController cardController = CardSwiperController();
  @override
  void initState() {
    homeController.retrieveDataList();
    cardController.addListener(() {
      print(cardController.state!.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1600'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Good Morning',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Pawan Kumar',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.menu,
              color: Colors.black54,
            ),
          ],
        ),
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return controller.bannerLocallList.isEmpty
            ? const Center(child: Text('No Data Found'))
            : SizedBox(
                height: Get.height,
                child: Stack(
                  children: [
                    SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: CardSwiper(
                        isLoop: true,
                        onSwipe: (previousIndex, currentIndex, direction) {
                          print('previousIndex: $previousIndex');
                          print('currentIndex: $currentIndex');
                          print('direction: $direction');
                          if (direction == CardSwiperDirection.left) {
                            // controller.swipeCount.value++;
                            // controller.setLocally(controller.swipeCount.value);
                            // print(controller.swipeCount.value);
                            // controller.bannerLocallList.add(BannerModel(
                            //     name: controller.bannerList[currentIndex!]
                            //         ['name'],
                            //     image: controller.bannerList[currentIndex]
                            //         ['image'],
                            //     createdDate: controller.bannerList[currentIndex]
                            //         ['created_date'],
                            //     id: controller.bannerList[currentIndex]['_id'],
                            //     v: controller.bannerList[currentIndex]['__v']));
                          }
                          return true;
                        },
                        controller: cardController,
                        cardsCount: controller.bannerLocallList.length,
                        cardBuilder: (context, index) => Container(
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                controller.bannerLocallList[index].image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 16, 90),
                            child: Text(
                              controller.bannerLocallList[index].name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.restart_alt_outlined,
                                  size: 27,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 65,
                                width: 65,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 27,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 65,
                                width: 65,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    print(cardController);
                                  },
                                  child: const Icon(
                                    Icons.favorite,
                                    size: 27,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 65,
                                width: 65,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.auto_awesome_outlined,
                                  size: 27,
                                  color: Colors.amber,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
