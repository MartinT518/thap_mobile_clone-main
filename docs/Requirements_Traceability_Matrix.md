# Requirements Traceability Matrix (RTM)
## Thap Mobile Application

**Version:** 2.0  
**Date:** November 18, 2025  
**Purpose:** Track requirements from PRD through design, development, and testing

---

## RTM Overview

This matrix ensures:
- All requirements are implemented
- No functionality is orphaned
- Test coverage is complete
- Changes are tracked

**Legend:**
- ✅ Completed
- 🟡 In Progress
- ⚪ Planned
- ❌ Blocked

---

## 1. Authentication & User Management

| Req ID | Requirement | PRD Ref | FRD Ref | Use Case | User Story | Design | Dev Status | Test Status | Notes |
|--------|-------------|---------|---------|----------|------------|--------|------------|-------------|-------|
| AUTH-001 | Google OAuth Sign-In | P0 Feature #7 | FR-AUTH-001 | UC-AUTH-001 | US-001 | ✅ | ✅ | ✅ | Implemented |
| AUTH-002 | Session Restoration | P0 Feature #7 | FR-AUTH-002 | UC-AUTH-002 | US-002 | ✅ | ✅ | ✅ | Implemented |
| AUTH-003 | User Profile Management | P1 Feature #7 | FR-AUTH-003 | - | US-016, US-017 | ✅ | ✅ | ✅ | Language & country |
| AUTH-004 | Sign Out | P0 Feature #7 | FR-AUTH-004 | UC-AUTH-003 | - | ✅ | ✅ | ✅ | Implemented |
| AUTH-005 | Token Management | P0 NFR Security | FR-AUTH-001 | - | - | ✅ | ✅ | ✅ | Encrypted storage |

---

## 2. Product Scanning & Recognition

| Req ID | Requirement | PRD Ref | FRD Ref | Use Case | User Story | Design | Dev Status | Test Status | Notes |
|--------|-------------|---------|---------|----------|------------|--------|------------|-------------|-------|
| SCAN-001 | QR Code Scanning | P0 Feature #1 | FR-SCAN-001 | UC-PRODUCT-001 | US-004 | ✅ | ✅ | ✅ | Mobile scanner lib |
| SCAN-002 | Camera Permission | P0 Feature #1 | FR-SCAN-001 | UC-PRODUCT-001 | US-004 | ✅ | ✅ | ✅ | Permission handling |
| SCAN-003 | Product Recognition | P0 Feature #1 | FR-SCAN-001 | UC-PRODUCT-001 | US-004 | ✅ | ✅ | ✅ | API integration |
| SCAN-004 | Scan History Tracking | P1 Feature #3 | FR-SCAN-002 | - | US-006 | ✅ | ✅ | ✅ | Last 100 items |
| SCAN-005 | Error Handling | P0 Feature #1 | FR-SCAN-001 | UC-PRODUCT-001 | US-004 | ✅ | ✅ | ✅ | Invalid QR, not found |

---

## 3. Product Wallet Management

| Req ID | Requirement | PRD Ref | FRD Ref | Use Case | User Story | Design | Dev Status | Test Status | Notes |
|--------|-------------|---------|---------|----------|------------|--------|------------|-------------|-------|
| WALLET-001 | Add Product | P0 Feature #2 | FR-WALLET-001 | UC-PRODUCT-002 | US-007 | ✅ | ✅ | ✅ | Instance creation |
| WALLET-002 | Remove Product | P0 Feature #2 | FR-WALLET-002 | UC-PRODUCT-003 | US-008 | ✅ | ✅ | ✅ | With confirmation |
| WALLET-003 | View My Things | P0 Feature #2 | FR-WALLET-003 | UC-PRODUCT-004 | - | ✅ | ✅ | ✅ | Grid/list view |
| WALLET-004 | Tag Filtering | P2 Feature #8 | FR-WALLET-004 | UC-PRODUCT-005 | US-009 | ⚪ | ⚪ | ⚪ | Planned Sprint 3 |
| WALLET-005 | Product Documentation | P2 Feature #9 | FR-WALLET-005 | - | US-010, US-021, US-022 | ⚪ | ⚪ | ⚪ | Planned Sprint 4 |
| WALLET-006 | Product Sharing | P2 Feature #10 | - | - | - | ⚪ | ⚪ | ⚪ | Planned Sprint 5 |

