# Complete Implementation Roadmap
## Thap Mobile Application - Full Requirements Coverage

**Version:** 2.0  
**Date:** December 2024  
**Goal:** 100% coverage of all PRD, User Stories, Functional Requirements, Use Cases, and Process Flows

---

## Current Status

### Coverage Summary
- **P0 Requirements:** 100% ✅ (6/6)
- **P1 Requirements:** 100% ✅ (10/10)
- **P2 Requirements:** 33% ⚪ (2/6)
- **Overall:** 81% ✅

### Missing Features (P2)
1. Product Tags & Filtering (US-009, FR-WALLET-004, UC-PRODUCT-005)
2. Product Documentation (US-010, US-021, US-022, FR-WALLET-005)
3. Privacy Settings (US-018, FR-SETTINGS-003, UC-ADMIN-001)
4. Onboarding Guide (US-003)

### Architecture Migration Needed
1. Search page → Riverpod
2. Feed page → Riverpod
3. AI pages → Riverpod
4. Complete GoRouter migration

---

## Implementation Plan

### Phase 1: Product Tags & Filtering ⚠️ IN PROGRESS

**User Stories:** US-009  
**Functional Requirements:** FR-WALLET-004  
**Use Cases:** UC-PRODUCT-005  
**Process Flow:** Product Lifecycle Flow (Organize phase)

**Tasks:**
1. ✅ Create Tags domain entities
2. ✅ Create Tags repository interface
3. ✅ Create Tags data models
4. ✅ Create Tags remote datasource
5. ✅ Implement Tags repository (API + Demo)
6. ✅ Create Tags providers
7. ✅ Create Tags presentation provider
8. ✅ Create Tags UI components
9. ✅ Integrate tag filtering in My Things page
10. ✅ Add tag management UI

**API Endpoints:**
- `GET /v2/tags` - Get all user tags
- `POST /v2/tag/add` - Create new tag
- `PUT /v2/tag/{tagId}` - Rename tag
- `DELETE /v2/tag/{tagId}` - Delete tag
- `POST /v2/tings/{instanceId}/set_tag/{tagId}` - Add tag to product
- `DELETE /v2/tings/{instanceId}/remove_tag/{tagId}` - Remove tag from product

**Files to Create:**
- `features/tags/domain/entities/tag.dart`
- `features/tags/domain/repositories/tags_repository.dart`
- `features/tags/data/models/tag_model.dart`
- `features/tags/data/datasources/tags_remote_datasource.dart`
- `features/tags/data/repositories/tags_repository_impl.dart`
- `features/tags/data/repositories/tags_repository_demo.dart`
- `features/tags/data/providers/tags_repository_provider.dart`
- `features/tags/presentation/providers/tags_provider.dart`
- `features/tags/presentation/widgets/tag_chip_widget.dart`
- `features/tags/presentation/widgets/tag_filter_bar.dart`
- `features/tags/presentation/pages/tags_management_page.dart`

---

### Phase 2: Product Documentation

**User Stories:** US-010, US-021, US-022  
**Functional Requirements:** FR-WALLET-005  
**Process Flow:** Product Lifecycle Flow (Document phase)

**Tasks:**
1. Create Documentation domain entities
2. Create Documentation repository interface
3. Create Documentation data models
4. Create Documentation remote datasource
5. Implement Documentation repository (API + Demo)
6. Create Documentation providers
7. Create Documentation presentation provider
8. Create Receipt upload UI
9. Create Photos upload UI
10. Create Notes editor UI
11. Integrate documentation in Product Detail page

**API Endpoints:**
- `POST /v2/tings/{instanceId}/receipt` - Upload receipt
- `DELETE /v2/tings/{instanceId}/receipt` - Delete receipt
- `POST /v2/tings/{instanceId}/upload_image` - Upload product photo
- `DELETE /v2/tings/{instanceId}/remove_image` - Delete product photo
- `GET /v2/tings/{instanceId}/images` - Get all product images
- `GET /v2/tings/{instanceId}/note` - Get product note
- `POST /v2/tings/{instanceId}/note` - Save product note
- `POST /v2/tings/{instanceId}/note/attachment` - Add note attachment
- `DELETE /v2/tings/{instanceId}/note/attachment` - Remove note attachment

