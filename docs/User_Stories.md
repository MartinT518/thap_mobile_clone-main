# User Stories
## Thap Mobile Application

**Version:** 2.0  
**Date:** November 18, 2025  
**Format:** Agile User Stories with Acceptance Criteria

---

## Epic 1: User Authentication & Onboarding

### US-001: Sign In with Google
**As a** new user  
**I want to** sign in using my Google account  
**So that** I can access the app without creating a new password

**Priority:** P0  
**Story Points:** 3  
**Sprint:** 1

**Acceptance Criteria:**
- [x] Given I am on the login screen
- [x] When I tap "Sign in with Google"
- [x] Then I am redirected to Google OAuth page
- [x] And after successful authentication, I am logged into the app
- [x] And my session persists across app restarts

**Definition of Done:**
- OAuth flow completes successfully
- Session token stored securely
- User can log out
- Error handling for failed authentication

---

### US-002: Automatic Session Restoration
**As a** returning user  
**I want to** be automatically logged in when I open the app  
**So that** I don't have to sign in every time

**Priority:** P0  
**Story Points:** 2  
**Sprint:** 1

**Acceptance Criteria:**
- [x] Given I have previously logged in
- [x] When I open the app
- [x] Then I am automatically logged in
- [x] And I am taken to the home page
- [x] And if my session has expired, I am prompted to log in again

**Definition of Done:**
- Token validation works
- Expired tokens handled gracefully
- User feedback during authentication

---

### US-003: View Onboarding Guide
**As a** first-time user  
**I want to** see an onboarding guide  
**So that** I understand how to use the app

**Priority:** P2  
**Story Points:** 3  
**Sprint:** 3

**Acceptance Criteria:**
- [ ] Given I am logging in for the first time
- [ ] When I complete authentication
- [ ] Then I see a brief tutorial
- [ ] And I can skip the tutorial if desired
- [ ] And the tutorial shows key features (scanning, wallet, AI)

**Definition of Done:**
- Tutorial screens designed
- Skip functionality works
- Tutorial shown only once

---

## Epic 2: Product Discovery & Scanning

### US-004: Scan Product QR Code
**As a** user  
**I want to** scan a product's QR code  
**So that** I can quickly access product information

**Priority:** P0  
**Story Points:** 5  
**Sprint:** 1

**Acceptance Criteria:**
- [x] Given I am on the home screen
- [x] When I tap the QR scanner button
- [x] Then my camera opens
- [x] And I can point it at a QR code
- [x] And the product information loads automatically
- [x] And I can see product details

**Definition of Done:**
- Camera permission handling
- QR code detection works
- Product data fetched from API
- Error handling for invalid codes

---

### US-005: View Product Information
**As a** user  
**I want to** view detailed product information  
**So that** I can learn about products before or after purchase

**Priority:** P0  
**Story Points:** 3  
**Sprint:** 1

**Acceptance Criteria:**
- [x] Given I have scanned a product
- [x] When I view the product detail page
- [x] Then I see the product name, brand, image
- [x] And I see product description and specifications
- [x] And I see care instructions (if available)
- [x] And I see sustainability information (if available)

**Definition of Done:**
- All product fields displayed
- Images load correctly
- Responsive layout
- Missing data handled gracefully

---

### US-006: Track Scan History
**As a** user  
**I want to** see products I've previously scanned  
**So that** I can review products I'm considering purchasing

**Priority:** P1  
**Story Points:** 2  
**Sprint:** 2

**Acceptance Criteria:**
- [x] Given I have scanned products
- [x] When I view the home screen
- [x] Then I see a "Scan History" section
- [x] And I see recently scanned products
- [x] And I can tap on them to view details again

**Definition of Done:**
- History persists across sessions
- Items sorted by scan time
- History limit enforced (100 items)

---

## Epic 3: Product Wallet Management

### US-007: Add Product to My Wallet
**As a** user who owns a product  
**I want to** add it to my digital wallet  
**So that** I can organize and track my belongings

**Priority:** P0  
**Story Points:** 3  
**Sprint:** 1

**Acceptance Criteria:**
- [x] Given I am viewing a scanned product
- [x] When I tap "Add to My Things"
- [x] Then the product is added to my wallet
- [x] And it appears in the "My Things" section
- [x] And it is removed from scan history

**Definition of Done:**
- Backend instance created
- Local state updated
- UI reflects changes
- Success feedback shown

---

### US-008: Remove Product from Wallet
**As a** user  
**I want to** remove products I no longer own  
**So that** my wallet stays up-to-date

**Priority:** P0  
**Story Points:** 2  
**Sprint:** 1

**Acceptance Criteria:**
- [x] Given I have a product in my wallet
- [x] When I tap "Remove from My Things"
- [x] Then I see a confirmation dialog
- [x] And after confirming, the product is removed
- [x] And all associated data is deleted

**Definition of Done:**
- Confirmation required
- Backend deletion successful
- Local data cleared
- UI updated

