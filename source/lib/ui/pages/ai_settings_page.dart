import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thap/models/ai_provider.dart';
import 'package:thap/services/ai_service.dart';
import 'package:thap/services/ai_settings_service.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/ui/common/app_header_bar.dart';
import 'package:thap/ui/common/button.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/product_menu_item.dart';
import 'package:thap/ui/common/tings_form.dart';
import 'package:thap/ui/common/typography.dart';

class AISettingsPage extends HookWidget {
  const AISettingsPage({super.key});

  Future<Map<AIProvider, bool>> _loadProviderStatus(
      AISettingsService aiSettingsService) async {
    final status = <AIProvider, bool>{};
    for (final provider in AIProvider.values) {
      status[provider] = await aiSettingsService.isProviderConfigured(provider);
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    final aiSettingsService = locator<AISettingsService>();
    final navigationService = locator<NavigationService>();
    final selectedProvider = useState<AIProvider?>(null);
    final isConfigured = useState<bool>(false);

    useEffect(() {
      Future.microtask(() async {
        final provider = await aiSettingsService.getSelectedProvider();
        selectedProvider.value = provider;
        if (provider != null) {
          isConfigured.value =
              await aiSettingsService.isProviderConfigured(provider);
        }
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppHeaderBar(
        showBackButton: true,
        title: 'AI Assistant Settings',
      ),
      body: SafeArea(
        bottom: true,
        child: Container(
          color: TingsColors.grayLight,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Heading4('Choose your preferred AI/LLM'),
              ),
              Expanded(
                child: FutureBuilder<Map<AIProvider, bool>>(
                  future: _loadProviderStatus(aiSettingsService),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    final providerStatus = snapshot.data!;
                    
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      cacheExtent: 500, // Performance: Pre-render items off-screen
                      children: AIProvider.values.map((providerOption) {
                        final isInstalled = providerStatus[providerOption] ?? false;
                        
                        return ProductMenuItem(
                          title: providerOption.displayName,
                          trailing: isInstalled
                              ? const Text(
                                  'Installed',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : null,
                          onTap: () async {
                            await navigationService.push(
                              _AIProviderSetup(provider: providerOption),
                            );
                            // Refresh status after returning
                            final updatedProvider =
                                await aiSettingsService.getSelectedProvider();
                            selectedProvider.value = updatedProvider;
                            if (updatedProvider != null) {
                              isConfigured.value = await aiSettingsService
                                  .isProviderConfigured(updatedProvider);
                            }
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AIProviderSetup extends HookWidget {
  const _AIProviderSetup({required this.provider});

  final AIProvider provider;

  @override
  Widget build(BuildContext context) {
    final aiSettingsService = locator<AISettingsService>();
    final aiService = locator<AIService>();
    final toastService = locator<ToastService>();
    final navigationService = locator<NavigationService>();
    final apiKeyController = useTextEditingController();
    final isValidating = useState(false);
    final existingKey = useState<String?>(null);

    useEffect(() {
      Future.microtask(() async {
        final key = await aiSettingsService.getApiKey(provider);
        if (key != null) {
          existingKey.value = key;
          apiKeyController.text = key;
        }
      });
      return null;
    }, []);

    Future<void> validateAndSave() async {
      if (apiKeyController.text.isEmpty) {
        toastService.error('Please enter an API key');
        return;
      }

      isValidating.value = true;

      try {
        final isValid = await aiService.validateApiKey(
          provider,
          apiKeyController.text,
        );

        if (isValid) {
          await aiSettingsService.setApiKey(provider, apiKeyController.text);
          await aiSettingsService.setSelectedProvider(provider);
          // Show "Assistant ready" success message
          toastService.success('Assistant ready');
          navigationService.pop();
        } else {
          toastService.error('Invalid API key. Please check and try again.');
        }
      } catch (e) {
        toastService.error('Failed to validate API key');
      } finally {
        isValidating.value = false;
      }
    }

    return Scaffold(
      appBar: AppHeaderBar(
        showBackButton: true,
        title: provider.displayName,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Heading4('Enter your API Key'),
              const SizedBox(height: 8),
              ContentBig(
                'Get your API key from the ${provider.displayName} website',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.blue.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ContentBig(
                      '💡 Demo Mode',
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 4),
                    ContentBig(
                      'For testing, enter: demo\n\nThis will use simulated AI responses without requiring a real API key.',
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TingsTextField(
                controller: apiKeyController,
                label: 'API Key',
              ),
              const SizedBox(height: 24),
              if (existingKey.value != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextButton(
                    onPressed: () async {
                      await aiSettingsService.clearApiKey(provider);
                      existingKey.value = null;
                      apiKeyController.clear();
                      toastService.success('API key removed');
                    },
                    child: const Text('Remove API Key'),
                  ),
                ),
              const Spacer(),
              MainButton(
                onTap: isValidating.value ? () {} : validateAndSave,
                text: isValidating.value ? 'Validating...' : 'Confirm',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
