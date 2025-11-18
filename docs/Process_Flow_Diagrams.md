# Process Flow Diagrams
## Thap Mobile Application

**Version:** 2.0  
**Date:** November 18, 2025  
**Format:** Text-based flowcharts (Mermaid-compatible)

---

## 1. User Authentication Flow

```mermaid
flowchart TD
    Start([App Launch]) --> CheckToken{Valid Token?}
    CheckToken -->|Yes| RestoreSession[Restore Session]
    CheckToken -->|No| ShowLogin[Show Login Page]
    
    RestoreSession --> ValidateToken{Token Valid?}
    ValidateToken -->|Yes| LoadUserData[Load User Profile]
    ValidateToken -->|No| ShowLogin
    
    LoadUserData --> HomePage[Navigate to HomePage]
    
    ShowLogin --> UserAction{User Action}
    UserAction -->|Tap Google Sign-In| InitOAuth[Initialize Google OAuth]
    UserAction -->|Close App| End([End])
    
    InitOAuth --> GoogleAuth[Google OAuth Page]
    GoogleAuth --> AuthSuccess{Auth Success?}
    
    AuthSuccess -->|Yes| GetAuthToken[Receive Auth Token]
    AuthSuccess -->|No| ShowError[Show Error Toast]
    ShowError --> ShowLogin
    
    GetAuthToken --> RegisterBackend[Register/Login Backend]
    RegisterBackend --> BackendSuccess{Backend Success?}
    
    BackendSuccess -->|Yes| StoreToken[Store Token Locally]
    BackendSuccess -->|No| ShowError
    
    StoreToken --> HomePage
    
    HomePage --> End
```

**Key Decision Points:**
1. Token validation determines auto-login
2. OAuth success/failure determines next steps
3. Backend registration can fail independently

---

## 2. Product Scanning Flow

```mermaid
flowchart TD
    Start([User Taps QR Scanner]) --> CheckPermission{Camera Permission?}
    
    CheckPermission -->|Granted| OpenCamera[Open Camera View]
    CheckPermission -->|Not Granted| RequestPermission[Request Permission]
    
    RequestPermission --> UserResponse{User Response}
    UserResponse -->|Grant| OpenCamera
    UserResponse -->|Deny| ShowDialog[Show Permission Dialog]
    ShowDialog --> GoBack([Return to HomePage])
    
    OpenCamera --> DetectQR{QR Code Detected?}
    DetectQR -->|Yes| DecodeQR[Decode QR Code]
    DetectQR -->|No| OpenCamera
    
    DecodeQR --> ValidQR{Valid Format?}
    ValidQR -->|Yes| ExtractID[Extract Product ID]
    ValidQR -->|No| ShowToast1[Show 'Invalid QR' Toast]
    ShowToast1 --> OpenCamera
    
    ExtractID --> FetchProduct[Fetch from Backend API]
    FetchProduct --> APIResponse{API Response}
    
    APIResponse -->|200 Success| ParseData[Parse Product Data]
    APIResponse -->|404 Not Found| ShowNotFound[Show 'Product Not Found']
    APIResponse -->|Network Error| ShowToast2[Show 'Connection Error']
    
    ShowNotFound --> GoBack
    ShowToast2 --> OpenCamera
    
    ParseData --> CheckOwnership{Is Owned?}
    CheckOwnership -->|Yes| SkipHistory[Skip Scan History]
    CheckOwnership -->|No| AddHistory[Add to Scan History]
    
    SkipHistory --> ShowProduct[Navigate to Product Page]
    AddHistory --> ShowProduct
    
    ShowProduct --> End([End])
```

**Key Decision Points:**
1. Camera permission is critical path
2. QR validation happens before API call
3. Ownership status determines history tracking

---

## 3. Add Product to Wallet Flow

```mermaid
flowchart TD
    Start([Product Detail Page]) --> CheckOwnership{Already Owned?}
    
    CheckOwnership -->|Yes| ShowRemove[Show 'Remove' Button]
    CheckOwnership -->|No| ShowAdd[Show 'Add to My Things']
    
    ShowAdd --> UserTapsAdd{User Taps Add?}
    UserTapsAdd -->|No| Wait[Wait for User Action]
    UserTapsAdd -->|Yes| CreateInstance[POST /tings/add]
    
    CreateInstance --> APIResponse{API Response}
    
    APIResponse -->|Success| UpdateLocal[Update Local State]
    APIResponse -->|Error| ShowError[Show Error Toast]
    
    ShowError --> ShowAdd
    
    UpdateLocal --> SetOwner[Set isOwner = true]
    SetOwner --> UpdateHistory[Remove from Scan History]
    UpdateHistory --> UpdateWallet[Add to My Things List]
    UpdateWallet --> ChangeButton[Change Button to 'Remove']
    ChangeButton --> ShowSuccess[Show Success Toast]
    
    ShowSuccess --> End([End])
    
    ShowRemove --> End
    Wait --> End
```