---

### US-009: Organize Products with Tags
**As a** user with many products  
**I want to** tag and categorize my products  
**So that** I can find them easily

**Priority:** P2  
**Story Points:** 5  
**Sprint:** 3

**Acceptance Criteria:**
- [ ] Given I own products
- [ ] When I add tags to products
- [ ] Then I can filter products by tag
- [ ] And I can create custom tags
- [ ] And I can see products count per tag

**Definition of Done:**
- Tag creation UI
- Tag filtering works
- Tags persist
- Tag management (edit/delete)

---

### US-010: Attach Receipt to Product
**As a** user  
**I want to** upload product receipts  
**So that** I have proof of purchase for warranty claims

**Priority:** P2  
**Story Points:** 3  
**Sprint:** 4

**Acceptance Criteria:**
- [ ] Given I own a product
- [ ] When I tap "Add Receipt"
- [ ] Then I can select a photo or PDF
- [ ] And the receipt is uploaded and stored
- [ ] And I can view it later

**Definition of Done:**
- File picker integration
- Image/PDF upload works
- Receipt stored in cloud
- Viewing functionality

---

## Epic 4: AI-Powered Assistant

### US-011: Configure AI Provider
**As a** user  
**I want to** choose my preferred AI provider  
**So that** I can get product assistance using the AI service I trust

**Priority:** P1  
**Story Points:** 3  
**Sprint:** 5

**Acceptance Criteria:**
- [x] Given I am in Settings
- [x] When I tap "AI Assistant Settings"
- [x] Then I see available AI providers
- [x] And I can select one (OpenAI, Gemini, Perplexity, Deepseek)
- [x] And I can enter my API key
- [x] And the system validates my key
- [x] And I see "Assistant ready" confirmation

**Definition of Done:**
- All 4 providers supported
- API key validation works
- Secure storage implemented
- Error handling for invalid keys

---

### US-012: Test AI with Demo Mode
**As a** user evaluating the app  
**I want to** test the AI feature without an API key  
**So that** I can see how it works before committing to a paid AI service

**Priority:** P1  
**Story Points:** 2  
**Sprint:** 5

**Acceptance Criteria:**
- [x] Given I want to test the AI feature
- [x] When I enter "demo" as my API key
- [x] Then the system accepts it
- [x] And I can use the AI feature with simulated responses
- [x] And no real API calls are made

**Definition of Done:**
- Demo keys recognized ("demo", "test", "demo-key-123")
- Simulated responses contextual
- Streaming simulation works
- No API costs incurred

---

### US-013: Ask AI About Owned Product
**As a** product owner  
**I want to** ask AI questions about my product  
**So that** I can optimize its use and maintenance

**Priority:** P1  
**Story Points:** 5  
**Sprint:** 5

**Acceptance Criteria:**
- [x] Given I own a product
- [x] When I tap "Ask AI" on the product page
- [x] Then I see contextual questions:
  - "How to optimize this battery life?"
  - "Check warranty status"
  - "Find me authorized repair shops"
  - "What is the current aftermarket value?"
- [x] And I can select a question or type my own
- [x] And I see AI response streaming in real-time
- [x] And I can ask follow-up questions

**Definition of Done:**
- Question templates implemented
- AI API integration works
- Streaming responses display
- Conversation history maintained

---

### US-014: Research Product Before Purchase
**As a** potential buyer  
**I want to** ask AI questions about a product I scanned  
**So that** I can make an informed purchase decision

**Priority:** P1  
**Story Points:** 5  
**Sprint:** 5

**Acceptance Criteria:**
- [x] Given I have scanned but don't own a product
- [x] When I tap "Ask AI"
- [x] Then I see research-focused questions:
  - "What is the sustainability score of this product?"
  - "What are similar alternatives?"
  - "How to properly care for this material?"
- [x] And I can get AI-powered answers
- [x] And the answers help me decide whether to buy

**Definition of Done:**
- Pre-purchase questions implemented
- AI responses relevant to buying decision
- Product context included in prompts

---

### US-015: Continue AI Conversation
**As a** user chatting with AI  
**I want to** ask follow-up questions  
**So that** I can get more detailed information

**Priority:** P1  
**Story Points:** 3  
**Sprint:** 5

**Acceptance Criteria:**
- [x] Given I have asked an initial question
- [x] When the AI responds
- [x] Then the input field remains active
- [x] And I can type a follow-up question
- [x] And the AI remembers the conversation context

**Definition of Done:**
- Multi-turn conversations work
- Context maintained
- Input never disabled
- Conversation limit enforced (20 messages)

---

## Epic 5: Personalization & Settings

### US-016: Change Language
**As a** multilingual user  
**I want to** change the app language  
**So that** I can use it in my preferred language

**Priority:** P1  
**Story Points:** 2  
**Sprint:** 2

**Acceptance Criteria:**
- [x] Given I am in Settings
- [x] When I select a different language
- [x] Then the entire app UI updates
- [x] And my preference is saved
- [x] And the change persists across app restarts

