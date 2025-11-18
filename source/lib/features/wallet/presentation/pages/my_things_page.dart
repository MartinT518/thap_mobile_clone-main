import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thap/core/theme/app_theme.dart';
import 'package:thap/features/products/presentation/pages/product_detail_page.dart';
import 'package:thap/features/wallet/presentation/providers/wallet_provider.dart';
import 'package:thap/shared/widgets/design_system_components.dart';

/// My Things page - displays all products in wallet
class MyThingsPage extends ConsumerStatefulWidget {
  const MyThingsPage({super.key});

  @override
  ConsumerState<MyThingsPage> createState() => _MyThingsPageState();
}

class _MyThingsPageState extends ConsumerState<MyThingsPage> {
  @override
  void initState() {
    super.initState();
    // Load wallet products on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(walletNotifierProvider.notifier).loadWalletProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('my_tings.title')),
      ),
      body: walletState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (products) {
          if (products.isEmpty) {
            return _buildEmptyState(context);
          }
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(walletNotifierProvider.notifier).loadWalletProducts();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppTheme.spacingM,
                mainAxisSpacing: AppTheme.spacingM,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final walletProduct = products[index];
                return _buildProductCard(context, walletProduct);
              },
            ),
          );
        },
        error: (message) => Center(
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
                tr('my_tings.load_error'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppTheme.spacingM),
              ElevatedButton(
                onPressed: () {
                  ref.read(walletNotifierProvider.notifier).loadWalletProducts();
                },
                child: Text(tr('common.retry')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(height: AppTheme.spacingXL),
            Text(
              tr('my_tings.empty_title'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingM),
            Text(
              tr('my_tings.empty_message'),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, walletProduct) {
    final product = walletProduct.product;

    return DesignSystemComponents.productCardGrid(
      imageUrl: product.imageUrl,
      title: walletProduct.displayName,
      brand: product.brand,
      onTap: () {
        context.push('/product/${product.id}');
      },
    );
  }
}

