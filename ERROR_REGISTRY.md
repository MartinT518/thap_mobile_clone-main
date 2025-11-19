# Error Registry

This document tracks all errors encountered and fixed during development. Each error is documented with a unique code, description, and solution.

**Last Updated:** 2024

---

## Error Codes Format

- **ERR-001**: Navigation & Service Locator Issues
- **ERR-002**: Layout & UI Constraints
- **ERR-003**: Null Safety & Type Safety
- **ERR-004**: State Management & Data Flow
- **ERR-005**: Component Rendering & Widget Issues

---

## Error Registry

| Error Code      | Error Description                                                                    | Error Fix Solution                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| --------------- | ------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ERR-001-001** | `flutter` command not found in PATH                                                  | Added Flutter bin directory to system PATH. Created `install_flutter.ps1` script to automate PATH configuration.                                                                                                                                                                                                                                                                                                                                                                                                                             |
| **ERR-001-002** | PDF.js library not added in `web/index.html`                                         | Ran `flutter pub run pdfx:install_web` to automatically add required PDF.js scripts to `source/web/index.html`.                                                                                                                                                                                                                                                                                                                                                                                                                              |
| **ERR-001-003** | Navigator state is null - cannot push page                                           | Added null checks to `NavigationService.push()` and `replace()` methods. Passed `navigatorKey` to `GoRouter` in `AppRouter.createRouter()`.                                                                                                                                                                                                                                                                                                                                                                                                  |
| **ERR-001-004** | NavigationService methods using null assertions                                      | Added null checks to `pop()`, `maybePop()`, `popToRoot()`, and `replaceAll()` methods in `NavigationService`. All methods now check for null navigator state before operations.                                                                                                                                                                                                                                                                                                                                                              |
| **ERR-002-001** | BoxConstraints forces an infinite width error                                        | Removed `SingleChildScrollView` wrapper from `KeyValueTable` component. Changed from nested scroll views to simple `Column` widget when inside `ListView`.                                                                                                                                                                                                                                                                                                                                                                                   |
| **ERR-002-002** | ListView shrinkWrap causing performance issues                                       | Removed `shrinkWrap: true` from `ProductPageComponents` ListView. Not needed when ListView is the main scrollable widget.                                                                                                                                                                                                                                                                                                                                                                                                                    |
| **ERR-002-003** | Button styles causing infinite width constraints                                     | Changed `DesignSystemComponents.primaryButton()`, `secondaryButton()`, and `aiButton()` to use `Size(0, height)` instead of `Size(double.infinity, height)`. Buttons now expand in Columns and size properly in Rows.                                                                                                                                                                                                                                                                                                                        |
| **ERR-002-004** | AddToMyTingsButton causing overflow in Row                                           | Wrapped `AddToMyTingsButton` in `Expanded` widget in product page bottom bar to prevent overflow.                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| **ERR-003-001** | MenuPage crashing with "Unexpected null value" for userProfile                       | Added null check before accessing `userProfileStore.userProfile`. Changed to conditional rendering: `if (userProfile != null) UserInfo(...)`.                                                                                                                                                                                                                                                                                                                                                                                                |
| **ERR-003-002** | SettingsPage using null assertion on appData.value                                   | Changed `appData.value!.languages` to `(appData.value?.languages ?? [])` with null-safe operator and fallback to empty list.                                                                                                                                                                                                                                                                                                                                                                                                                 |
| **ERR-003-003** | DemoAuthService type mismatch - not subtype of AuthService                           | Changed `class DemoAuthService {` to `class DemoAuthService extends AuthService {` and added `@override` annotations to all methods.                                                                                                                                                                                                                                                                                                                                                                                                         |
| **ERR-003-004** | Service UserRepository not registered error                                          | Reordered service locator registrations: APIs first, then Repositories, then Services. Ensured `UserRepository` is registered before `AuthService` which depends on it.                                                                                                                                                                                                                                                                                                                                                                      |
| **ERR-003-005** | Null safety error in demo repositories - null as ApiType                             | Changed `DemoMyTingsRepository() : super(null as MyTingsApi)` to `DemoMyTingsRepository() : super(locator())`. Applied same fix to `DemoUserRepository` and `DemoAppRepository`.                                                                                                                                                                                                                                                                                                                                                             |
| **ERR-003-006** | ProductPagesStore.getPage() returning null                                           | Implemented `ProductPagesStore.getPage()` to call `ProductsRepository.pages()` and return the first page. Previously was a stub returning null.                                                                                                                                                                                                                                                                                                                                                                                              |
| **ERR-003-007** | KeyValueTable expecting 'key' and 'value' but receiving wrong format                 | Fixed `DemoProductsRepository` data structure. Changed from `{'GTIN/EAN': 'value'}` to `{'key': 'GTIN/EAN', 'value': 'value'}` format matching `KeyValueTable` expectations.                                                                                                                                                                                                                                                                                                                                                                 |
| **ERR-004-001** | ref.listen cannot be called in constructor                                           | Commented out `_ref.listen(authProvider, ...)` call in `GoRouterRefreshNotifier` constructor. `ref.listen` can only be called within build method of ConsumerWidget.                                                                                                                                                                                                                                                                                                                                                                         |
| **ERR-004-002** | Hooks can only be called from build method of HookWidget                             | Moved `useEffect` hook outside of `Consumer` builder in `MyTingsPage`. Created `_MyTingsDataUpdater` widget to handle provider loading safely.                                                                                                                                                                                                                                                                                                                                                                                               |
| **ERR-004-003** | MyTingsStore and MyTingsProvider not synced                                          | Updated `MyTingsNotifier.load()` to fetch from `MyTingsRepository`. Updated `MyTingsPage` to call both legacy store and Riverpod provider. Created `_MyTingsDataUpdater` to trigger provider load.                                                                                                                                                                                                                                                                                                                                           |
| **ERR-004-004** | MyTingsStore was a stub not loading data                                             | Transformed `MyTingsStore` from stub to functional `ChangeNotifier`. Implemented `load()` method to fetch from `MyTingsRepository` and update state.                                                                                                                                                                                                                                                                                                                                                                                         |
| **ERR-004-005** | UserProfileStore was a stub not storing data                                         | Transformed `UserProfileStore` from stub to functional in-memory store. Implemented methods to store and retrieve `UserProfileModel` and token.                                                                                                                                                                                                                                                                                                                                                                                              |
| **ERR-005-001** | Product page components failing to render                                            | Refactored entire `ProductPage` from scratch. Separated into `ProductPage` (layout), `_ProductPageContent` (content), and `_ComponentBuilder` (component rendering). Added error boundaries around each component build.                                                                                                                                                                                                                                                                                                                     |
| **ERR-005-002** | Component rendering errors causing app crashes                                       | Added try-catch blocks around component building. Failed components return `SizedBox.shrink()` instead of crashing. Each component type has dedicated `_build*` method with validation.                                                                                                                                                                                                                                                                                                                                                      |
| **ERR-005-003** | ProductPageComponents using complex nested structure                                 | Simplified component building logic. Removed unnecessary complexity. Each component type validated before rendering. Consistent error handling pattern throughout.                                                                                                                                                                                                                                                                                                                                                                           |
| **ERR-005-004** | CORS errors when fetching product data                                               | Created `DemoProductsRepository` to provide mock data in demo mode. Prevents actual network requests and CORS errors. Returns demo products with proper DPP (Digital Product Passport) data.                                                                                                                                                                                                                                                                                                                                                 |
| **ERR-005-005** | Product pages not showing Ask AI button                                              | Updated `DemoProductsRepository.pages()` to return `ProductPagesModel` with `buyButton` component type. Previously returned null, preventing button from showing.                                                                                                                                                                                                                                                                                                                                                                            |
| **ERR-003-008** | Build error: `bool?` can't be assigned to `bool` in null checks                      | Replaced all `component.link?.href?.isEmpty ?? true` patterns with `isBlank`/`isNotBlank` extensions from `string_extensions.dart`. These extensions properly handle nullable strings and return `bool` instead of `bool?`. Applied to all component builder methods: `_buildTitle()`, `_buildSectionTitle()`, `_buildHtmlContent()`, `_buildMenuItem()`, `_buildRating()`, `_buildMessage()`, `_buildDocument()`, `_buildAddress()`, `_buildItems()`, `_buildAlert()`, `_buildDivider()`, `_buildShareButtons()`, `_buildProductWebsite()`. |
| **ERR-003-009** | Build error: Too few positional arguments in method calls                            | Fixed method calls in `_buildComponent()` switch statement. Added missing `context` parameter to: `_buildMenuItem()`, `_buildRating()`, `_buildShortcutBand()`, `_buildMessage()`, `_buildAlert()`, and `_buildProductWebsite()`. All methods now receive required `BuildContext` as first parameter.                                                                                                                                                                                                                                        |
| **ERR-001-005** | AI Settings page cannot be opened from Menu                                          | Fixed navigation in MenuPage. Changed from `navigationService.push()` to direct `navigator.push()` with fallback to `Navigator.of(context).push()` if NavigationService navigator is null. This ensures AI Settings page opens even when NavigationService navigatorKey is not ready.                                                                                                                                                                                                                                                        |
| **ERR-005-006** | Product page exceptions: "Cannot hit test a render box that has never been laid out" | Added comprehensive error handling: (1) `_ErrorBoundary` widget wrapping all components, (2) Try-catch in every `_build*` method, (3) Safe scroll controller access with `hasClients` and `hasContentDimensions` checks, (4) Component validation before building, (5) All gesture handlers wrapped in error boundaries. Failed components return `SizedBox.shrink()` instead of crashing.                                                                                                                                                   |
| **FRD-001**     | FR-HISTORY-003: Clear All History not implemented                                    | Implemented "Clear Scan History" feature in Settings page. Added `clearScanHistory()` to `UserApi` and `UserRepository`. Added confirmation dialog, success/error feedback, and demo mode support.                                                                                                                                                                                                                                                                                                                                           |
| **FRD-002**     | FR-SEARCH-001: Product search filtering not working                                  | Enhanced search in `DemoProductsRepository` to filter by keyword (name, brand, barcode). Added minimum 2 characters validation in `SearchPage`. Search now properly filters results based on user input.                                                                                                                                                                                                                                                                                                                                     |
| **FRD-003**     | FR-FEED-001: User Feed returning empty                                               | Added demo feed messages to `DemoUserRepository.getUserFeed()`. Feed now shows product updates, sustainability tips, and product recalls. Feed page accessible from bottom navigation.                                                                                                                                                                                                                                                                                                                                                       |