**Definition of Done:**
- 14 languages supported
- Full UI translation
- Preference synced to backend
- Instant UI update

---

### US-017: Set Country Preference
**As a** user  
**I want to** set my country  
**So that** I see region-specific information

**Priority:** P1  
**Story Points:** 1  
**Sprint:** 2

**Acceptance Criteria:**
- [x] Given I am in Settings
- [x] When I select my country
- [x] Then the system saves my preference
- [x] And I may see country-specific content (future feature)

**Definition of Done:**
- Country selection works
- Preference saved
- Backend notified

---

### US-018: Manage Privacy Settings
**As a** privacy-conscious user  
**I want to** control data sharing  
**So that** I can protect my privacy

**Priority:** P2  
**Story Points:** 2  
**Sprint:** 4

**Acceptance Criteria:**
- [ ] Given I am in Settings
- [ ] When I view privacy options
- [ ] Then I can toggle marketing consent
- [ ] And I can toggle analytics consent
- [ ] And I can delete all my data

**Definition of Done:**
- Consent toggles work
- Data deletion confirmed
- Backend updated
- Irreversible deletion warning

---

## Epic 6: Search & Discovery

### US-019: Search for Products
**As a** user  
**I want to** search for specific products  
**So that** I can quickly find what I'm looking for

**Priority:** P2  
**Story Points:** 3  
**Sprint:** 3

**Acceptance Criteria:**
- [ ] Given I am on the search page
- [ ] When I type a search query
- [ ] Then I see matching products
- [ ] And results update as I type
- [ ] And I can tap results to view details

**Definition of Done:**
- Search API integrated
- Debounced input (300ms)
- Results display correctly
- Empty state handled

---

### US-020: View Personalized Feed
**As a** user  
**I want to** see updates relevant to my products  
**So that** I stay informed about recalls and tips

**Priority:** P2  
**Story Points:** 3  
**Sprint:** 4

**Acceptance Criteria:**
- [ ] Given I own products
- [ ] When I view the Feed tab
- [ ] Then I see personalized updates
- [ ] And I see sustainability tips
- [ ] And I see product-related news

**Definition of Done:**
- Feed API integrated
- Content personalized
- Language-specific content
- Refresh functionality

---

## Epic 7: Product Documentation

### US-021: Add Product Photos
**As a** user  
**I want to** attach photos to my products  
**So that** I can document their condition

**Priority:** P2  
**Story Points:** 3  
**Sprint:** 4

**Acceptance Criteria:**
- [ ] Given I own a product
- [ ] When I tap "Add Photo"
- [ ] Then I can take a photo or select from gallery
- [ ] And the photo is uploaded
- [ ] And I can view all product photos

**Definition of Done:**
- Camera/gallery picker works
- Multiple photos supported (max 10)
- Photos stored in cloud
- Photo viewing UI

---

### US-022: Add Product Notes
**As a** user  
**I want to** write notes about my products  
**So that** I can remember important details

**Priority:** P2  
**Story Points:** 2  
**Sprint:** 4

**Acceptance Criteria:**
- [ ] Given I own a product
- [ ] When I tap "Add Note"
- [ ] Then I can write text notes
- [ ] And notes are saved automatically
- [ ] And I can view/edit notes later

**Definition of Done:**
- Note editor implemented
- Auto-save works
- Notes synced to backend
- Rich text support (optional)

---

## Story Map Summary

### Now (Sprint 1-2) - MVP
- Authentication (US-001, US-002)
- Product Scanning (US-004, US-005)
- Wallet Management (US-007, US-008)
- Basic Settings (US-016, US-017)
- Scan History (US-006)

### Next (Sprint 3-5) - Enhanced Features
- AI Assistant (US-011 through US-015)
- Search & Discovery (US-019)
- Product Organization (US-009)

### Later (Sprint 6+) - Premium Features
- Advanced Documentation (US-010, US-021, US-022)
- Feed & Notifications (US-020)
- Privacy Controls (US-018)
- Onboarding (US-003)

---

## Metrics & Success Criteria

### Sprint 1-2 (MVP)
- 80% of user stories completed
- Core functionality working
- Zero P0 bugs
- App store ready

### Sprint 3-5 (AI Features)
- AI assistant configured by 60% of users
- Average 3 AI questions per product
- 80% positive AI feedback

### Sprint 6+ (Growth)
- 70% feature adoption
- 4.0+ app store rating
- < 1% crash rate
- 80% monthly retention

---

## Total User Stories: 22
- **P0 (Must Have):** 6 stories
- **P1 (Should Have):** 10 stories
- **P2 (Nice to Have):** 6 stories

**By Epic:**
- Authentication: 3 stories
- Product Discovery: 3 stories
- Wallet Management: 4 stories
- AI Assistant: 5 stories
- Settings: 3 stories
- Search & Discovery: 2 stories
- Documentation: 2 stories