---

## 4. AI Assistant

| Req ID | Requirement | PRD Ref | FRD Ref | Use Case | User Story | Design | Dev Status | Test Status | Notes |
|--------|-------------|---------|---------|----------|------------|--------|------------|-------------|-------|
| AI-001 | Provider Selection | P1 Feature #4 | FR-AI-001 | UC-AI-001 | US-011 | ✅ | ✅ | ✅ | 4 providers |
| AI-002 | API Key Management | P1 Feature #4 | FR-AI-001 | UC-AI-001 | US-011 | ✅ | ✅ | ✅ | Encrypted storage |
| AI-003 | Demo Mode | P1 Feature #4 | FR-AI-005 | UC-AI-004 | US-012 | ✅ | ✅ | ✅ | Simulated responses |
| AI-004 | Ask AI Button | P1 Feature #4 | FR-AI-002 | - | - | ✅ | ✅ | ✅ | Contextual display |
| AI-005 | Question Templates (Owned) | P1 Feature #4 | FR-AI-003 | UC-AI-002 | US-013 | ✅ | ✅ | ✅ | 4 templates + custom |
| AI-006 | Question Templates (Pre-purchase) | P1 Feature #4 | FR-AI-003 | UC-AI-003 | US-014 | ✅ | ✅ | ✅ | 3 templates + custom |
| AI-007 | Chat Interface | P1 Feature #4 | FR-AI-004 | UC-AI-002 | US-013, US-015 | ✅ | ✅ | ✅ | Streaming responses |
| AI-008 | Conversation History | P1 Feature #4 | FR-AI-004 | UC-AI-002 | US-015 | ✅ | ✅ | ✅ | Multi-turn support |
| AI-009 | OpenAI Integration | P1 Feature #4 | FR-AI-001 | - | - | ✅ | ✅ | ✅ | GPT-3.5-turbo |
| AI-010 | Google Gemini Integration | P1 Feature #4 | FR-AI-001 | - | - | ✅ | ✅ | ✅ | gemini-pro |
| AI-011 | Perplexity Integration | P1 Feature #4 | FR-AI-001 | - | - | ✅ | ✅ | ✅ | llama-3.1-sonar |
| AI-012 | Deepseek Integration | P1 Feature #4 | FR-AI-001 | - | - | ✅ | ✅ | ✅ | deepseek-chat |
| AI-013 | Error Handling | P1 Feature #4 | FR-AI-004 | - | - | ✅ | ✅ | ✅ | Toast notifications |

---

## 5. Product Information Display

| Req ID | Requirement | PRD Ref | FRD Ref | Use Case | User Story | Design | Dev Status | Test Status | Notes |
|--------|-------------|---------|---------|----------|------------|--------|------------|-------------|-------|
| PRODUCT-001 | Product Detail View | P0 Feature #5 | FR-PRODUCT-001 | UC-PRODUCT-001 | US-005 | ✅ | ✅ | ✅ | All fields |
| PRODUCT-002 | Image Display | P0 Feature #5 | FR-PRODUCT-001 | - | - | ✅ | ✅ | ✅ | Lazy loading |
| PRODUCT-003 | Specifications | P0 Feature #5 | FR-PRODUCT-001 | - | - | ✅ | ✅ | ✅ | Key-value pairs |
| PRODUCT-004 | Care Instructions | P0 Feature #5 | FR-PRODUCT-001 | - | - | ✅ | ✅ | ✅ | Markdown support |
| PRODUCT-005 | Sustainability Info | P0 Feature #5 | FR-PRODUCT-001 | - | - | ✅ | ✅ | ✅ | Score display |
| PRODUCT-006 | Multi-Page Documents | P2 Feature #5 | FR-PRODUCT-002 | - | - | ⚪ | ⚪ | ⚪ | Planned |

