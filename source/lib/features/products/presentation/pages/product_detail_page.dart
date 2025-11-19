import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thap/core/theme/app_theme.dart';
import 'package:thap/features/products/data/providers/products_repository_provider.dart';
import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/products/domain/repositories/products_repository.dart';
import 'package:thap/features/products/presentation/widgets/ask_ai_button_widget.dart';
import 'package:thap/features/wallet/presentation/providers/wallet_provider.dart';
import 'package:thap/shared/widgets/design_system_components.dart';

/// Product detail page
class ProductDetailPage extends ConsumerWidget {
  final String productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productFuture = ref.watch(productProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('product.details')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: productFuture.when(
        data: (product) {
          if (product == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.errorColor,
                  ),
                  const SizedBox(height: AppTheme.spacingL),
                  Text(
                    tr('product.not_found'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                if (product.imageUrl != null)
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.surfaceColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.imageUrl!,
                        fit: BoxFit.cover,
                        // Performance optimization: Limit memory cache size
                        // 300px height * device pixel ratio = ~900px for high-DPI screens
                        cacheWidth: 600, // Limit to 600px width for memory efficiency
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 64,
                          );
                        },
                      ),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.surfaceColor,
                    ),
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 64,
                    ),
                  ),

                const SizedBox(height: AppTheme.spacingXL),

                // Product Name
                Text(
                  product.displayName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: AppTheme.spacingS),

                // Brand
                Text(
                  product.brand,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                ),

                const SizedBox(height: AppTheme.spacingXL),

                // Description
                if (product.description != null && product.description!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('product.description'),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: AppTheme.spacingS),
                      Text(
                        product.description!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppTheme.spacingXL),
                    ],
                  ),

                // Barcode/Code
                if (product.barcode != null || product.code != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('product.code'),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: AppTheme.spacingS),
                      Text(
                        product.barcode ?? product.code ?? '',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontFamily: 'monospace',
                            ),
                      ),
                      const SizedBox(height: AppTheme.spacingXL),
                    ],
                  ),

                // Tags
                if (product.tags.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('product.tags'),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: AppTheme.spacingS),
                      Wrap(
                        spacing: AppTheme.spacingS,
                        runSpacing: AppTheme.spacingS,
                        children: product.tags.map((tag) {
                          return DesignSystemComponents.tagChip(tag: tag);
                        }).toList(),
                      ),
                      const SizedBox(height: AppTheme.spacingXL),
                    ],
                  ),

                // Ask AI button (matches demo script: blue, full width)
                AskAIButtonWidget(
                  product: product,
                  isOwned: product.isOwner,
                ),

                // Add to My Things button
                _buildAddToWalletButton(context, ref, product),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppTheme.errorRed,
              ),
              const SizedBox(height: AppTheme.spacingL),
              Text(
                tr('product.load_error'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppTheme.spacingS),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddToWalletButton(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) {
    final walletNotifier = ref.watch(walletNotifierProvider.notifier);
    final walletState = ref.watch(walletNotifierProvider);
    final isInWallet = walletState.maybeWhen(
      loaded: (products) =>
          products.any((p) => p.product.id == product.id),
      orElse: () => false,
    );

    // Load wallet on first build
    ref.listen(walletNotifierProvider, (previous, next) {
      if (previous is _Initial && next is! _Loading && next is! _Loaded) {
        walletNotifier.loadWalletProducts();
      }
    });

    if (walletState is _Initial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        walletNotifier.loadWalletProducts();
      });
    }

    if (isInWallet) {
      return ElevatedButton.icon(
        onPressed: () async {
          final confirmed = await DesignSystemComponents.showDesignSystemDialog<bool>(
            context: context,
            title: tr('my_tings.remove_confirm_title'),
            content: Text(tr('my_tings.remove_confirm_message')),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(tr('common.cancel')),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(tr('common.remove')),
              ),
            ],
          );

          if (confirmed == true) {
            final walletProduct = walletState.maybeWhen(
              loaded: (products) =>
                  products.firstWhere((p) => p.product.id == product.id),
              orElse: () => null,
            );

            if (walletProduct != null) {
              final success = await walletNotifier.removeProductFromWallet(
                walletProduct.instanceId,
              );
              if (success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(tr('my_tings.remove_message'))),
                );
              }
            }
          }
        },
        icon: const Icon(Icons.remove_circle_outline),
        label: Text(tr('my_tings.remove')),
        style: DesignSystemComponents.primaryButton.copyWith(
          backgroundColor: WidgetStateProperty.all(AppTheme.errorColor),
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: () async {
        final instanceId = await walletNotifier.addProductToWallet(product.id);
        if (instanceId != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(tr('my_tings.add_message'))),
          );
        }
      },
      icon: const Icon(Icons.add_circle_outline),
      label: Text(tr('my_tings.add')),
      style: DesignSystemComponents.primaryButton,
    );
  }
}

/// Provider for fetching a single product
final productProvider = FutureProvider.family<Product?, String>(
  (ref, productId) async {
    final repository = ref.watch(productsRepositoryProvider);
    return await repository.getProduct(productId);
  },
);

