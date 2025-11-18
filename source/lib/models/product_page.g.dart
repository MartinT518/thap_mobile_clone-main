// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPagesModel _$ProductPagesModelFromJson(Map<String, dynamic> json) =>
    ProductPagesModel(
      userImages: (json['userImages'] as List<dynamic>)
          .map((e) => CdnImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      productId: json['productId'] as String,
      pages: (json['pages'] as List<dynamic>)
          .map((e) => ProductPageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ProductPageModel _$ProductPageModelFromJson(Map<String, dynamic> json) =>
    ProductPageModel(
      pageId: json['id'] as String,
      title: json['title'] as String,
      components: (json['contents'] as List<dynamic>)
          .map((e) =>
              ProductPageComponentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ProductPageComponentModel _$ProductPageComponentModelFromJson(
        Map<String, dynamic> json) =>
    ProductPageComponentModel(
      type: $enumDecodeNullable(_$ProductPageComponentTypeEnumMap, json['type'],
          unknownValue: JsonKey.nullForUndefinedEnumValue),
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      link: json['link'] == null
          ? null
          : ProductPageComponentLinkModel.fromJson(
              json['link'] as Map<String, dynamic>),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) =>
              ProductPageComponentLinkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rating: json['rating'] == null
          ? null
          : ProductPageComponentRatingModel.fromJson(
              json['rating'] as Map<String, dynamic>),
      cdnImages: (json['cdnImages'] as List<dynamic>?)
          ?.map((e) => CdnImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['content'] as String?,
      contentUrl: json['contentUrl'] as String?,
      contact: json['contact'] == null
          ? null
          : ProductPageComponentContactModel.fromJson(
              json['contact'] as Map<String, dynamic>),
      tableContents: (json['tableContents'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
      searchLinksContent: (json['searchLinksContent'] as List<dynamic>?)
          ?.map(
              (e) => SearchLinkContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      divider: json['divider'] == null
          ? null
          : DividerModel.fromJson(json['divider'] as Map<String, dynamic>),
      video: json['video'] == null
          ? null
          : VideoModel.fromJson(json['video'] as Map<String, dynamic>),
      userCanEdit: json['userCanEdit'] as bool?,
      allowCopy: json['allowCopy'] as bool?,
      canUpload: json['canUpload'] as bool?,
      hidden: json['hidden'] as bool?,
      clamping: json['clamping'] as bool?,
    );

const _$ProductPageComponentTypeEnumMap = {
  ProductPageComponentType.title: 'Title',
  ProductPageComponentType.imageCarusel: 'ImageCarusel',
  ProductPageComponentType.actionButtons: 'ActionButtons',
  ProductPageComponentType.rating: 'Rating',
  ProductPageComponentType.shortcutBand: 'ShortcutBand',
  ProductPageComponentType.message: 'Message',
  ProductPageComponentType.menuItem: 'MenuItem',
  ProductPageComponentType.htmlContent: 'HTMLContent',
  ProductPageComponentType.document: 'Document',
  ProductPageComponentType.actionLink: 'ActionLink',
  ProductPageComponentType.keyValueTable: 'KeyValueTable',
  ProductPageComponentType.addressBlock: 'AddressBlock',
  ProductPageComponentType.items: 'Items',
  ProductPageComponentType.alert: 'Alert',
  ProductPageComponentType.verifiedBanner: 'VerifiedBanner',
  ProductPageComponentType.searchLinks: 'SearchLinks',
  ProductPageComponentType.notes: 'Notes',
  ProductPageComponentType.personalisedMessage: 'PersonalisedMessage',
  ProductPageComponentType.buyButton: 'BuyButton',
  ProductPageComponentType.divider: 'Divider',
  ProductPageComponentType.sectionTitle: 'SectionTitle',
  ProductPageComponentType.video: 'Video',
  ProductPageComponentType.shareButtons: 'ShareButtons',
  ProductPageComponentType.productWebsite: 'ProductWebsite',
};

ProductPageComponentLinkModel _$ProductPageComponentLinkModelFromJson(
        Map<String, dynamic> json) =>
    ProductPageComponentLinkModel(
      icon: json['icon'] as String?,
      title: json['title'] as String?,
      href: json['href'] as String?,
      display: json['display'] as String? ?? 'page',
      color: json['colour'] as String?,
      hidden: json['hidden'] as bool?,
    );

ProductPageComponentRatingModel _$ProductPageComponentRatingModelFromJson(
        Map<String, dynamic> json) =>
    ProductPageComponentRatingModel(
      type: $enumDecodeNullable(
          _$ProductPageComponentRatingTypeEnumMap, json['type'],
          unknownValue: JsonKey.nullForUndefinedEnumValue),
      value: json['value'] as String,
    );

const _$ProductPageComponentRatingTypeEnumMap = {
  ProductPageComponentRatingType.text: 'Text',
  ProductPageComponentRatingType.stars: 'Stars',
};

ProductPageComponentContactModel _$ProductPageComponentContactModelFromJson(
        Map<String, dynamic> json) =>
    ProductPageComponentContactModel(
      website: json['website'] as String,
      email: json['email'] as String,
      location: json['location'] as String,
      phone: json['phone'] as String,
    );

SearchLinkContentModel _$SearchLinkContentModelFromJson(
        Map<String, dynamic> json) =>
    SearchLinkContentModel(
      type: $enumDecodeNullable(_$SearchLinkTypeEnumMap, json['type']),
      query: json['query'] as String,
    );

const _$SearchLinkTypeEnumMap = {
  SearchLinkType.google: 'google',
  SearchLinkType.reddit: 'reddit',
  SearchLinkType.ebay: 'ebay',
  SearchLinkType.amazon: 'amazon',
  SearchLinkType.youtube: 'youtube',
};

DividerModel _$DividerModelFromJson(Map<String, dynamic> json) => DividerModel(
      height: (json['height'] as num).toDouble(),
      color: json['colour'] as String?,
    );

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      previewImage: json['previewImage'] as String?,
      title: json['title'] as String?,
      videoUrl: json['videoUrl'] as String,
    );