---

## 6. Settings & Preferences

| Req ID | Requirement | PRD Ref | FRD Ref | Use Case | User Story | Design | Dev Status | Test Status | Notes |
|--------|-------------|---------|---------|----------|------------|--------|------------|-------------|-------|
| SETTINGS-001 | Language Selection | P1 Feature #6 | FR-SETTINGS-001 | - | US-016 | ✅ | ✅ | ✅ | 14 languages |
| SETTINGS-002 | Country Selection | P1 Feature #6 | FR-SETTINGS-002 | - | US-017 | ✅ | ✅ | ✅ | Dropdown |
| SETTINGS-003 | Privacy Controls | P2 Feature #6 | FR-SETTINGS-003 | - | US-018 | ⚪ | ⚪ | ⚪ | Planned Sprint 4 |
| SETTINGS-004 | Data Deletion | P2 Feature #6 | FR-SETTINGS-003 | UC-ADMIN-001 | - | ⚪ | ⚪ | ⚪ | Planned |
| SETTINGS-005 | AI Assistant Settings | P1 Feature #4 | FR-AI-001 | UC-AI-001 | US-011 | ✅ | ✅ | ✅ | Dedicated page |

---

## 7. Search & Discovery

| Req ID | Requirement | PRD Ref | FRD Ref | Use Case | User Story | Design | Dev Status | Test Status | Notes |
|--------|-------------|---------|---------|----------|------------|--------|------------|-------------|-------|
| SEARCH-001 | Product Search | P2 Feature | FR-SEARCH-001 | UC-SEARCH-001 | US-019 | ⚪ | ⚪ | ⚪ | Planned Sprint 3 |
| SEARCH-002 | Search Debouncing | P2 Feature | FR-SEARCH-001 | - | - | ⚪ | ⚪ | ⚪ | 300ms delay |
| SEARCH-003 | Search Results | P2 Feature | FR-SEARCH-001 | - | - | ⚪ | ⚪ | ⚪ | Grid display |
| FEED-001 | User Feed | P2 Feature | FR-FEED-001 | UC-FEED-001 | US-020 | ⚪ | ⚪ | ⚪ | Planned Sprint 4 |
| FEED-002 | Feed Personalization | P2 Feature | FR-FEED-001 | - | - | ⚪ | ⚪ | ⚪ | Algorithm TBD |

---

## 8. Non-Functional Requirements

| Req ID | Requirement | PRD Ref | Test Method | Status | Notes |
|--------|-------------|---------|-------------|--------|-------|
| NFR-001 | App Launch Time < 3s | NFR Performance | Performance test | ✅ | Measured: 2.1s |
| NFR-002 | Scan to Display < 2s | NFR Performance | Integration test | ✅ | Measured: 1.4s |
| NFR-003 | AI First Token < 1s | NFR Performance | Integration test | ✅ | Measured: 0.8s (avg) |
| NFR-004 | API Response < 500ms p95 | NFR Scalability | Load test | ✅ | Backend SLA |
| NFR-005 | 99.9% Uptime | NFR Reliability | Monitoring | 🟡 | In progress |
| NFR-006 | OAuth 2.0 Security | NFR Security | Security audit | ✅ | Passed |
| NFR-007 | API Key Encryption | NFR Security | Code review | ✅ | AES-256 |
| NFR-008 | HTTPS Only | NFR Security | Config review | ✅ | Enforced |
| NFR-009 | Mobile-First Design | NFR Usability | UX review | ✅ | Portrait optimized |
| NFR-010 | One-Handed Operation | NFR Usability | UX test | ✅ | Bottom nav |
| NFR-011 | WCAG 2.1 AA | NFR Usability | Accessibility audit | 🟡 | 85% compliant |
| NFR-012 | Offline Mode (Read) | NFR Reliability | Integration test | ⚪ | Planned Sprint 6 |

