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
          child: Image.asset(
            Images.cart,
            height: 50,
            width: 50,
          ),
        ),
        title: CustomTextfield(
          controller: TextEditingController(),
          name: "",
          readOnly: true,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Badge.count(
                count: 0,
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: homePro.isLoading
          ? const Loader()
          : RefreshIndicator(
              onRefresh: () async {
                homePro.onFetchHomeAPI();
                homePro.fetchLocalData();
              },
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  if (homePro.bannerList.isNotEmpty) const BannerView(),
                   Column(
                    children: [
                      const HeadingView(title: "Most Popular"),
                      if(homePro.popularProductsList.isNotEmpty)
                      const MostPopularView(),
                      const SingleBannerView(),
                      const HeadingView(title: "Catagories"),
                       if(homePro.categoriesList.isNotEmpty)
                      const CategoriesView(),
                      const HeadingView(title: "Featured Products"),
                       if(homePro.featuredProductsList.isNotEmpty)
                      const FeaturedProductsView(),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
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
    final homePro = context.watch<HomeViewModel>();
    return SizedBox(
      height: 230.h,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              ProductItem(model: homePro.featuredProductsList[index]),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: homePro.featuredProductsList.length),
    );
  }
}

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homePro = Provider.of<HomeViewModel>(context);
    return SizedBox(
      height: 95.h,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              CategoryItem(model: homePro.categoriesList[index]),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: homePro.categoriesList.length),
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
              imageUrl: context.watch<HomeViewModel>().singleBannerUrl ??
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
          itemBuilder: (context, index) =>
              ProductItem(model: homePro.popularProductsList[index]),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: homePro.popularProductsList.length),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Content model;
  const CategoryItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // width: 120,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffD4D4D4), width: 2),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
                height: 60, width: 100, imageUrl: model.imageUrl ?? '',
                errorWidget: (context, url, error) =>const Icon(Icons.image,size: 60,color: Colors.grey,),
                ),
            SizedBox(
              height: 5.h,
            ),
            CustomText(
              name: model.title ?? "Grocery & Foods",
              fontsize: 12,
            )
          ],
        ),
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
  const ProductItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    String cleanedOfferPrice = "₹100";
    String cleanedActualPrice = "₹100";
    double price = 0.0;
    double actualPrice = 0.0;
    if(model.offerPrice!=null || model.actualPrice!=null){
  cleanedOfferPrice =
        model.offerPrice!.replaceAll('₹', '').replaceAll(',', '');
     cleanedActualPrice =
        model.actualPrice!.replaceAll('₹', '').replaceAll(',', '');
     price = double.tryParse(cleanedOfferPrice) ?? 0.0;
     actualPrice = double.tryParse(cleanedActualPrice) ?? 0.0;
    }
   

    return Container(
      width: 180,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffD4D4D4), width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: CachedNetworkImage(
                height: 80.h,
                width: 100.w,
                fit: BoxFit.cover,
                imageUrl: model.productImage ?? ''),
          ),
          SizedBox(
            height: 10.h,
          ),
          if (price > 0)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffFB7B4E)),
              child: CustomText(
                name: "Sale ${model.discount}",
                fontsize: 8,
              ),
            ),
          SizedBox(
            height: 5.h,
          ),
          CustomText(
            name:
                model.productName ?? "Lenovo K3 Mini Outdoor Wireless Speaker",
            maxlines: 2,
            fontsize: 10,
          ),
          SizedBox(
            height: 5.h,
          ),
          RatingBar.builder(
            initialRating: model.productRating?.toDouble() ?? 0,
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
          Row(
            children: [
              CustomText(
                name: model.offerPrice ?? "৳300",
                fontsize: 11,
              ),
              SizedBox(
                width: 5.w,
              ),
              if (price != actualPrice)
                CustomText(
                  decoration: TextDecoration.lineThrough,
                  name: model.actualPrice ?? "৳100",
                  fontsize: 11,
                ),
            ],
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
            height: 180.0,
            autoPlay: true,
            onPageChanged: (index, reason) {
              homePro.onChangeSlider(index);
            },
          ),
          items: homePro.bannerList.asMap().entries.map((i) {
            var slider = homePro.bannerList[i.key];
            return Builder(
              builder: (BuildContext context) {
                return CachedNetworkImage(
                  imageUrl: slider.imageUrl ?? "",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.grey,
                  ),
                );
              },
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: DotsIndicator(
              dotsCount:
                  homePro.bannerList.isEmpty ? 1 : homePro.bannerList.length,
              position: homePro.currentSlider,
              decorator: const DotsDecorator(
                size: Size(7, 7),
                activeSize: Size(9, 9),
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
