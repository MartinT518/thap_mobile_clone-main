# Use Cases
## Thap Mobile Application

**Version:** 2.0  
**Date:** November 18, 2025  
**Related:** PRD, FRD

---

## Table of Contents
1. [User Authentication Use Cases](#user-authentication-use-cases)
2. [Product Management Use Cases](#product-management-use-cases)
3. [AI Assistant Use Cases](#ai-assistant-use-cases)
4. [Search & Discovery Use Cases](#search--discovery-use-cases)

---

## User Authentication Use Cases

### UC-AUTH-001: First Time User Sign-In

**Primary Actor:** New User  
**Preconditions:**
- User has installed the Thap app
- User has a Google account
- Device has internet connection

**Main Success Scenario:**
1. User opens Thap app for the first time
2. System displays login screen with "Sign in with Google" button
3. User taps "Sign in with Google" button
4. System redirects to Google OAuth page
5. User enters Google credentials
6. User grants permissions to Thap
7. Google redirects back to Thap with auth token
8. System creates user profile on backend
9. System stores auth token locally
10. System navigates user to HomePage (My Things)
11. System displays empty state with onboarding message

**Alternative Flows:**

**3a. User Cancels OAuth:**
1. User closes OAuth page or taps back
2. System shows toast: "Login cancelled"
3. User remains on login screen

**5a. Google Login Fails:**
1. Google authentication fails
2. System shows toast: "Login failed, please try again"
3. User remains on login screen

**6a. User Denies Permissions:**
1. User denies required permissions
2. System shows toast: "Permissions required to continue"
3. User remains on login screen

**8a. Backend Registration Fails:**
1. Backend returns error
2. System clears local auth state
3. System shows toast: "Registration failed, please try again"
4. User returns to login screen

**Postconditions:**
- User profile created in backend
- Auth token stored locally
- User session active
- User on HomePage

**Business Rules:**
- Only Google OAuth supported
- Email must be unique
- Session valid for 30 days

---

### UC-AUTH-002: Returning User Auto-Login

**Primary Actor:** Returning User  
**Preconditions:**
- User has previously logged in
- Valid auth token exists locally
- Device has internet connection

**Main Success Scenario:**
1. User opens Thap app
2. System displays loading screen
3. System attempts to restore session using stored token
4. System validates token with backend
5. Backend confirms token valid
6. System loads user profile data
7. System navigates to HomePage
8. System displays user's products

**Alternative Flows:**

**4a. Token Expired:**
1. Backend returns 401 Unauthorized
2. System clears local token
3. System navigates to LoginPage
4. User must sign in again

**4b. Network Error:**
1. Network request fails
2. System retries 3 times
3. If still fails, system shows error: "Connection error"
4. System navigates to LoginPage

**Postconditions:**
- User session active
- User data loaded
- User on HomePage

---

### UC-AUTH-003: User Sign-Out

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is logged in
- User is on HomePage

**Main Success Scenario:**
1. User taps "Menu" button
2. System displays menu page
3. User scrolls to bottom
4. User taps "Sign Out" button
5. System disconnects Google OAuth session
6. System clears local auth token
7. System clears cached user data
8. System navigates to LoginPage
9. System shows toast: "Signed out successfully"

**Alternative Flows:**
None

**Postconditions:**
- User session terminated
- Local data cleared
- User on LoginPage

---

## Product Management Use Cases

### UC-PRODUCT-001: Scan Product QR Code

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is logged in
- Camera permission granted
- Device has internet connection

**Main Success Scenario:**
1. User taps QR scanner button in navigation bar
2. System opens camera view
3. System activates QR code detection
4. User points camera at product QR code
5. System detects and decodes QR code
6. System extracts product ID from QR code
7. System fetches product data from backend API
8. Backend returns product information
9. System navigates to ProductDetailPage
10. System displays product information

**Alternative Flows:**

**2a. Camera Permission Not Granted:**
1. System requests camera permission
2a. User denies permission
   - System shows explanation dialog
   - User returns to previous screen
2b. User grants permission
   - Continue to step 3

**5a. Invalid QR Code:**
1. QR code cannot be decoded
2. System shows toast: "Invalid QR code"
3. User remains on camera view

**7a. Product Not Found:**
1. Backend returns 404
2. System navigates to error page
3. System shows: "Product not found in database"
4. System offers "Report Missing Product" button

**7b. Network Error:**
1. API request fails
2. System shows toast: "Connection error"
3. User remains on camera view

**Postconditions:**
- Product information displayed
- Product added to scan history (if not owned)
- User on ProductDetailPage

---

### UC-PRODUCT-002: Add Product to My Things

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is viewing ProductDetailPage
- Product is not owned (isOwner = false)
- User is logged in

**Main Success Scenario:**
1. User views product detail page
2. System displays "Add to My Things" button
3. User taps "Add to My Things" button
4. System sends request to backend to create product instance
5. Backend creates product instance with unique ID
6. Backend returns instance data
7. System updates local state (isOwner = true)
8. System shows toast: "Added to My Things"
9. System updates button to show "Remove from My Things"
10. System moves product from scan history to My Things list

**Alternative Flows:**

**4a. Backend Error:**
1. Backend returns error
2. System shows toast: "Failed to add product"
3. User remains on product page
4. Button remains "Add to My Things"

**4b. Network Error:**
1. API request fails
2. System retries 2 times
3. If still fails, shows toast: "Connection error, please try again"

**Postconditions:**
- Product instance created
- Product in My Things list
- Product removed from scan history
- Button changed to "Remove"

---

### UC-PRODUCT-003: Remove Product from My Things

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is viewing owned product (isOwner = true)
- User is logged in

**Main Success Scenario:**
1. User views owned product detail page
2. System displays "Remove from My Things" button
3. User taps "Remove from My Things" button
4. System shows confirmation dialog: "Remove this product?"
5. User taps "Confirm"
6. System sends delete request to backend
7. Backend deletes product instance
8. Backend confirms deletion
9. System removes product from local state
10. System navigates back to HomePage
11. System shows toast: "Product removed"

**Alternative Flows:**

**5a. User Cancels:**
1. User taps "Cancel" in dialog
2. Dialog closes
3. User remains on product page
4. No changes made

**6a. Backend Error:**
1. Backend returns error
2. System shows toast: "Failed to remove product"
3. User remains on product page
4. Product still in My Things

**Postconditions:**
- Product instance deleted
- Product removed from My Things
- All associated data deleted (notes, receipts, images)
- User on HomePage

---

### UC-PRODUCT-004: View My Things List

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is logged in
- User is on HomePage

**Main Success Scenario:**
1. System loads HomePage
2. System fetches owned products from backend
3. Backend returns list of product instances
4. System displays products in grid/list view
5. Each product shows: image, name, brand, tags
6. User scrolls through products
7. User taps on a product
8. System navigates to ProductDetailPage for that product

**Alternative Flows:**

**2a. No Products Owned:**
1. Backend returns empty list
2. System displays empty state
3. System shows onboarding message
4. System displays "Scan your first product" CTA

**2b. Backend Error:**
1. API request fails
2. System shows error state
3. System displays "Failed to load products" message
4. System shows "Retry" button

**3a. Partial Data Load:**
1. Some products fail to load
2. System displays successfully loaded products
3. System shows toast: "Some products failed to load"

**Postconditions:**
- Products displayed
- User can interact with product list

---

### UC-PRODUCT-005: Filter Products by Tag

**Primary Actor:** Authenticated User  
**Preconditions:**
- User has products with tags
- User is on HomePage
- Tag filter UI is visible

**Main Success Scenario:**
1. User views My Things with tagged products
2. System displays horizontal tag filter bar
3. System shows all user's tags
4. User taps on a tag (e.g., "Electronics")
5. System filters product list
6. System displays only products with selected tag
7. System shows "Clear Filter" button
8. User taps "Clear Filter"
9. System removes filter
10. System displays all products again

**Alternative Flows:**

**3a. No Tagged Products:**
1. User has no products with tags
2. Tag filter bar is hidden
3. All products displayed

**4a. Multiple Tag Selection:**
1. User taps multiple tags
2. System shows products matching ANY selected tag (OR logic)

**Postconditions:**
- Products filtered by tag
- Filter state maintained during session
- Filter cleared when requested

---

## AI Assistant Use Cases

### UC-AI-001: Configure AI Provider

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is logged in
- User is on Settings page
- User has OpenAI/Gemini/Perplexity/Deepseek API key (or wants to use demo mode)

**Main Success Scenario:**
1. User taps "Menu" button
2. System displays menu page
3. User taps "Settings"
4. System displays Settings page
5. User taps "AI Assistant Settings"
6. System displays AI provider selection page
7. System shows list of providers: OpenAI, Gemini, Perplexity, Deepseek
8. Each shows "Installed" status
9. User selects "OpenAI"
10. System displays API key input dialog
11. User enters API key
12. User taps "Confirm"
13. System validates API key with OpenAI
14. OpenAI confirms key is valid
15. System stores encrypted API key in SharedPreferences
16. System shows success message: "Assistant ready"
17. System marks OpenAI as active provider
18. User returns to Settings page

**Alternative Flows:**

**11a. User Enters Demo Key:**
1. User enters "demo" or "test" or "demo-key-123"
2. System detects demo mode key
3. System skips API validation
4. System stores demo flag
5. System shows success: "Demo mode activated"
6. Continue to step 16

**13a. Invalid API Key:**
1. OpenAI returns 401 Unauthorized
2. System shows toast: "Invalid API key"
3. Dialog remains open
4. User can re-enter key or cancel

**13b. Network Error:**
1. Validation request fails
2. System shows toast: "Cannot validate key, check connection"
3. User can retry or cancel

**14a. Rate Limited:**
1. OpenAI returns 429 Too Many Requests
2. System shows toast: "Rate limited, please try again later"
3. User can retry or cancel

**Postconditions:**
- AI provider configured
- API key stored securely
- Assistant ready for use
- "Ask AI" buttons enabled on product pages

---

### UC-AI-002: Ask AI About Owned Product

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is logged in
- AI assistant is configured
- User is viewing owned product (isOwner = true)
- Device has internet connection

**Main Success Scenario:**
1. User views owned product detail page
2. System displays "Ask AI" button (blue, full width)
3. User taps "Ask AI" button
4. System navigates to AIQuestionSelectionPage
5. System displays contextual questions for owned products:
   - "How to optimize this battery life?"
   - "Check warranty status"
   - "Find me authorized repair shops"
   - "What is the current aftermarket value?"
   - "Ask your question..." (custom input field)
6. User taps "How to optimize this battery life?"
7. System navigates to AIChatPage
8. System pre-fills prompt with:
   - Selected question
   - Product name
   - Product barcode
   - Ownership context
9. System sends request to AI provider
10. AI provider begins streaming response
11. System displays response in real-time (word by word)
12. Response completes
13. Input field remains active
14. User types follow-up question: "How often should I replace it?"
15. User taps send
16. System includes conversation history in request
17. AI streams follow-up response
18. Conversation continues

**Alternative Flows:**

**6a. User Selects Custom Question:**
1. User taps custom input field
2. User types: "What accessories are compatible?"
3. User taps send/submit
4. Continue to step 7 with custom question

**9a. Demo Mode Active:**
1. System detects demo mode
2. System generates simulated response based on question type
3. System simulates streaming (50ms per word)
4. System displays simulated response
5. No actual AI API call made

**9b. AI API Error:**
1. AI provider returns error
2. System stops streaming
3. System shows toast: "AI service error, please try again"
4. User can retry or return to product page

**10a. Network Timeout:**
1. Request exceeds 60 second timeout
2. System stops waiting
3. System shows toast: "Request timeout, check connection"
4. User can retry

**11a. Rate Limited:**
1. AI provider returns 429
2. System shows toast: "Rate limit reached, please wait"
3. User must wait before retrying

**Postconditions:**
- AI conversation displayed
- Conversation history maintained
- User can continue asking questions
- No changes to product data

---

### UC-AI-003: Ask AI About Pre-Purchase Product

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is logged in
- AI assistant is configured
- User is viewing scan history product (isOwner = false)
- Device has internet connection

**Main Success Scenario:**
1. User views scan history product detail page
2. System displays "Ask AI" button
3. User taps "Ask AI" button
4. System navigates to AIQuestionSelectionPage
5. System displays contextual questions for pre-purchase:
   - "What is the sustainability score of this product?"
   - "What are similar alternatives?"
   - "How to properly care for this material?"
   - "Ask your question..." (custom input)
6. User taps "What are similar alternatives?"
7. System navigates to AIChatPage
8. System pre-fills prompt with question and product context
9. System sends request to AI provider
10. AI streams response with alternative product suggestions
11. User reads alternatives
12. User asks follow-up: "Which one is most eco-friendly?"
13. AI streams comparison response
14. User uses insights to make purchase decision

**Alternative Flows:**
Same as UC-AI-002 (alternative flows)

**Postconditions:**
- User has product research information
- User can make informed purchase decision
- Conversation saved for reference

---

### UC-AI-004: Use Demo Mode Without API Key

**Primary Actor:** New User (Evaluating App)  
**Preconditions:**
- User is logged in
- User does not have AI provider API key
- User wants to test AI feature

**Main Success Scenario:**
1. User navigates to AI Assistant Settings
2. System displays AI provider list
3. User selects "OpenAI"
4. System displays API key input dialog
5. User enters "demo" as API key
6. User taps "Confirm"
7. System detects demo mode key
8. System stores demo mode flag (no validation needed)
9. System shows success: "Demo mode activated - simulated responses"
10. User navigates to product page
11. User taps "Ask AI"
12. User selects question
13. System generates context-aware simulated response
14. System displays simulated streaming
15. User sees realistic AI behavior without API costs
16. User decides to configure real API key later or continue with demo

**Alternative Flows:**

**5a. User Enters Other Demo Keys:**
1. User enters "test" or "demo-key-123"
2. System treats as valid demo key
3. Continue to step 7

**Postconditions:**
- Demo mode active
- User can test full AI flow
- No API costs incurred
- User understands feature value

---

## Search & Discovery Use Cases

### UC-SEARCH-001: Search for Product

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is logged in
- User is on search page

**Main Success Scenario:**
1. User taps "Search" in navigation bar
2. System displays search page with input field
3. User types search query: "Sony headphones"
4. System waits 300ms (debounce)
5. System sends search request to backend
6. Backend returns matching products
7. System displays search results
8. Each result shows: image, name, brand, barcode
9. User taps on a result
10. System navigates to ProductDetailPage

**Alternative Flows:**

**3a. Query Too Short:**
1. User types only 1 character
2. System does not search (minimum 2 required)
3. System shows hint: "Enter at least 2 characters"

**6a. No Results:**
1. Backend returns empty results
2. System shows: "No products found"
3. System suggests: "Try different search terms"

**6b. Search Error:**
1. Backend returns error
2. System shows: "Search failed, please try again"
3. System displays retry button

**Postconditions:**
- Search results displayed
- User can refine search or view products

---

### UC-FEED-001: View User Feed

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is logged in
- User is on HomePage

**Main Success Scenario:**
1. User taps "Feed" in navigation bar
2. System displays feed page
3. System fetches personalized feed from backend
4. Backend returns feed items
5. System displays feed messages
6. Each item shows: title, description, timestamp, image
7. User scrolls through feed
8. User taps on feed item
9. System displays full message or redirects to relevant page

**Alternative Flows:**

**3a. No Feed Items:**
1. Backend returns empty feed
2. System shows: "No updates at this time"
3. System shows illustration

**3b. Feed Error:**
1. API request fails
2. System shows error state
3. System displays retry button

**Postconditions:**
- Feed displayed
- User informed about updates

---

## Administrative Use Cases

### UC-ADMIN-001: Delete All User Data

**Primary Actor:** Authenticated User  
**Preconditions:**
- User is logged in
- User is in Settings

**Main Success Scenario:**
1. User navigates to Settings page
2. User scrolls to bottom
3. User taps "Delete All Data" button
4. System displays confirmation dialog
5. Dialog warns: "This will permanently delete all your products, history, and account data"
6. User taps "Confirm Delete"
7. System sends delete request to backend
8. Backend deletes all user data
9. Backend confirms deletion
10. System clears local storage
11. System signs out user
12. System navigates to LoginPage
13. System shows toast: "All data deleted"

**Alternative Flows:**

**6a. User Cancels:**
1. User taps "Cancel"
2. Dialog closes
3. No data deleted

**7a. Delete Fails:**
1. Backend returns error
2. System shows toast: "Failed to delete data"
3. No changes made

**Postconditions:**
- All user data deleted from backend
- Local storage cleared
- User signed out
- Account can be recreated on next login

---

## Summary Statistics

- **Total Use Cases:** 16
- **Authentication:** 3
- **Product Management:** 5
- **AI Assistant:** 4
- **Search & Discovery:** 2
- **Administrative:** 1
- **Misc:** 1

**Coverage:**
- All P0 features covered
- All P1 features covered
- Most P2 features covered

**Actor Distribution:**
- Authenticated User: 14 use cases
- New User: 2 use cases
- Guest User: 0 (no guest access)