---

## 9. API Integration Requirements

| Req ID | Endpoint | Method | FRD Ref | Status | Test Coverage |
|--------|----------|--------|---------|--------|---------------|
| API-001 | /v2/user/authenticate | POST | FR-AUTH-001 | ✅ | ✅ |
| API-002 | /v2/user/profile | GET | FR-AUTH-003 | ✅ | ✅ |
| API-003 | /v2/user/profile | PATCH | FR-AUTH-003 | ✅ | ✅ |
| API-004 | /v2/user/scan_history | GET | FR-SCAN-002 | ✅ | ✅ |
| API-005 | /v2/user/scan_history/{id} | DELETE | FR-SCAN-002 | ✅ | ✅ |
| API-006 | /v2/tings/list | GET | FR-WALLET-003 | ✅ | ✅ |
| API-007 | /v2/tings/add | POST | FR-WALLET-001 | ✅ | ✅ |
| API-008 | /v2/tings/{id}/remove | DELETE | FR-WALLET-002 | ✅ | ✅ |
| API-009 | /v2/products/{id} | GET | FR-PRODUCT-001 | ✅ | ✅ |
| API-010 | /v2/app | GET | FR-SETTINGS-001 | ✅ | ✅ |
| API-011 | OpenAI Chat Completions | POST | FR-AI-004 | ✅ | ✅ |
| API-012 | Gemini Generate Content | POST | FR-AI-004 | ✅ | ✅ |
| API-013 | Perplexity Chat | POST | FR-AI-004 | ✅ | ✅ |
| API-014 | Deepseek Chat | POST | FR-AI-004 | ✅ | ✅ |

---

## 10. Test Coverage Matrix

| Feature Area | Unit Tests | Integration Tests | E2E Tests | Coverage % |
|--------------|------------|-------------------|-----------|------------|
| Authentication | ✅ 15 tests | ✅ 5 tests | ✅ 3 scenarios | 92% |
| Product Scanning | ✅ 12 tests | ✅ 8 tests | ✅ 4 scenarios | 88% |
| Wallet Management | ✅ 18 tests | ✅ 6 tests | ✅ 5 scenarios | 94% |
| AI Assistant | ✅ 25 tests | ✅ 12 tests | ✅ 6 scenarios | 91% |
| Settings | ✅ 8 tests | ✅ 4 tests | ✅ 2 scenarios | 85% |
| UI Components | ✅ 30 tests | - | - | 90% |
| **Total** | **108 tests** | **35 tests** | **20 scenarios** | **90%** |

---

## 11. Sprint Planning Matrix

| Sprint | Requirements | Status | Velocity (Points) | Completion % |
|--------|--------------|--------|-------------------|--------------|
| Sprint 1 | AUTH-001 to AUTH-005, SCAN-001 to SCAN-005 | ✅ | 15 / 15 | 100% |
| Sprint 2 | WALLET-001 to WALLET-003, SETTINGS-001 to SETTINGS-002 | ✅ | 12 / 12 | 100% |
| Sprint 3 | WALLET-004, SEARCH-001 to SEARCH-003 | ⚪ | 0 / 13 | 0% |
| Sprint 4 | WALLET-005, FEED-001, SETTINGS-003 | ⚪ | 0 / 10 | 0% |
| Sprint 5 | AI-001 to AI-013 | ✅ | 23 / 23 | 100% |
| Sprint 6+ | NFR-012, WALLET-006, PRODUCT-006 | ⚪ | 0 / 8 | 0% |

---

## 12. Defect Traceability

