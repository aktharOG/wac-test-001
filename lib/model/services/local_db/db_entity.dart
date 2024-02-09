import 'package:floor/floor.dart';

@entity
class ContentEntity {
    String? title;
    String? imageUrl;
    String? sku;
    String? productName;
    String? productImage;
    int? productRating;
    String? actualPrice;
    String? offerPrice;
    String? discount;

    ContentEntity({
        this.title,
        this.imageUrl,
        this.sku,
        this.productName,
        this.productImage,
        this.productRating,
        this.actualPrice,
        this.offerPrice,
        this.discount,
    });

}
