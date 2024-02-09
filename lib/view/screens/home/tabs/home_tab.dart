import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wac_test_001/core/constants/app_images.dart';
import 'package:wac_test_001/core/helpers/shimmer.dart';
import 'package:wac_test_001/model/response/home_model.dart';
import 'package:wac_test_001/theme/app_theme.dart';
import 'package:wac_test_001/view/widgets/custom_text.dart';
import 'package:wac_test_001/view/widgets/custom_text_field.dart';
import 'package:wac_test_001/view_model/home_view_model.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homePro = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(
      
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        backgroundColor: primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(Images.cart,height: 50,width: 50,),
        ),
        title: CustomTextfield(controller: TextEditingController(), name: ""),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Badge.count(
              count: 0,
              child: const Icon(Icons.notifications_outlined,color: Colors.white,)),
          )
        ],
      ),
      body: homePro.isLoading?const Loader():  RefreshIndicator(
        onRefresh: () async{
          homePro.onFetchHomeAPI();
        },
        child: ListView(
          children:  [
            if(homePro.homeModelList.isNotEmpty)
              const BannerView(),
        
            const Column(
              children: [
                HeadingView(title: "Most Popular"),
                MostPopularView(),
                SingleBannerView(),
                HeadingView(title: "Catagories"),
                CategoriesView(),
                HeadingView(title: "Featured Products"),
                FeaturedProductsView(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FeaturedProductsView extends StatelessWidget {
  const FeaturedProductsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homePro  = context.watch<HomeViewModel>();
    return SizedBox(
      height: 230.h,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>  ProductItem(model:homePro.homeModelList[1].contents![index] ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: homePro.homeModelList[1].contents!.length),
    );
  }
}

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => const CategoryItem(),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: 5),
    );
  }
}

class SingleBannerView extends StatelessWidget {
  const SingleBannerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 100.h,
              width: MediaQuery.of(context).size.width,
              imageUrl:
                  "https://oxygen-test.webc.in/media/cache/800x0/mobile/banner/i watch New_1675658860.jpg")),
    );
  }
}

class MostPopularView extends StatelessWidget {
  const MostPopularView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homePro = context.watch<HomeViewModel>();
    return SizedBox(
      height: 230.h,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>  ProductItem(model:  homePro.homeModelList[1].contents![index]),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: homePro.homeModelList[1].contents!.length),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffD4D4D4), width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          CachedNetworkImage(
              height: 80,
              width: 80,
              imageUrl:
                  "https://oxygen-test.webc.in/media/cache/100x0/mobile/homeCategories/Mask Group 4408_1678191046.png"),
          SizedBox(
            height: 5.h,
          ),
          const CustomText(
            name: "Grocery & Foods",
            fontsize: 12,
          )
        ],
      ),
    );
  }
}

class HeadingView extends StatelessWidget {
  final String title;
  const HeadingView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            name: title,
            fontsize: 15,
          ),
          const CustomText(
            name: "View all",
            fontsize: 12,
          )
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Content model;
  const ProductItem({
    super.key,
    required this.model
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffD4D4D4), width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h,),
          Center(
            child: CachedNetworkImage(
                height: 80.h,
                width: 100.w,
                fit: BoxFit.cover,
                imageUrl:
                    model.productImage??''),
          ),
          SizedBox(height: 10.h,),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffFB7B4E)),
            child: const CustomText(
              name: "Sale 65% Off",
              fontsize: 8,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          const CustomText(
            name: "Lenovo K3 Mini Outdoor Wireless Speaker",
            maxlines: 2,
            fontsize: 10,
          ),
          SizedBox(
            height: 5.h,
          ),
          RatingBar.builder(
   initialRating: 3,
   itemSize: 20,
   minRating: 1,
   
   direction: Axis.horizontal,
   allowHalfRating: false,
  
   itemCount: 5,
   itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
   itemBuilder: (context, _) => const Icon(
     Icons.star,
     color: Color(0xffFFB038),
   ),
   onRatingUpdate: (rating) {
     print(rating);
   },
),
  SizedBox(
            height: 5.h,
          ),
          const CustomText(
            name: "৳100 ৳300",
            fontsize: 11,
          )
        ],
      ),
    );
  }
}

class BannerView extends StatelessWidget {
  const BannerView({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final homePro = context.watch<HomeViewModel>();
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: homePro.carouselController,
          options: CarouselOptions(
            viewportFraction: 1,
            height: 150.0,
            autoPlay: true,
            onPageChanged: (index, reason) {
              homePro.onChangeSlider(index);
            },
          ),
          items: homePro.homeModelList[0].contents!.asMap().entries.map((i) {
            var slider = homePro.homeModelList[0].contents![i.key];
            return Builder(
              builder: (BuildContext context) {
                return Image.network(
                  slider.imageUrl!,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                );
              },
            );
          }).toList(),
        ),

         Padding(
           padding: const EdgeInsets.only(bottom: 10),
           child: Center(
            child: DotsIndicator(
              dotsCount: homePro.homeModelList[0].contents!.isEmpty
                  ? 1
                  : homePro.homeModelList[0].contents!.length,
              position: homePro.currentSlider,
              decorator: const DotsDecorator(
                size: Size(9, 9),
                activeSize: Size(11, 11),
                color: Colors.grey, // Inactive color
                activeColor: Colors.white,
              ),
            ),
                   ),
         ),
      
      ],
    );
  }
}
