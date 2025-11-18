import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/models/cdn_image.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/product_note.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/deletable.dart';
import 'package:thap/ui/common/image_carousel.dart';
import 'package:thap/ui/common/pdf_viewer.dart';
import 'package:thap/ui/common/product_menu_item.dart';
import 'package:thap/ui/common/ting_divider.dart';
import 'package:thap/ui/common/tings_bottom_sheet.dart';
import 'package:thap/ui/pages/product/add_product_image.dart';
import 'package:thap/utilities/debouncer.dart';

class ProductNotePage extends HookWidget {
  ProductNotePage({super.key, required this.product});

  final ProductItem product;

  final _debouncer = Debouncer(delay: const Duration(seconds: 10));

  @override
  Widget build(BuildContext context) {
    final myTingsRepository = locator<MyTingsRepository>();
    final navigationService = locator<NavigationService>();

    final loading = useState<bool>(true);
    final note = useState<ProductNoteModel?>(null);
    final images = useState<List<CdnImage>>([]);
    final attachmentUrls = useState<List<String>>([]);
    final contentController = useTextEditingController();

    useEffect(() {
      return _debouncer.dispose;
    }, const []);

    useEffect(() {
      Future.microtask(() async {
        final existingNote = await myTingsRepository.getNote(
          product.instanceId!,
        );

        if (existingNote != null) {
          note.value = existingNote;
          contentController.text = existingNote.content ?? '';
          attachmentUrls.value = existingNote.attachments;
        }
        loading.value = false;
      });
      Future.microtask(
        () async =>
            images.value = await myTingsRepository.getImages(
              product.instanceId!,
            ),
      );
      return null;
    }, [key]);

    return WillPopScope(
      onWillPop: () async {
        if (contentController.text != note.value?.content) {
          _saveNote(product.instanceId!, contentController.text);
        }

        return true;
      },
      child: Scaffold(
        appBar: AppHeaderBar(
          showBackButton: true,
          title: product.displayName,
          subTitle: tr('pages.your_notes_photos'),
        ),
        body:
            loading.value
                ? const Center(child: CircularProgressIndicator())
                : Container(
                  color: TingsColors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Expanded(
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                            color: TingsColors.black,
                            fontSize: 14,
                          ),
                          maxLines: null,
                          maxLength: 10000,
                          expands: true,
                          controller: contentController,
                          onChanged:
                              (String text) => _debouncer(
                                () => _saveNote(product.instanceId!, text),
                              ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                            hintText: tr('product.note.hint'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        bottomNavigationBar: SafeArea(
          bottom: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (images.value.isNotEmpty) ...[
                const TingDivider(height: 2),
                ImageCarousel(
                  small: true,
                  cdnImages: images.value,
                  deletableProductImages: images.value,
                  product: product,
                ),
              ],
              if (attachmentUrls.value.isNotEmpty) ...[
                const TingDivider(height: 2),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: SingleChildScrollView(
                    physics:
                        attachmentUrls.value.length > 3
                            ? const BouncingScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ...attachmentUrls.value.map((attachmentUrl) {
                          final isLast =
                              attachmentUrls.value.last == attachmentUrl;
                          final attachmentName = attachmentUrl.split('/').last;
                          return Deletable(
                            onDeleted: () async {
                              await myTingsRepository.removeNoteAttachment(
                                product.instanceId!,
                                attachmentUrl,
                              );
                              attachmentUrls.value =
                                  attachmentUrls.value
                                      .where((a) => a != attachmentUrl)
                                      .toList();
                            },
                            itemId: attachmentUrl,
                            child: ProductMenuItem(
                              title: attachmentName,
                              iconName: 'general_file-attachment',
                              dividerTop: false,
                              dividerBottom: !isLast,
                              onTap: () async {
                                if (attachmentName.endsWith('.pdf')) {
                                  navigationService.push(
                                    PdfViewer(url: attachmentUrl),
                                  );
                                } else {
                                  await locator<OpenerService>()
                                      .openExternalBrowser(attachmentUrl);
                                }
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
              const TingDivider(height: 2),
              Container(
                height: 64,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    _addPhotoButton(context, (imageUrl) {
                      images.value = [...images.value, imageUrl];
                      navigationService.pop();
                    }),
                    const SizedBox(width: 6),
                    _addAttachmentButton(product.instanceId!, (attachmentUrl) {
                      attachmentUrls.value = [
                        ...attachmentUrls.value,
                        attachmentUrl,
                      ];
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addPhotoButton(BuildContext context, Function(CdnImage) onAddImage) {
    return MiniButton(
      onTap:
          () async => {
            await showTingsBottomSheet(
              context: context,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: AddProductImage(
                  product: product,
                  showAddButton: false,
                  onAddImage: onAddImage,
                ),
              ),
            ),
          },
      text: tr('product.image.add_photo'),
    );
  }
}

Widget _addAttachmentButton(
  String productInstanceId,
  Function(String) onAddAttachment,
) {
  final myTingsRepository = locator<MyTingsRepository>();
  final toastService = locator<ToastService>();

  return MiniButton(
    text: tr('product.note.attachment_add'),
    onTap: () async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'doc',
          'docx',
          'odt',
          'pdf',
          'xls',
          'xlsx',
          'ods',
          'ppt',
          'pptx',
          'txt',
        ],
      );

      if (result != null) {
        final attachmentUrl = await myTingsRepository.addNoteAttachment(
          productInstanceId,
          result.files.single.path!,
          result.files.single.name,
        );

        if (attachmentUrl == null) {
          toastService.error(tr('product.note.attachment_upload_error'));
        } else {
          onAddAttachment(attachmentUrl);
          toastService.success(tr('product.note.attachment_added_message'));
        }
      }
    },
  );
}

Future<void> _saveNote(String productInstanceId, String? content) async {
  final myTingsRepository = locator<MyTingsRepository>();
  await myTingsRepository.saveNote(productInstanceId, content);
}
