import 'package:flutter/material.dart';
import 'package:thap/core/theme/app_theme.dart';

/// Design System Components following v2.0 specifications
class DesignSystemComponents {
  DesignSystemComponents._();

  /// Primary Button following Design System specification (Section 5.1)
  /// Background: Primary Blue 500 (#2196F3)
  /// Text: White
  /// Height: 48px (minimum tap target)
  /// Border Radius: 24px (pill)
  /// Font: Label Large (14px, Weight 500)
  /// Elevation: 2dp
  /// States: Default (Blue 500), Hover (Blue 700), Pressed (Blue 700 + 4dp), Disabled (Gray 300 bg, Gray 500 text)
  static ButtonStyle primaryButton({
    Color? backgroundColor,
    Color? foregroundColor,
    bool? isDisabled,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? AppTheme.primaryBlue500,
      foregroundColor: foregroundColor ?? Colors.white,
      minimumSize: const Size(0, 48), // Design System: 48px height, width flexible
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM), // 16px
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusPill), // 24px
      ),
      elevation: 2, // Design System: 2dp
      disabledBackgroundColor: AppTheme.gray300, // Design System: Disabled state
      disabledForegroundColor: AppTheme.gray500, // Design System: Disabled text
    );
  }

  /// Secondary Button following Design System specification
  /// Background: Transparent
  /// Text: Primary Blue 500
  /// Border: 2px solid Primary Blue 500
  /// Height: 48px
  /// Border Radius: 24px
  static ButtonStyle secondaryButton({
    Color? borderColor,
    Color? textColor,
  }) {
    return OutlinedButton.styleFrom(
      foregroundColor: textColor ?? AppTheme.primaryBlue500,
      minimumSize: const Size(0, 48), // Width flexible, 48px height
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      side: BorderSide(
        width: 2,
        color: borderColor ?? AppTheme.primaryBlue500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
      ),
      elevation: 0,
    );
  }

  /// Text Button following Design System specification
  /// Background: Transparent
  /// Text: Primary Blue 500
  /// Height: 40px
  /// Border Radius: 8px
  static ButtonStyle textButton({
    Color? textColor,
  }) {
    return TextButton.styleFrom(
      foregroundColor: textColor ?? AppTheme.primaryBlue500,
      minimumSize: const Size(0, 40),
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingXS),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
      ),
    );
  }

  /// AI Button following Design System specification
  /// Background: Primary Blue 500
  /// Text: White
  /// Height: 56px
  /// Width: 100%
  /// Border Radius: 28px
  /// Elevation: 3dp
  /// Font: Title Medium (16px, Weight 500)
  static ButtonStyle aiButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.primaryBlue500,
      foregroundColor: Colors.white,
      minimumSize: const Size(0, 56), // Design System: 56px height, width flexible
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusXXL), // 28px
      ),
      elevation: 3, // Design System: 3dp
    );
  }

  /// Standard Card following Design System specification
  /// Background: White
  /// Border Radius: 16px
  /// Elevation: 1dp
  /// Padding: 16px
  /// Margin: 16px (between cards)
  static Widget card({
    required Widget child,
    EdgeInsets? margin,
    EdgeInsets? padding,
    VoidCallback? onTap,
  }) {
    final card = Card(
      elevation: 1, // Design System: 1dp
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusL), // 16px
      ),
      margin: margin ?? const EdgeInsets.all(AppTheme.spacingM), // 16px
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppTheme.spacingM), // 16px
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        child: card,
      );
    }

    return card;
  }

  /// Product Card (Grid) following Design System specification
  /// Aspect Ratio: 1:1.2 (portrait)
  /// Background: White
  /// Border Radius: 12px
  /// Elevation: 1dp
  /// Padding: 12px
  /// Image: 80% width, rounded 8px
  /// Title: Body Medium, 2 lines max
  /// Brand: Body Small, Gray 700, 1 line
  static Widget productCardGrid({
    required String? imageUrl,
    required String title,
    required String brand,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Design System: 12px
      ),
      margin: const EdgeInsets.all(AppTheme.spacingM),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 1 / 1.2, // Design System: 1:1.2
          child: Padding(
            padding: const EdgeInsets.all(12), // Design System: 12px
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image - 80% width, rounded 8px
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), // Design System: 8px
                      color: AppTheme.surfaceColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              // Performance optimization: Limit memory cache
                              cacheWidth: 600, // Grid items don't need full resolution
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.image_not_supported,
                                  size: 48,
                                );
                              },
                            )
                          : const Icon(
                              Icons.image_not_supported,
                              size: 48,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingS),
                // Title: Body Medium, 2 lines max
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14, // Body Medium
                    fontWeight: FontWeight.w400,
                    color: AppTheme.gray900,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Brand: Body Small, Gray 700, 1 line
                Text(
                  brand,
                  style: const TextStyle(
                    fontSize: 12, // Body Small
                    fontWeight: FontWeight.w400,
                    color: AppTheme.gray700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Product Card (List) following Design System specification
  /// Height: 88px
  /// Background: White
  /// Border Radius: 12px
  /// Padding: 12px
  /// Layout: Horizontal (Image left, text right)
  /// Image: 64x64px, rounded 8px
  /// Title: Body Large, 1 line
  /// Brand: Body Small, Gray 700
  static Widget productCardList({
    required String? imageUrl,
    required String title,
    required String brand,
    List<String>? tags,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Design System: 12px
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 88, // Design System: 88px
          child: Padding(
            padding: const EdgeInsets.all(12), // Design System: 12px
            child: Row(
              children: [
                // Image: 64x64px, rounded 8px
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppTheme.surfaceColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: imageUrl != null
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            // Performance optimization: 64x64px list items
                            cacheWidth: 128, // 64px * 2 for high-DPI
                            cacheHeight: 128,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image_not_supported,
                                size: 32,
                              );
                            },
                          )
                        : const Icon(
                            Icons.image_not_supported,
                            size: 32,
                          ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title: Body Large, 1 line
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16, // Body Large
                          fontWeight: FontWeight.w400,
                          color: AppTheme.gray900,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Brand: Body Small, Gray 700
                      Text(
                        brand,
                        style: const TextStyle(
                          fontSize: 12, // Body Small
                          fontWeight: FontWeight.w400,
                          color: AppTheme.gray700,
                        ),
                      ),
                      // Tags: Chips (below brand, if present)
                      if (tags != null && tags.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          children: tags.take(2).map((tag) {
                            return tagChip(tag: tag);
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                // Chevron: 24x24px (trailing)
                const Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: AppTheme.gray700,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Search Input following Design System specification
  /// Height: 48px
  /// Background: Gray 100
  /// Border Radius: 24px (pill)
  /// Padding: 16px horizontal
  /// Icon: Search icon (leading)
  /// Clear: X icon (trailing, when filled)
  /// Font: Body Medium
  /// Placeholder: Gray 500
  static Widget searchInput({
    required TextEditingController controller,
    required String hintText,
    ValueChanged<String>? onChanged,
    VoidCallback? onClear,
  }) {
    return Container(
      height: 48, // Design System: 48px
      decoration: BoxDecoration(
        color: AppTheme.gray100, // Design System: Gray 100
        borderRadius: BorderRadius.circular(24), // Design System: 24px (pill)
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 14, // Body Medium
          fontWeight: FontWeight.w400,
          color: AppTheme.gray900,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppTheme.gray500, // Design System: Gray 500
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppTheme.gray700,
            size: 24,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: AppTheme.gray700,
                    size: 20,
                  ),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM, // 16px
            vertical: AppTheme.spacingM,
          ),
        ),
      ),
    );
  }

  /// Tag Chip (Product Organization) following Design System specification
  /// Height: 28px
  /// Background: Gray 200
  /// Border Radius: 14px
  /// Padding: 10px horizontal
  /// Font: Label Small (11px)
  /// Text Color: Gray 900
  static Widget tagChip({
    required String tag,
    bool selected = false,
    VoidCallback? onDelete,
  }) {
    return Container(
      height: 28, // Design System: 28px
      padding: const EdgeInsets.symmetric(horizontal: 10), // Design System: 10px
      decoration: BoxDecoration(
        color: selected
            ? AppTheme.primaryBlue500 // Selected: Primary Blue 500
            : AppTheme.gray200, // Default: Gray 200
        borderRadius: BorderRadius.circular(14), // Design System: 14px
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: TextStyle(
              fontSize: 11, // Label Small
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : AppTheme.gray900,
            ),
          ),
          if (onDelete != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.close,
                size: 16,
                color: selected ? Colors.white : AppTheme.gray700,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Standard Chip following Design System specification
  /// Height: 32px
  /// Background: Primary Blue 50
  /// Border Radius: 16px
  /// Padding: 12px horizontal
  /// Font: Label Medium (12px)
  /// Text Color: Primary Blue 700
  static Widget standardChip({
    required String label,
    Widget? icon,
  }) {
    return Container(
      height: 32, // Design System: 32px
      padding: const EdgeInsets.symmetric(horizontal: 12), // Design System: 12px
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue50, // Design System: Primary Blue 50
        borderRadius: BorderRadius.circular(16), // Design System: 16px
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            SizedBox(width: 16, height: 16, child: icon),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 12, // Label Medium
              fontWeight: FontWeight.w500,
              color: AppTheme.primaryBlue700, // Design System: Primary Blue 700
            ),
          ),
        ],
      ),
    );
  }

  /// Design System compliant Dialog
  /// Width: Screen width - 32px margin
  /// Max Width: 560px
  /// Background: White
  /// Border Radius: 28px
  /// Padding: 24px
  /// Title: Headline Small (24px)
  /// Content: Body Medium
  /// Actions: Right-aligned, horizontal buttons
  /// Elevation: 24dp
  static Future<T?> showDesignSystemDialog<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28), // Design System: 28px
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall, // 24px
        ),
        content: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!, // Body Medium
          child: content,
        ),
        actions: actions,
        actionsAlignment: MainAxisAlignment.end, // Right-aligned
      ),
    );
  }

  /// Design System compliant Bottom Sheet
  /// Background: White
  /// Border Radius: 28px (top corners only)
  /// Max Height: 90% screen height
  /// Padding: 24px (top), 16px (sides)
  /// Handle: 32px width, 4px height, Gray 300
  /// Elevation: 16dp
  static Future<T?> showDesignSystemBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    String? title,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9, // 90% screen height
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28), // Design System: 28px
            topRight: Radius.circular(28),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle: 32px width, 4px height, Gray 300
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.gray300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16, // Design System: 16px sides
                  24, // Design System: 24px top
                  16,
                  16,
                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16), // Design System: 16px sides
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

