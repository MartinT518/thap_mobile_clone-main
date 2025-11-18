import 'package:json_annotation/json_annotation.dart';
import 'package:thap/models/cdn_image.dart';

part 'product_page.g.dart';

@JsonSerializable(createToJson: false)
class ProductPagesModel {
  final String productId;
  final List<CdnImage> userImages;
  final List<ProductPageModel> pages;

  ProductPagesModel({
    required this.userImages,
    required this.productId,
    required this.pages,
  });

  factory ProductPagesModel.fromJson(Map<String, dynamic> json) {
    final model = _$ProductPagesModelFromJson(json);

    for (var page in model.pages) {
      page.userImages = model.userImages;
      // Filter out hidden components
      page.components = page.components
          .where((c) => c.hidden == null || c.hidden == false)
          .toList();
    }
    return model;
  }
}

@JsonSerializable(createToJson: false)
class ProductPageModel {
  @JsonKey(name: 'id')
  final String pageId;
  final String title;
  @JsonKey(name: 'contents')
  List<ProductPageComponentModel> components;
  @JsonKey(ignore: true)
  List<CdnImage> userImages = [];

  ProductPageModel(
      {required this.pageId, required this.title, required this.components});

  factory ProductPageModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPageModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class ProductPageComponentModel {
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final ProductPageComponentType? type;
  final String? title;
  final String? subTitle;
  final ProductPageComponentLinkModel? link;
  final List<ProductPageComponentLinkModel>? links;
  final ProductPageComponentRatingModel? rating;
  final List<CdnImage>? cdnImages;
  final String? content;
  final String? contentUrl;
  final ProductPageComponentContactModel? contact;
  final List<Map<String, String>>? tableContents;
  final List<SearchLinkContentModel>? searchLinksContent;
  final DividerModel? divider;
  final VideoModel? video;
  final bool? userCanEdit;
  final bool? allowCopy;
  final bool? canUpload;
  final bool? hidden;
  final bool? clamping;

  ProductPageComponentModel(
      {this.type,
      this.title,
      this.subTitle,
      this.link,
      this.links,
      this.rating,
      this.cdnImages,
      this.content,
      this.contentUrl,
      this.contact,
      this.tableContents,
      this.searchLinksContent,
      this.divider,
      this.video,
      this.userCanEdit,
      this.allowCopy,
      this.canUpload,
      this.hidden,
      this.clamping});

  factory ProductPageComponentModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPageComponentModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class ProductPageComponentLinkModel {
  final String? icon;
  final String? title;
  final String? href;
  final String? display;
  @JsonKey(name: 'colour')
  final String? color;
  final bool? hidden;

  bool get openInModal => display == 'modal';

  ProductPageComponentLinkModel(
      {this.icon,
      this.title,
      this.href,
      this.display = 'page',
      this.color,
      this.hidden});

  factory ProductPageComponentLinkModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPageComponentLinkModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class ProductPageComponentRatingModel {
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final ProductPageComponentRatingType? type;
  final String value;

  ProductPageComponentRatingModel({required this.type, required this.value});

  factory ProductPageComponentRatingModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPageComponentRatingModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class ProductPageComponentContactModel {
  final String website;
  final String email;
  final String location;
  final String phone;

  ProductPageComponentContactModel(
      {required this.website,
      required this.email,
      required this.location,
      required this.phone});

  factory ProductPageComponentContactModel.fromJson(
          Map<String, dynamic> json) =>
      _$ProductPageComponentContactModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class SearchLinkContentModel {
  final SearchLinkType? type;
  final String query;

  SearchLinkContentModel({this.type, required this.query});

  factory SearchLinkContentModel.fromJson(Map<String, dynamic> json) =>
      _$SearchLinkContentModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class DividerModel {
  final double height;
  @JsonKey(name: 'colour')
  final String? color;

  DividerModel({required this.height, this.color});

  factory DividerModel.fromJson(Map<String, dynamic> json) =>
      _$DividerModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class VideoModel {
  final String? previewImage;
  final String? title;
  final String videoUrl;

  VideoModel({this.previewImage, this.title, required this.videoUrl});

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.pascal)
enum ProductPageComponentRatingType { text, stars }

@JsonEnum(fieldRename: FieldRename.pascal)
enum ProductPageComponentType {
  title,
  imageCarusel,
  actionButtons,
  rating,
  shortcutBand,
  message,
  menuItem,
  @JsonValue('HTMLContent')
  htmlContent,
  document,
  actionLink,
  keyValueTable,
  addressBlock,
  items,
  alert,
  verifiedBanner,
  searchLinks,
  @Deprecated('Not used anymore.')
  notes,
  personalisedMessage,
  buyButton,
  divider,
  sectionTitle,
  video,
  shareButtons,
  productWebsite
}

enum SearchLinkType { google, reddit, ebay, amazon, youtube }