**Key Decision Points:**
1. Ownership check determines button state
2. API success required before UI update
3. Local state update is atomic operation

---

## 4. AI Assistant Configuration Flow

```mermaid
flowchart TD
    Start([Settings Page]) --> TapAI[Tap 'AI Assistant Settings']
    TapAI --> ShowProviders[Show Provider List]
    
    ShowProviders --> ProviderList[OpenAI, Gemini, Perplexity, Deepseek]
    ProviderList --> UserSelect{User Selects Provider}
    
    UserSelect --> ShowDialog[Show API Key Dialog]
    ShowDialog --> UserInput{User Input}
    
    UserInput -->|Enters Key| CheckDemo{Is Demo Key?}
    UserInput -->|Cancels| ShowProviders
    
    CheckDemo -->|Yes: demo/test/demo-key-123| ActivateDemo[Set Demo Mode]
    CheckDemo -->|No| ValidateAPI[Call AI Provider API]
    
    ActivateDemo --> StoreLocal[Store in SharedPreferences]
    StoreLocal --> ShowSuccess1[Show 'Demo Mode Active']
    ShowSuccess1 --> EnableFeature[Enable Ask AI Buttons]
    EnableFeature --> End([End])
    
    ValidateAPI --> ValidationResult{Validation Result}
    
    ValidationResult -->|Valid| EncryptKey[Encrypt API Key]
    ValidationResult -->|Invalid| ShowError[Show 'Invalid Key' Toast]
    ValidationResult -->|Network Error| ShowNetError[Show Network Error]
    
    ShowError --> ShowDialog
    ShowNetError --> ShowDialog
    
    EncryptKey --> StoreLocal
    StoreLocal --> ShowSuccess2[Show 'Assistant Ready']
    ShowSuccess2 --> EnableFeature
```

**Key Decision Points:**
1. Demo key detection bypasses validation
2. Real API validation required for production
3. Encryption before storage

---

## 5. Ask AI Conversation Flow

```mermaid
flowchart TD
    Start([Product Detail Page]) --> CheckConfig{AI Configured?}
    
    CheckConfig -->|No| DisableButton[Disable 'Ask AI']
    CheckConfig -->|Yes| ShowButton[Show 'Ask AI' Button]
    
    DisableButton --> End([End])
    
    ShowButton --> UserTaps{User Taps Button?}
    UserTaps -->|No| Wait[Wait]
    UserTaps -->|Yes| CheckOwnership{Is Product Owned?}
    
    CheckOwnership -->|Yes| LoadOwnerQuestions[Load Owned Product Questions]
    CheckOwnership -->|No| LoadPreQuestions[Load Pre-Purchase Questions]
    
    LoadOwnerQuestions --> ShowOwnerQ["1. Battery optimization<br>2. Warranty status<br>3. Repair shops<br>4. Resale value<br>5. Custom"]
    LoadPreQuestions --> ShowPreQ["1. Sustainability score<br>2. Alternatives<br>3. Care instructions<br>4. Custom"]
    
    ShowOwnerQ --> UserSelectQ{User Selects Question}
    ShowPreQ --> UserSelectQ
    
    UserSelectQ --> PreFillPrompt[Pre-fill with Context]
    PreFillPrompt --> BuildPrompt["Build Prompt:<br>- Question<br>- Product Name<br>- Barcode/EAN<br>- Ownership Status"]
    
    BuildPrompt --> CheckDemoMode{Demo Mode?}
    
    CheckDemoMode -->|Yes| SimulateResponse[Generate Simulated Response]
    CheckDemoMode -->|No| CallAI[Call AI Provider API]
    
    SimulateResponse --> StreamSim[Simulate Streaming 50ms/word]
    StreamSim --> DisplayResponse[Display Response]
    
    CallAI --> StreamAPI{API Streaming?}
    StreamAPI -->|Success| StreamReal[Stream Chunks in Real-Time]
    StreamAPI -->|Error| ShowAIError[Show AI Error Toast]
    
    ShowAIError --> EnableInput
    StreamReal --> DisplayResponse
    
    DisplayResponse --> EnableInput[Keep Input Active]
    EnableInput --> FollowUp{User Follow-Up?}
    
    FollowUp -->|Yes| AppendHistory[Add to Conversation History]
    FollowUp -->|No| End
    
    AppendHistory --> BuildPrompt
    
    Wait --> End
```

**Key Decision Points:**
1. AI configuration check gates feature
2. Ownership status determines question templates
3. Demo mode provides simulated responses
4. Conversation history maintained for context

---

## 6. Product Lifecycle Flow