| Defect ID | Requirement | Severity | Status | Fix Sprint | Notes |
|-----------|-------------|----------|--------|------------|-------|
| BUG-001 | AUTH-002 | High | ✅ Fixed | Sprint 2 | Token expiry edge case |
| BUG-002 | SCAN-001 | Medium | ✅ Fixed | Sprint 1 | Camera permission iOS |
| BUG-003 | AI-007 | High | ✅ Fixed | Sprint 5 | Streaming stops on error |
| BUG-004 | AI-004 | Low | ✅ Fixed | Sprint 5 | Button disabled state |
| BUG-005 | PRODUCT-001 | Medium | ✅ Fixed | Sprint 2 | Image loading timeout |
| BUG-006 | WALLET-003 | Low | ✅ Fixed | Sprint 2 | Empty state layout |

---

## 13. Change Request Tracking

| CR ID | Description | Impact | Requirements Affected | Status | Decision |
|-------|-------------|--------|----------------------|--------|----------|
| CR-001 | Add demo mode for AI | Medium | AI-003, AI-005 | ✅ Approved | Implemented Sprint 5 |
| CR-002 | Support 4 AI providers | High | AI-001, AI-009-012 | ✅ Approved | Implemented Sprint 5 |
| CR-003 | Add tag filtering | Low | WALLET-004 | ✅ Approved | Planned Sprint 3 |
| CR-004 | Add push notifications | Medium | New requirement | ⚪ Pending | Under review |
| CR-005 | Barcode scanning support | High | SCAN-001 | ❌ Rejected | Out of scope V2 |

---

## 14. Requirements Completion Summary

| Category | Total Reqs | Completed | In Progress | Planned | Blocked |
|----------|------------|-----------|-------------|---------|---------|
| Authentication | 5 | 5 (100%) | 0 | 0 | 0 |
| Scanning | 5 | 5 (100%) | 0 | 0 | 0 |
| Wallet | 6 | 3 (50%) | 0 | 3 | 0 |
| AI Assistant | 13 | 13 (100%) | 0 | 0 | 0 |
| Product Display | 6 | 5 (83%) | 0 | 1 | 0 |
| Settings | 5 | 3 (60%) | 0 | 2 | 0 |
| Search & Feed | 5 | 0 (0%) | 0 | 5 | 0 |
| Non-Functional | 12 | 9 (75%) | 2 | 1 | 0 |
| **TOTAL** | **57** | **43 (75%)** | **2 (4%)** | **12 (21%)** | **0 (0%)** |

---

## 15. Verification & Validation

| Requirement | Verification Method | Validation Method | Status |
|-------------|---------------------|-------------------|--------|
| AUTH-001 | Code review + Unit test | User acceptance test | ✅ |
| SCAN-001 | Integration test | Field testing | ✅ |
| WALLET-001 | Unit + Integration test | UAT | ✅ |
| AI-001 | Unit test + API mocking | Beta user feedback | ✅ |
| AI-007 | Integration test | Performance monitoring | ✅ |
| NFR-001 | Performance profiling | Production monitoring | ✅ |
| NFR-011 | Accessibility scanner | Manual audit | 🟡 |

---

## Stakeholder Sign-Off

| Role | Name | Date | Signature | Status |
|------|------|------|-----------|--------|
| Product Owner | [Name] | Nov 18, 2025 | [Pending] | ⚪ |
| Tech Lead | [Name] | Nov 18, 2025 | [Pending] | ⚪ |
| QA Lead | [Name] | Nov 18, 2025 | [Pending] | ⚪ |
| UX Lead | [Name] | Nov 18, 2025 | [Pending] | ⚪ |

---

## Document Control

**Last Updated:** November 18, 2025  
**Version:** 2.0  
**Next Review:** December 1, 2025  
**Owner:** Product Team  
**Distribution:** All stakeholders

**Change Log:**
- Nov 18, 2025: Initial RTM creation (v2.0)
- Nov 18, 2025: Added AI Assistant requirements
- Nov 18, 2025: Updated completion percentages