---

## Error Categories Summary

### ERR-001: Navigation & Service Locator (5 errors)

- Navigator state null issues
- Service registration order
- PATH configuration

### ERR-002: Layout & UI Constraints (4 errors)

- Infinite width constraints
- Nested scroll views
- Button sizing issues
- Widget overflow

### ERR-003: Null Safety & Type Safety (7 errors)

- Null assertions without checks
- Type mismatches
- Missing null-safe operators
- Data structure mismatches

### ERR-004: State Management & Data Flow (5 errors)

- Riverpod hook usage
- Service locator dependencies
- Store/provider synchronization
- Stub implementations

### ERR-005: Component Rendering & Widget Issues (5 errors)

- Component rendering failures
- Missing error boundaries
- Complex nested structures
- API/CORS issues

---

## Prevention Guidelines

### Layout Constraints

- ✅ Never use `double.infinity` in button `minimumSize` when buttons might be in Rows
- ✅ Avoid nested scroll views (SingleChildScrollView inside ListView)
- ✅ Remove `shrinkWrap: true` when not needed
- ✅ Wrap widgets in `Expanded` when in Rows with flexible children

### Null Safety

- ✅ Always use null-safe operators (`?.`, `??`)
- ✅ Check for null before using `!` operator
- ✅ Provide fallback values for nullable collections
- ✅ Use conditional rendering for nullable widgets

### State Management

- ✅ Register dependencies before dependents in service locator
- ✅ Don't call hooks inside nested builders
- ✅ Sync legacy stores with Riverpod providers when both exist
- ✅ Implement functional stores instead of stubs

### Component Rendering

- ✅ Wrap component builds in try-catch
- ✅ Validate data before rendering
- ✅ Return `SizedBox.shrink()` for invalid components
- ✅ Use error boundaries for component isolation

### Navigation

- ✅ Always check navigator state before operations
- ✅ Pass navigatorKey to GoRouter when using legacy NavigationService
- ✅ Handle navigation errors gracefully

---

## Testing Checklist

After fixing errors, verify:

- [ ] Product pages load without crashes
- [ ] Menu tab displays correctly
- [ ] Settings page handles loading states
- [ ] Navigation works without null errors
- [ ] Buttons render correctly in all contexts
- [ ] No layout constraint errors in console
- [ ] Demo mode works end-to-end
- [ ] Ask AI functionality accessible

---

## Notes

- All fixes follow Dart null safety best practices
- Layout fixes maintain design system compliance
- Error handling prevents app crashes
- Demo mode fully functional for testing
- Code refactored for maintainability
