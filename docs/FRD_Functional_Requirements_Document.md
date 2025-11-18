# Functional Requirements Document (FRD)
## Thap Mobile Application

**Version:** 2.0  
**Date:** November 18, 2025  
**Related:** PRD_Product_Requirements_Document.md

---

## Table of Contents
1. [Authentication & User Management](#authentication--user-management)
2. [Product Scanning & Recognition](#product-scanning--recognition)
3. [Product Wallet Management](#product-wallet-management)
4. [Scan History](#scan-history)
5. [AI Assistant](#ai-assistant)
6. [Product Information Display](#product-information-display)
7. [Settings & Preferences](#settings--preferences)
8. [Search & Discovery](#search--discovery)

---

## 1. Authentication & User Management

### FR-AUTH-001: Google OAuth Sign-In
**Priority:** P0  
**Description:** Users must authenticate using Google OAuth 2.0

**Functional Behavior:**
- GIVEN a user is on the login screen
- WHEN they tap "Sign in with Google"
- THEN the Google OAuth flow is initiated
- AND upon successful authentication, user is redirected to HomePage
- AND user session is persisted locally

**Business Rules:**
- Only Google email addresses are accepted
- Session expires after 30 days of inactivity
- Users can only have one account per email

**Data Elements:**
- User email (string, required)
- User name (string, required)
- User photo URL (string, optional)
- Authentication method (enum: google, facebook)
- Authentication token (string, encrypted)

**Error Conditions:**
- OAuth cancelled by user → Show "Login cancelled" toast
- OAuth fails → Show "Login failed, please try again" toast
- Network error → Show "Network error, check connection" toast

---

### FR-AUTH-002: Session Restoration
**Priority:** P0  
**Description:** App must restore user session on app launch

**Functional Behavior:**
- GIVEN app is launched
- WHEN a valid session token exists
- THEN user is automatically logged in
- AND navigated to HomePage
- ELSE user is shown LoginPage

**Business Rules:**
- Session restoration happens silently (no loading screen > 500ms)
- Invalid/expired tokens are cleared
- User is prompted to re-authenticate on token expiry

---

### FR-AUTH-003: User Profile Management
**Priority:** P1  
**Description:** Users can view and update their profile settings

**Functional Behavior:**
- Users can change language preference (14 languages supported)
- Users can change country preference
- Users can view their email and name
- Changes sync to backend immediately

**Data Elements:**
- Language code (ISO 639-1, 2 characters)
- Country code (ISO 3166-1, 2 characters)
- Postal code (string, optional)
- Marketing consent (boolean)
- Feedback consent (boolean)

---

### FR-AUTH-004: Sign Out
**Priority:** P0  
**Description:** Users can sign out of the application

**Functional Behavior:**
- GIVEN user is authenticated
- WHEN they tap "Sign Out" in menu
- THEN local session is cleared
- AND user is redirected to LoginPage
- AND Google OAuth session is disconnected

---

## 2. Product Scanning & Recognition

### FR-SCAN-001: QR Code Scanning
**Priority:** P0  
**Description:** Users can scan QR codes to identify products

**Functional Behavior:**
- GIVEN user taps QR scanner button
- WHEN camera permission is granted
- THEN camera view is displayed
- AND QR codes in view are automatically detected
- AND product information is fetched from backend
- AND user is navigated to ProductDetailPage

**Business Rules:**
- Only QR codes are supported (no barcodes or other formats)
- Camera permission must be granted (required)
- One QR code processed at a time
- Duplicate scans within 5 seconds are ignored

**Data Elements:**
- Product ID (string, extracted from QR code)
- Barcode/EAN (string, from product data)
- Scan timestamp (datetime)

**Error Conditions:**
- Camera permission denied → Show permission explanation dialog
- QR code not recognized → Show "Invalid QR code" toast
- Product not found → Show "Product not found" error page
- Network error → Show "Connection error" toast

---

### FR-SCAN-002: Scan History Tracking
**Priority:** P1  
**Description:** All scanned products are saved to scan history

**Functional Behavior:**
- GIVEN user scans a product
- WHEN product is not owned (isOwner = false)
- THEN product is added to scan history
- AND displayed in "Scan History" section on HomePage

**Business Rules:**
- Scan history is chronological (newest first)
- Duplicate products create new history entries
- History persists across sessions
- Maximum 100 items in scan history (oldest auto-deleted)

**Data Elements:**
- Product ID (string)
- Scan timestamp (datetime)
- Product name (string)
- Product brand (string)
- Product image URL (string)
- Is owner flag (boolean, always false for history)

---

## 3. Product Wallet Management

### FR-WALLET-001: Add Product to Wallet
**Priority:** P0  
**Description:** Users can add scanned products to their digital wallet

**Functional Behavior:**
- GIVEN user is viewing a product detail page
- WHEN they tap "Add to My Things"
- THEN product is added to wallet
- AND product instance is created on backend
- AND product appears in "My Things" section
- AND isOwner flag is set to true

**Business Rules:**
- Same product can be added multiple times (multiple instances)
- Each instance has unique instance ID
- Products in wallet persist across sessions
- Wallet has no size limit

**Data Elements:**
- Product instance ID (string, UUID)
- Product ID (string, reference to product)
- Ownership status (boolean, isOwner)
- Date added (datetime)
- Custom nickname (string, optional)
- Custom tags (array of strings)

---

### FR-WALLET-002: Remove Product from Wallet
**Priority:** P0  
**Description:** Users can remove products from their wallet

**Functional Behavior:**
- GIVEN user is viewing owned product
- WHEN they tap "Remove from My Things"
- THEN confirmation dialog is shown
- AND upon confirmation, product instance is deleted
- AND product is removed from wallet view
- AND all associated data (notes, images, receipts) are deleted

**Business Rules:**
- Deletion requires confirmation
- Deletion is permanent (no undo)
- Backend delete is called before UI update

---

### FR-WALLET-003: View My Things
**Priority:** P0  
**Description:** Users can view all owned products in a list

**Functional Behavior:**
- GIVEN user is on HomePage
- WHEN "My Things" tab is selected
- THEN all owned products are displayed in grid/list view
- AND each product shows: image, name, brand, tags
- AND products are sorted by date added (newest first)

**Business Rules:**
- Empty state shows onboarding message
- Products load progressively (lazy loading)
- Tapping product navigates to product detail page

---

### FR-WALLET-004: Tag-Based Filtering
**Priority:** P2  
**Description:** Users can filter products by custom tags

**Functional Behavior:**
- GIVEN user has tagged products
- WHEN user taps a tag filter
- THEN only products with that tag are shown
- AND "Clear Filter" button appears
- AND tag filters persist during session

**Data Elements:**
- Tag ID (string, UUID)
- Tag name (string, user-defined)
- Tag color (hex color, optional)
- Products count (integer, derived)

---

### FR-WALLET-005: Product Documentation
**Priority:** P2  
**Description:** Users can attach documents to owned products

**Functional Behavior:**
- Users can upload product receipt (PDF, image)
- Users can add product photos (up to 10 images)
- Users can add notes (rich text)
- Users can attach external data (custom title, image URL)

**Data Elements:**
- Receipt URL (string, CDN link)
- Product images (array of CDN links)
- Note content (string, markdown supported)
- Note attachments (array of CDN links)
- External title (string, optional)
- External image URL (string, optional)

---

## 4. Scan History

### FR-HISTORY-001: View Scan History
**Priority:** P1  
**Description:** Users can view previously scanned products

**Functional Behavior:**
- GIVEN user is on HomePage
- WHEN "Scan History" section is visible
- THEN up to 5 recent scans are displayed
- AND each shows: product image, name, brand
- AND tapping product navigates to detail page

**Business Rules:**
- History shows non-owned products only
- Sorted by scan time (newest first)
- Maximum 100 items stored

---

### FR-HISTORY-002: Delete Scan History Item
**Priority:** P1  
**Description:** Users can remove items from scan history

**Functional Behavior:**
- GIVEN user is viewing scan history
- WHEN they swipe left on item (or tap delete)
- THEN item is removed from history
- AND deletion syncs to backend

**Business Rules:**
- No confirmation required for single delete
- Deletion is permanent

---

### FR-HISTORY-003: Clear All History
**Priority:** P2  
**Description:** Users can clear entire scan history

**Functional Behavior:**
- GIVEN user is in settings
- WHEN they tap "Clear Scan History"
- THEN confirmation dialog is shown
- AND upon confirmation, all history is deleted

**Business Rules:**
- Requires confirmation
- Does not affect "My Things"

---

## 5. AI Assistant

### FR-AI-001: AI Provider Configuration
**Priority:** P1  
**Description:** Users can select and configure AI provider

**Functional Behavior:**
- GIVEN user navigates to Settings → AI Assistant Settings
- WHEN they view available providers
- THEN list shows: OpenAI, Google Gemini, Perplexity, Deepseek
- AND each shows "Installed" status
- WHEN user selects provider
- THEN API key input dialog is shown
- WHEN user enters API key and taps "Confirm"
- THEN key is validated (or demo mode is detected)
- AND key is stored securely in SharedPreferences
- AND success message is displayed: "Assistant ready"

**Business Rules:**
- Only one AI provider active at a time
- API keys stored locally (not sent to backend)
- Demo mode accepts keys: "demo", "test", "demo-key-123"
- Validation happens before storage

**Data Elements:**
- AI provider (enum: openai, gemini, perplexity, deepseek)
- API key (string, encrypted in storage)
- Provider status (enum: not_configured, configured, demo_mode)
- Last validation timestamp (datetime)

**Error Conditions:**
- Invalid API key → Show "Invalid API key" toast
- Network error during validation → Show "Cannot validate, check connection"
- Empty API key → Show "API key required"

---

### FR-AI-002: Ask AI Button Display
**Priority:** P1  
**Description:** "Ask AI" button appears on product detail pages

**Functional Behavior:**
- GIVEN user is viewing product detail page
- WHEN AI assistant is configured
- THEN "Ask AI" button is displayed (replaces "Buy Here" button)
- AND button is blue with white text
- AND button is disabled if AI not configured

**Business Rules:**
- Button only shown for authenticated users
- Button placement: below product image/title section
- Button full width with 16px margins

---

### FR-AI-003: Contextual Question Selection
**Priority:** P1  
**Description:** Users see context-aware question templates

**Functional Behavior:**
- GIVEN user taps "Ask AI" button
- WHEN user is navigated to AIQuestionSelectionPage
- THEN question templates are displayed based on ownership status

**For Owned Products (isOwner = true):**
1. "How to optimize this battery life?"
2. "Check warranty status"
3. "Find me authorized repair shops"
4. "What is the current aftermarket value?"
5. "Ask your question..." (custom input)

**For Scan History (isOwner = false):**
1. "What is the sustainability score of this product?"
2. "What are similar alternatives?"
3. "How to properly care for this material?"
4. "Ask your question..." (custom input)

**Business Rules:**
- Questions displayed as tappable cards
- Custom question input shown at bottom
- Product context included in all queries

**Data Elements:**
- Selected question (string)
- Product name (string, for context)
- Product barcode/EAN (string, for context)
- Ownership status (boolean)

---

### FR-AI-004: AI Chat Conversation
**Priority:** P1  
**Description:** Users can chat with AI about products

**Functional Behavior:**
- GIVEN user selects a question
- WHEN user is navigated to AIChatPage
- THEN question and product info are pre-filled in prompt
- AND AI starts streaming response
- AND response appears in real-time (word by word)
- AND input field remains active for follow-up questions

**Business Rules:**
- First message includes full product context
- Follow-up messages maintain conversation context
- Streaming updates every 50-100ms
- Input field always enabled (no disable during streaming)
- Maximum conversation length: 20 messages

**Data Elements:**
- Messages (array of {role: user|assistant, content: string})
- Product context (object: {name, brand, barcode, isOwner})
- Streaming state (boolean)
- Error state (string, optional)

**Error Conditions:**
- AI API error → Show toast: "AI service error, please try again"
- Network timeout → Show toast: "Request timeout, check connection"
- Rate limit exceeded → Show toast: "Rate limit reached, please wait"
- Invalid response → Show toast: "Unexpected response format"

---

### FR-AI-005: Demo Mode Operation
**Priority:** P1  
**Description:** Demo mode provides simulated AI responses

**Functional Behavior:**
- GIVEN user enters demo API key ("demo", "test", "demo-key-123")
- WHEN validation occurs
- THEN demo mode is activated
- AND simulated responses are returned
- AND no real AI API calls are made

**Simulated Response Patterns:**
- Battery optimization → Tips about charging cycles, temperature
- Warranty check → Generic warranty guidance
- Repair shops → Suggestion to check manufacturer website
- Aftermarket value → Factors affecting resale value
- Sustainability → General eco-friendly product info
- Alternatives → Suggestion to research similar brands
- Care instructions → Material-specific care tips

**Business Rules:**
- Demo responses generic but relevant
- Response streaming simulated (50ms per word)
- No API costs incurred in demo mode
- Demo mode clearly indicated in UI (optional)

---

## 6. Product Information Display

### FR-PRODUCT-001: Product Detail View
**Priority:** P0  
**Description:** Display comprehensive product information

**Functional Behavior:**
- GIVEN user navigates to product detail page
- THEN following information is displayed:
  - Product image (hero image)
  - Product name
  - Brand name
  - Barcode/EAN
  - Product description
  - Product specifications (if available)
  - Care instructions (if available)
  - Sustainability information (if available)
  - Product pages/documentation links

**Data Elements:**
- Product ID (string)
- Name (string)
- Brand (string)
- Barcode/EAN (string)
- Image URL (string)
- Description (string, markdown)
- Specifications (key-value pairs)
- Care instructions (string, markdown)
- Sustainability score (number, 0-100)
- External links (array of URLs)

**Business Rules:**
- Images lazy-loaded
- Missing data shows placeholder or hides section
- External links open in in-app browser

---

### FR-PRODUCT-002: Product Pages Navigation
**Priority:** P2  
**Description:** Users can view multi-page product documentation

**Functional Behavior:**
- GIVEN product has multiple documentation pages
- WHEN user taps "View Pages"
- THEN paginated view is shown
- AND user can swipe between pages

**Data Elements:**
- Page number (integer)
- Page content (HTML/markdown)
- Page title (string)
- Total pages (integer)

---

## 7. Settings & Preferences

### FR-SETTINGS-001: Language Selection
**Priority:** P1  
**Description:** Users can change app language

**Functional Behavior:**
- GIVEN user is in Settings
- WHEN they tap language dropdown
- THEN list of 14 supported languages is shown
- WHEN user selects language
- THEN app UI updates immediately
- AND preference is saved
- AND backend is notified

**Supported Languages:**
- English (en)
- Estonian (et)
- Swedish (sv)
- Lithuanian (lt)
- Latvian (lv)
- German (de)
- Finnish (fi)
- French (fr)
- Spanish (es)
- Italian (it)
- Danish (da)
- Dutch (nl)
- Portuguese (pt)
- Polish (pl)
- Russian (ru)

---

### FR-SETTINGS-002: Country Selection
**Priority:** P1  
**Description:** Users can set their country

**Functional Behavior:**
- GIVEN user is in Settings
- WHEN they select country dropdown
- THEN list of countries is shown
- WHEN user selects country
- THEN preference is saved
- AND backend is notified

---

### FR-SETTINGS-003: Privacy Preferences
**Priority:** P2  
**Description:** Users can manage privacy settings

**Functional Behavior:**
- Users can toggle marketing consent
- Users can toggle feedback/analytics consent
- Users can delete all account data

**Business Rules:**
- Data deletion requires confirmation
- Data deletion is irreversible
- Changes sync to backend

---

## 8. Search & Discovery

### FR-SEARCH-001: Product Search
**Priority:** P2  
**Description:** Users can search for products

**Functional Behavior:**
- GIVEN user is on search page
- WHEN they enter search query
- THEN matching products are displayed
- AND results update as user types

**Business Rules:**
- Minimum 2 characters for search
- Results debounced (300ms)
- Search by name, brand, barcode

---

### FR-FEED-001: User Feed
**Priority:** P2  
**Description:** Users receive personalized feed updates

**Functional Behavior:**
- Feed shows product updates
- Feed shows sustainability tips
- Feed shows product recalls (if applicable)

**Business Rules:**
- Feed updates daily
- Language-specific content
- Maximum 20 items in feed

---

## Data Flow Summary

```
User Login → OAuth → Token Storage → API Authentication
Product Scan → QR Decode → API Fetch → Display/History
Add to Wallet → Create Instance → Sync Backend → Update UI
AI Question → Pre-fill Context → Stream Response → Display
Settings Change → Update UI → Sync Backend → Persist Local
```

---

## API Integration Requirements

### Endpoints Required
- POST `/v2/user/authenticate` - User authentication
- GET `/v2/user/profile` - Get user profile
- PATCH `/v2/user/profile` - Update user profile
- GET `/v2/user/scan_history` - Get scan history
- DELETE `/v2/user/scan_history/{id}` - Delete history item
- GET `/v2/tings/list` - Get owned products
- POST `/v2/tings/add` - Add product to wallet
- DELETE `/v2/tings/{id}/remove` - Remove from wallet
- GET `/v2/products/{id}` - Get product details
- GET `/v2/app` - Get app configuration

### AI Provider APIs (External)
- OpenAI: `https://api.openai.com/v1/chat/completions`
- Google Gemini: `https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent`
- Perplexity: `https://api.perplexity.ai/chat/completions`
- Deepseek: `https://api.deepseek.com/v1/chat/completions`

---

## Validation Rules

### Email Validation
- Must be valid email format
- Must be verified by OAuth provider

### Product ID Validation
- Alphanumeric string
- Length: 1-100 characters

### API Key Validation
- Minimum 8 characters
- Demo keys: "demo", "test", "demo-key-123"
- Provider-specific format validation

### Tag Name Validation
- Length: 1-50 characters
- No special characters except hyphen, underscore

---

## Accessibility Requirements

- All interactive elements have minimum 44x44pt tap target
- Color contrast ratio minimum 4.5:1
- Screen reader support for all content
- VoiceOver/TalkBack compatibility
- Dynamic text size support
- Keyboard navigation support (for tablets)