```mermaid
flowchart TD
    Start([Discovery Phase]) --> ScanQR[Scan Product QR Code]
    
    ScanQR --> ViewDetails1[View Product Details]
    ViewDetails1 --> ResearchPhase{Research Phase}
    
    ResearchPhase -->|Ask AI| PrePurchaseAI["Questions:<br>- Sustainability<br>- Alternatives<br>- Care"]
    ResearchPhase -->|Read Pages| ViewDocs[View Product Pages]
    ResearchPhase -->|Compare| SearchAlts[Search Alternatives]
    
    PrePurchaseAI --> DecidePhase{Purchase Decision}
    ViewDocs --> DecidePhase
    SearchAlts --> DecidePhase
    
    DecidePhase -->|Don't Buy| StayHistory[Remain in Scan History]
    DecidePhase -->|Buy Product| PurchaseExternal[Purchase Externally]
    
    StayHistory --> End([End])
    
    PurchaseExternal --> AddToWallet[Add to My Things]
    AddToWallet --> OwnershipPhase[Ownership Phase]
    
    OwnershipPhase --> OwnerActions{Owner Actions}
    
    OwnerActions -->|Ask AI| OwnerAI["Questions:<br>- Battery care<br>- Warranty<br>- Repairs<br>- Resale"]
    OwnerActions -->|Document| AddReceipt[Upload Receipt]
    OwnerActions -->|Organize| AddTags[Tag Product]
    OwnerActions -->|Track| AddNotes[Add Notes/Photos]
    
    OwnerAI --> MaintenancePhase
    AddReceipt --> MaintenancePhase
    AddTags --> MaintenancePhase
    AddNotes --> MaintenancePhase[Maintenance Phase]
    
    MaintenancePhase --> EndOfLife{End of Life?}
    
    EndOfLife -->|Sell/Give Away| RemoveWallet[Remove from My Things]
    EndOfLife -->|Keep Using| MaintenancePhase
    
    RemoveWallet --> End
```

**Key Phases:**
1. Discovery → Research → Decision
2. Ownership → Documentation → Maintenance
3. End of Life → Removal

---

## 7. Data Synchronization Flow

```mermaid
flowchart TD
    Start([User Action]) --> DetermineAction{Action Type}
    
    DetermineAction -->|Create| CreateFlow[Create Flow]
    DetermineAction -->|Update| UpdateFlow[Update Flow]
    DetermineAction -->|Delete| DeleteFlow[Delete Flow]
    DetermineAction -->|Read| ReadFlow[Read Flow]
    
    CreateFlow --> UpdateUI1[Optimistic UI Update]
    UpdateFlow --> UpdateUI2[Optimistic UI Update]
    DeleteFlow --> UpdateUI3[Optimistic UI Update]
    
    UpdateUI1 --> APICreate[POST to Backend]
    UpdateUI2 --> APIPatch[PATCH to Backend]
    UpdateUI3 --> APIDelete[DELETE from Backend]
    
    ReadFlow --> APIGet[GET from Backend]
    
    APICreate --> ResponseCreate{Response}
    APIPatch --> ResponseUpdate{Response}
    APIDelete --> ResponseDelete{Response}
    APIGet --> ResponseRead{Response}
    
    ResponseCreate -->|Success| PersistLocal1[Persist to Local Storage]
    ResponseCreate -->|Failure| RevertUI1[Revert UI Changes]
    
    ResponseUpdate -->|Success| PersistLocal2[Update Local Storage]
    ResponseUpdate -->|Failure| RevertUI2[Revert UI Changes]
    
    ResponseDelete -->|Success| RemoveLocal[Remove from Local Storage]
    ResponseDelete -->|Failure| RevertUI3[Revert UI Changes]
    
    ResponseRead -->|Success| UpdateCache[Update Local Cache]
    ResponseRead -->|Failure| ShowCached[Show Cached Data]
    
    RevertUI1 --> ShowError1[Show Error Toast]
    RevertUI2 --> ShowError2[Show Error Toast]
    RevertUI3 --> ShowError3[Show Error Toast]
    
    PersistLocal1 --> End([End])
    PersistLocal2 --> End
    RemoveLocal --> End
    UpdateCache --> End
    ShowCached --> End
    ShowError1 --> End
    ShowError2 --> End
    ShowError3 --> End
```

**Synchronization Strategy:**
1. Optimistic UI updates (instant feedback)
2. Backend call (source of truth)
3. Local persistence (offline support)
4. Rollback on failure

---

## 8. Error Handling Flow