**Files to Create:**
- `features/documentation/domain/entities/product_documentation.dart`
- `features/documentation/domain/repositories/documentation_repository.dart`
- `features/documentation/data/models/documentation_model.dart`
- `features/documentation/data/datasources/documentation_remote_datasource.dart`
- `features/documentation/data/repositories/documentation_repository_impl.dart`
- `features/documentation/data/repositories/documentation_repository_demo.dart`
- `features/documentation/data/providers/documentation_repository_provider.dart`
- `features/documentation/presentation/providers/documentation_provider.dart`
- `features/documentation/presentation/widgets/receipt_upload_widget.dart`
- `features/documentation/presentation/widgets/photos_gallery_widget.dart`
- `features/documentation/presentation/widgets/notes_editor_widget.dart`
- `features/documentation/presentation/pages/documentation_page.dart`

---

### Phase 3: Privacy Settings

**User Stories:** US-018  
**Functional Requirements:** FR-SETTINGS-003  
**Use Cases:** UC-ADMIN-001

**Tasks:**
1. Extend Settings entity with privacy fields
2. Update Settings repository with privacy methods
3. Create Privacy Settings UI
4. Implement data deletion flow
5. Add confirmation dialogs

**API Endpoints:**
- `PATCH /v2/user/profile` - Update privacy settings
- `DELETE /v2/user/delete` - Delete all user data (if exists)

**Files to Update:**
- `features/settings/domain/entities/settings.dart`
- `features/settings/domain/repositories/settings_repository.dart`
- `features/settings/data/repositories/settings_repository_impl.dart`
- `features/settings/presentation/pages/settings_page.dart` (new UI)

---

### Phase 4: Onboarding Guide

**User Stories:** US-003

**Tasks:**
1. Create Onboarding domain entities
2. Create Onboarding presentation pages
3. Create Onboarding flow navigation
4. Add skip functionality
5. Track onboarding completion

**Files to Create:**
- `features/onboarding/presentation/pages/onboarding_page.dart`
- `features/onboarding/presentation/widgets/onboarding_slide.dart`
- `features/onboarding/presentation/providers/onboarding_provider.dart`

---

### Phase 5: Architecture Migration

**Tasks:**
1. Migrate Search page to Riverpod
2. Migrate Feed page to Riverpod
3. Migrate AI pages to Riverpod
4. Complete GoRouter migration
5. Remove old navigation service
6. Remove MobX dependencies

**Files to Migrate:**
- `ui/pages/search_page.dart` → `features/search/presentation/pages/search_page.dart`
- `ui/pages/feed_page.dart` → `features/feed/presentation/pages/feed_page.dart`
- `ui/pages/ai_settings_page.dart` → `features/ai_assistant/presentation/pages/ai_settings_page.dart`
- `ui/pages/ai_question_selection_page.dart` → `features/ai_assistant/presentation/pages/ai_question_selection_page.dart`
- `ui/pages/ai_chat_page.dart` → `features/ai_assistant/presentation/pages/ai_chat_page.dart`

---

## Implementation Priority

### Sprint 1 (Current)
1. ✅ Product Tags & Filtering (Phase 1)
2. ⚪ Architecture Migration - Search (Phase 5.1)

### Sprint 2
1. Product Documentation (Phase 2)
2. Architecture Migration - Feed (Phase 5.2)

### Sprint 3
1. Privacy Settings (Phase 3)
2. Architecture Migration - AI Pages (Phase 5.3)

### Sprint 4
1. Onboarding Guide (Phase 4)
2. Complete GoRouter Migration (Phase 5.4-5.6)

---

## Success Criteria

### Phase 1: Tags
- ✅ Users can create custom tags
- ✅ Users can assign tags to products
- ✅ Users can filter products by tags
- ✅ Tag management UI functional

### Phase 2: Documentation
- ✅ Users can upload receipts (PDF/image)
- ✅ Users can upload product photos (max 10)
- ✅ Users can add/edit notes
- ✅ All documentation viewable in product detail

### Phase 3: Privacy
- ✅ Users can toggle marketing consent
- ✅ Users can toggle analytics consent
- ✅ Users can delete all data (with confirmation)

### Phase 4: Onboarding
- ✅ First-time users see onboarding
- ✅ Users can skip onboarding
- ✅ Onboarding shown only once

### Phase 5: Architecture
- ✅ All pages use Riverpod
- ✅ All navigation uses GoRouter
- ✅ No MobX dependencies
- ✅ Clean Architecture throughout

---

## Testing Requirements

Each phase requires:
- Unit tests for domain logic
- Integration tests for API calls
- Widget tests for UI components
- E2E tests for user flows

---

## Documentation Updates

After each phase:
1. Update `REQUIREMENTS_VALIDATION.md`
2. Update `REGENERATION_PROGRESS.md`
3. Update `Requirements_Traceability_Matrix.md`
4. Update API contract validation

---

**Last Updated:** December 2024  
**Status:** Phase 1 In Progress  
**Target Completion:** Sprint 4