```mermaid
flowchart TD
    Start([API Call]) --> MakeRequest[Send HTTP Request]
    
    MakeRequest --> CheckResponse{Response Status}
    
    CheckResponse -->|200-299 Success| ParseResponse[Parse JSON Response]
    CheckResponse -->|401 Unauthorized| HandleUnauth[Clear Token, Logout]
    CheckResponse -->|404 Not Found| Show404[Show 'Not Found' Error]
    CheckResponse -->|429 Rate Limited| ShowRateLimit[Show 'Rate Limit' Error]
    CheckResponse -->|500-599 Server Error| ShowServerError[Show 'Server Error']
    CheckResponse -->|Network Timeout| HandleTimeout[Retry Logic]
    CheckResponse -->|Network Offline| ShowOffline[Show 'Offline' Error]
    
    HandleTimeout --> RetryCount{Retry Count < 3?}
    RetryCount -->|Yes| Wait[Wait Exponential Backoff]
    RetryCount -->|No| ShowTimeoutError[Show Timeout Error]
    
    Wait --> MakeRequest
    
    HandleUnauth --> NavigateLogin[Navigate to Login]
    NavigateLogin --> End([End])
    
    ParseResponse --> ParseSuccess{Parse Success?}
    ParseSuccess -->|Yes| ProcessData[Process Data]
    ParseSuccess -->|No| ShowParseError[Show 'Invalid Data' Error]
    
    ProcessData --> ValidateData{Data Valid?}
    ValidateData -->|Yes| UpdateUI[Update UI]
    ValidateData -->|No| ShowValidationError[Show Validation Error]
    
    UpdateUI --> End
    
    Show404 --> End
    ShowRateLimit --> End
    ShowServerError --> End
    ShowTimeoutError --> End
    ShowOffline --> End
    ShowParseError --> End
    ShowValidationError --> End
```

**Error Categories:**
1. Authentication errors → Logout
2. Client errors (4xx) → User notification
3. Server errors (5xx) → Retry or notify
4. Network errors → Retry with backoff

---

## 9. State Management Flow (MobX)

```mermaid
flowchart TD
    Start([User Action / API Response]) --> TriggerAction[Action Triggered]
    
    TriggerAction --> RunAction[MobX @action Method]
    RunAction --> ModifyObservable[Modify @observable State]
    
    ModifyObservable --> NotifyReactions[Notify Reactions]
    NotifyReactions --> ComputeComputed[Compute @computed Values]
    
    ComputeComputed --> UpdateObservers[Update Observer Widgets]
    UpdateObservers --> RebuildUI[Rebuild UI Components]
    
    RebuildUI --> UserSees[User Sees Updated UI]
    UserSees --> End([End])
    
    style RunAction fill:#e1f5ff
    style ModifyObservable fill:#e1f5ff
    style UpdateObservers fill:#ffe1e1
    style RebuildUI fill:#ffe1e1
```

**MobX Flow:**
1. Actions modify observable state
2. Computed values auto-recalculate
3. Observers (widgets) auto-rebuild
4. UI reflects state changes

---

## 10. Navigation Flow

```mermaid
flowchart TD
    Start([App Launch]) --> CheckAuth{Authenticated?}
    
    CheckAuth -->|No| LoginPage[Login Page]
    CheckAuth -->|Yes| HomePage[Home Page]
    
    LoginPage -->|OAuth Success| HomePage
    
    HomePage --> NavBar{Bottom Nav Selection}
    
    NavBar -->|My Things| MyThingsView[My Things View]
    NavBar -->|Search| SearchView[Search View]
    NavBar -->|QR Scanner| ScannerView[Scanner View]
    NavBar -->|Feed| FeedView[Feed View]
    NavBar -->|Menu| MenuView[Menu View]
    
    MyThingsView -->|Tap Product| ProductDetail[Product Detail Page]
    SearchView -->|Tap Result| ProductDetail
    ScannerView -->|Scan Success| ProductDetail
    FeedView -->|Tap Item| ProductDetail
    
    ProductDetail -->|Ask AI| QuestionSelect[AI Question Selection]
    ProductDetail -->|Back| HomePage
    
    QuestionSelect -->|Select Q| AIChat[AI Chat Page]
    AIChat -->|Back| ProductDetail
    
    MenuView -->|Settings| SettingsPage[Settings Page]
    MenuView -->|AI Settings| AISettingsPage[AI Settings Page]
    MenuView -->|Profile| ProfilePage[Profile Page]
    MenuView -->|Sign Out| LoginPage
    
    SettingsPage -->|Back| MenuView
    AISettingsPage -->|Back| SettingsPage
    ProfilePage -->|Back| MenuView
```

**Navigation Hierarchy:**
- Root: LoginPage or HomePage
- Main: 5 bottom navigation tabs
- Sub: Product details, settings, AI chat
- Modal: Dialogs, confirmations

---

## Summary

**Total Flows:** 10
- Authentication: 1
- Product Operations: 3
- AI Features: 2
- Data Sync: 1
- Error Handling: 1
- State Management: 1
- Navigation: 1

**Key Patterns:**
- Optimistic UI updates
- Exponential backoff retry
- State-driven UI (MobX)
- Navigation stack management
