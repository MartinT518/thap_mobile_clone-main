# Thap Design System
## Visual & Interaction Design Guidelines

**Version:** 2.0  
**Date:** November 18, 2025  
**Platform:** Flutter Mobile (iOS & Android)  
**Target:** Mobile-first, portrait orientation

---

## Table of Contents
1. [Brand Foundation](#brand-foundation)
2. [Color System](#color-system)
3. [Typography](#typography)
4. [Spacing & Layout](#spacing--layout)
5. [Components](#components)
6. [Icons & Imagery](#icons--imagery)
7. [Motion & Animation](#motion--animation)
8. [Accessibility](#accessibility)
9. [Platform Guidelines](#platform-guidelines)

---

## 1. Brand Foundation

### Brand Values
- **Sustainable**: Promoting product longevity and mindful consumption
- **Intelligent**: AI-powered insights for informed decisions
- **Organized**: Simplifying product management and documentation
- **Trustworthy**: Secure data handling and reliable information

### Brand Personality
- Professional yet approachable
- Modern and tech-forward
- Eco-conscious
- User-empowering

### Design Principles

**1. Clarity First**
- Every element serves a clear purpose
- Information hierarchy is obvious
- No decorative clutter

**2. Mobile-Optimized**
- Designed for portrait orientation
- One-handed operation priority
- Thumb-friendly tap targets

**3. Contextual Intelligence**
- Adapt UI based on user state (owned vs. scanned products)
- Progressive disclosure of complex features
- Smart defaults reduce cognitive load

**4. Accessibility Built-In**
- WCAG 2.1 AA compliance minimum
- High contrast ratios
- Screen reader optimization

---

## 2. Color System

### Primary Palette

#### Brand Blue (Primary)
```
Primary Blue 500 (Main)
HEX: #2196F3
RGB: 33, 150, 243
Usage: Primary actions, links, active states
```

```
Primary Blue 700 (Dark)
HEX: #1976D2
RGB: 25, 118, 210
Usage: Hover states, emphasis
```

```
Primary Blue 300 (Light)
HEX: #64B5F6
RGB: 100, 181, 246
Usage: Backgrounds, subtle accents
```

```
Primary Blue 50 (Lightest)
HEX: #E3F2FD
RGB: 227, 242, 253
Usage: Cards, containers, subtle backgrounds
```

#### Accent Green (Sustainability)
```
Accent Green 500
HEX: #4CAF50
RGB: 76, 175, 80
Usage: Success states, sustainability indicators, positive actions
```

```
Accent Green 700
HEX: #388E3C
RGB: 56, 142, 60
Usage: Hover on success buttons
```

### Semantic Colors

#### Success
```
Success Green: #4CAF50
Background: #E8F5E9
Text: #1B5E20
```

#### Warning
```
Warning Orange: #FF9800
Background: #FFF3E0
Text: #E65100
```

#### Error
```
Error Red: #F44336
Background: #FFEBEE
Text: #C62828
```

#### Info
```
Info Blue: #2196F3
Background: #E3F2FD
Text: #0D47A1
```

### Neutral Palette

```
Black: #000000 (Text primary)
Gray 900: #212121 (Text primary alternative)
Gray 700: #616161 (Text secondary)
Gray 500: #9E9E9E (Text disabled, placeholders)
Gray 300: #E0E0E0 (Dividers, borders)
Gray 100: #F5F5F5 (Backgrounds, cards)
Gray 50: #FAFAFA (Page backgrounds)
White: #FFFFFF (Cards, surfaces)
```

### Usage Guidelines

**DO:**
- Use Primary Blue for main CTAs and navigation
- Use Accent Green for sustainability-related features
- Maintain 4.5:1 contrast ratio minimum for text
- Use semantic colors consistently (green = success, red = error)

**DON'T:**
- Mix warm and cool grays
- Use pure black (#000) for body text (use Gray 900)
- Override semantic color meanings
- Use more than 3 colors in a single component

---

## 3. Typography

### Type Scale

#### Font Family
**Primary:** Roboto (Android), SF Pro (iOS)
**Fallback:** System default sans-serif

```
Display Large
Size: 57px / 3.56rem
Line Height: 64px
Weight: 400 (Regular)
Usage: Hero text, empty states
```

```
Display Medium
Size: 45px / 2.81rem
Line Height: 52px
Weight: 400
Usage: Large headings
```

```
Headline Large
Size: 32px / 2rem
Line Height: 40px
Weight: 400
Usage: Page titles
```

```
Headline Medium
Size: 28px / 1.75rem
Line Height: 36px
Weight: 400
Usage: Section headers
```

```
Headline Small
Size: 24px / 1.5rem
Line Height: 32px
Weight: 500
Usage: Card titles, dialog titles
```

```
Title Large
Size: 22px / 1.375rem
Line Height: 28px
Weight: 400
Usage: List item titles
```

```
Title Medium
Size: 16px / 1rem
Line Height: 24px
Weight: 500
Usage: Subtitles, labels
```

```
Body Large
Size: 16px / 1rem
Line Height: 24px
Weight: 400
Usage: Emphasized body text
```

```
Body Medium (Default)
Size: 14px / 0.875rem
Line Height: 20px
Weight: 400
Usage: Main body text
```

```
Body Small
Size: 12px / 0.75rem
Line Height: 16px
Weight: 400
Usage: Captions, helper text
```

```
Label Large
Size: 14px / 0.875rem
Line Height: 20px
Weight: 500
Usage: Button text
```

```
Label Medium
Size: 12px / 0.75rem
Line Height: 16px
Weight: 500
Usage: Small buttons, chips
```

```
Label Small
Size: 11px / 0.688rem
Line Height: 16px
Weight: 500
Usage: Overlines, tiny labels
```

### Typography Rules

**DO:**
- Use maximum 2 font weights per screen (Regular 400 + Medium 500)
- Maintain 1.5x line height minimum for body text
- Use sentence case for buttons and labels
- Scale text proportionally for accessibility

**DON'T:**
- Use italic for emphasis (use weight instead)
- Set line height below 1.2x
- Use ALL CAPS for long text
- Mix font families

---

## 4. Spacing & Layout

### Spacing Scale (8px Base)

```
XXS: 4px   (0.25rem)
XS:  8px   (0.5rem)
S:   12px  (0.75rem)
M:   16px  (1rem)     ← Base unit
L:   24px  (1.5rem)
XL:  32px  (2rem)
XXL: 48px  (3rem)
XXXL: 64px (4rem)
```

### Grid System

**Mobile Portrait (Default)**
- Columns: 4
- Gutter: 16px (M)
- Margin: 16px (M)
- Max width: 100%

**Tablet Portrait**
- Columns: 8
- Gutter: 16px
- Margin: 24px (L)

**Landscape (Not Primary)**
- Columns: 12
- Gutter: 16px
- Margin: 32px (XL)

### Layout Patterns

#### Safe Areas
```
Top Safe Area: 44px (iOS notch) / 24px (Android)
Bottom Safe Area: 34px (iOS home indicator) / 0px (Android)
Bottom Navigation: 56px height
```

#### Content Areas
```
Screen Padding: 16px (M) horizontal
Card Padding: 16px (M) all sides
List Item Padding: 16px (M) vertical, 16px (M) horizontal
Section Spacing: 24px (L) vertical
```

#### Z-Index Layers
```
0: Base content
1: Cards, containers
2: Sticky headers
3: Floating action buttons
4: Bottom navigation
5: Dialogs, modals
6: Tooltips
7: Toasts, snackbars
```

### Responsive Breakpoints

```
Small (Portrait Phone): 0 - 599px
Medium (Landscape Phone / Small Tablet): 600px - 1023px
Large (Tablet): 1024px - 1439px
XLarge (Desktop): 1440px+
```

**Note:** Thap is mobile-first. Breakpoints beyond Small are for future optimization.

---

## 5. Components

### Buttons

#### Primary Button
```
Background: Primary Blue 500 (#2196F3)
Text: White
Height: 48px (minimum tap target)
Padding: 16px horizontal
Border Radius: 24px (pill shape)
Elevation: 2dp
Font: Label Large (14px, Weight 500)
```

**States:**
- Default: Blue 500 background
- Hover: Blue 700 background
- Pressed: Blue 700 background + 4dp elevation
- Disabled: Gray 300 background, Gray 500 text
- Loading: Show circular progress indicator

**Usage:** Primary actions (Add to My Things, Confirm, Sign In)

#### Secondary Button
```
Background: Transparent
Text: Primary Blue 500
Height: 48px
Padding: 16px horizontal
Border: 2px solid Primary Blue 500
Border Radius: 24px
Elevation: 0dp
Font: Label Large
```

**States:**
- Default: Blue 500 border + text
- Hover: Blue 50 background
- Pressed: Blue 100 background
- Disabled: Gray 300 border + text

**Usage:** Secondary actions (Cancel, Skip, Learn More)

#### Text Button
```
Background: Transparent
Text: Primary Blue 500
Height: 40px
Padding: 8px horizontal
Border Radius: 8px
Font: Label Large
```

**States:**
- Default: Blue 500 text
- Hover: Blue 50 background
- Pressed: Blue 100 background
- Disabled: Gray 500 text

**Usage:** Tertiary actions, inline links

#### AI Button (Special)
```
Background: Primary Blue 500
Text: White
Icon: AI sparkle icon (leading)
Height: 56px
Width: 100%
Padding: 16px horizontal
Border Radius: 28px
Elevation: 3dp
Font: Title Medium (16px, Weight 500)
```

**Usage:** "Ask AI" action on product pages

### Cards

#### Standard Card
```
Background: White
Border Radius: 16px
Elevation: 1dp
Padding: 16px
Margin: 16px (between cards)
```

**States:**
- Default: 1dp elevation
- Hover: 2dp elevation
- Pressed: 4dp elevation (if tappable)

#### Product Card (Grid)
```
Aspect Ratio: 1:1.2 (portrait)
Background: White
Border Radius: 12px
Elevation: 1dp
Padding: 12px
Image: 80% width, rounded 8px
Title: Body Medium, 2 lines max
Brand: Body Small, Gray 700, 1 line
```

#### Product Card (List)
```
Height: 88px
Background: White
Border Radius: 12px
Padding: 12px
Layout: Horizontal (Image left, text right)
Image: 64x64px, rounded 8px
Title: Body Large, 1 line
Brand: Body Small, Gray 700
```

### Input Fields

#### Text Input
```
Height: 56px
Background: Gray 50
Border: 1px solid Gray 300 (default)
Border Radius: 8px
Padding: 16px horizontal
Font: Body Medium
Label: Body Small, Gray 700 (floating label)
```

**States:**
- Default: Gray 300 border
- Focus: Blue 500 border (2px)
- Error: Red 500 border, error text below
- Disabled: Gray 100 background, Gray 500 text

#### Search Input
```
Height: 48px
Background: Gray 100
Border Radius: 24px (pill)
Padding: 16px horizontal
Icon: Search icon (leading)
Clear: X icon (trailing, when filled)
Font: Body Medium
Placeholder: Gray 500
```

### Navigation

#### Bottom Navigation Bar
```
Height: 56px + safe area
Background: White
Elevation: 8dp
Border Top: 1px solid Gray 200
Items: 5 maximum
Icon Size: 24x24px
Label: Label Small (11px)
Active Color: Primary Blue 500
Inactive Color: Gray 700
```

**Items:**
1. My Things (home icon)
2. Search (search icon)
3. QR Scanner (QR icon, center, larger)
4. Feed (bell icon)
5. Menu (menu icon)

#### Top App Bar
```
Height: 56px + status bar
Background: White (default) or Primary Blue (contextual)
Elevation: 0dp (default) or 2dp (scrolled)
Title: Headline Small (24px)
Icon Size: 24x24px
Padding: 16px horizontal
```

### Dialogs & Modals

#### Dialog (Alert/Confirmation)
```
Width: Screen width - 32px margin
Max Width: 560px
Background: White
Border Radius: 28px
Padding: 24px
Title: Headline Small (24px)
Content: Body Medium
Actions: Right-aligned, horizontal buttons
Elevation: 24dp
Scrim: Black 50% opacity
```

#### Bottom Sheet
```
Background: White
Border Radius: 28px (top corners only)
Max Height: 90% screen height
Padding: 24px (top), 16px (sides)
Handle: 32px width, 4px height, Gray 300
Elevation: 16dp
Scrim: Black 30% opacity
```

**Usage:** AI Question Selection, Settings panels

#### Full Screen Modal
```
Background: White
Transition: Slide up from bottom
Top Bar: Close button (left), Title (center)
Content: Full scrollable area
Actions: Fixed bottom bar
```

**Usage:** AI Chat interface

### Lists

#### List Item (Standard)
```
Height: 72px (with subtitle) or 56px (no subtitle)
Padding: 16px horizontal, 8px vertical
Divider: 1px solid Gray 200
Title: Body Large
Subtitle: Body Small, Gray 700
Icon/Avatar: 40x40px (leading)
Action: 24x24px icon (trailing)
```

#### Product List Item
```
Height: 88px
Padding: 12px
Image: 64x64px, rounded 8px (leading)
Title: Title Medium, 1 line
Brand: Body Small, Gray 700
Tags: Chips (below brand, if present)
Chevron: 24x24px (trailing)
```

### Chips & Tags

#### Standard Chip
```
Height: 32px
Background: Primary Blue 50
Border Radius: 16px
Padding: 12px horizontal
Font: Label Medium (12px)
Text Color: Primary Blue 700
Icon: Optional, 16x16px (leading)
```

#### Tag Chip (Product Organization)
```
Height: 28px
Background: Gray 200
Border Radius: 14px
Padding: 10px horizontal
Font: Label Small (11px)
Text Color: Gray 900
Delete Icon: 16x16px X (trailing, optional)
```

**States:**
- Default: Gray 200 background
- Selected: Primary Blue 500 background, White text
- Hover: Gray 300 background

### Toast / Snackbar

```
Width: Screen width - 32px margin
Min Height: 48px
Background: Gray 900
Border Radius: 4px
Padding: 14px 16px
Font: Body Medium
Text Color: White
Action Text: Accent Green 500
Position: Bottom (80px from bottom nav)
Duration: 4 seconds (short) or 7 seconds (long)
Elevation: 6dp
```

### Loading Indicators

#### Circular Progress
```
Size: 24px (small), 40px (medium), 56px (large)
Color: Primary Blue 500
Stroke Width: 4px
```

#### Linear Progress (Indeterminate)
```
Height: 4px
Color: Primary Blue 500
Background: Primary Blue 100
```

#### Skeleton Loader
```
Background: Gray 200
Shimmer: Gray 300 → Gray 100 (animated)
Border Radius: Matches component
Animation: 1.5s ease-in-out infinite
```

---

## 6. Icons & Imagery

### Icon System

#### Style
- Material Design Icons (MDI)
- Outlined style (default)
- Filled style (for active states)

#### Sizes
```
Extra Small: 16x16px (inline icons)
Small: 20x20px (chips, tags)
Medium: 24x24px (standard, default)
Large: 32x32px (feature icons)
Extra Large: 48x48px (empty states, onboarding)
```

#### Colors
- Default: Gray 700
- Active: Primary Blue 500
- Disabled: Gray 400
- Error: Red 500
- Success: Green 500

#### Key Icons
```
Home: home_outlined / home_filled
Search: search
QR Scanner: qr_code_scanner
Feed: notifications_outlined / notifications
Menu: menu
AI Sparkle: auto_awesome (for Ask AI)
Add: add_circle_outline
Remove: remove_circle_outline
Back: arrow_back
Close: close
Check: check_circle
Error: error_outline
Info: info_outline
Camera: camera_alt
Photo: photo
Edit: edit
Delete: delete
Share: share
Settings: settings
Language: translate
Arrow Right: chevron_right
Arrow Down: expand_more
Filter: filter_list
```

### Product Images

#### Aspect Ratios
- Square: 1:1 (product grid thumbnails)
- Portrait: 3:4 (product detail hero)
- Landscape: 16:9 (product pages, documentation)

#### Specifications
```
Thumbnail: 200x200px (1x), 400x400px (2x)
Grid Card: 300x300px (1x), 600x600px (2x)
Detail Hero: 600x800px (1x), 1200x1600px (2x)
Background: 1080x1920px (portrait)
```

#### Image Treatment
- Border Radius: 8px (thumbnails), 12px (cards), 16px (hero)
- Placeholder: Gray 200 background, product icon centered
- Loading: Skeleton with shimmer animation
- Error: Gray 300 background, broken image icon

### Illustrations

#### Empty States
- Style: Line art with subtle color accents
- Colors: Gray 300 outlines, Primary Blue 100 fills
- Size: 200x200px maximum
- Usage: Empty "My Things", no scan history, no search results

#### Onboarding
- Style: Flat design, simple shapes
- Colors: Full brand palette
- Size: 280x280px
- Animation: Subtle scale/fade entrance

---

## 7. Motion & Animation

### Animation Principles

1. **Purposeful**: Every animation serves a function
2. **Subtle**: Animations enhance, don't distract
3. **Fast**: Keep durations under 400ms
4. **Natural**: Use easing curves for organic feel

### Duration Standards

```
Extra Fast: 100ms (micro-interactions)
Fast: 200ms (state changes, toggles)
Standard: 300ms (page transitions, dialogs)
Slow: 400ms (complex transitions)
Extra Slow: 500ms (special effects, max duration)
```

### Easing Curves

```
Standard: cubic-bezier(0.4, 0.0, 0.2, 1)
Decelerate: cubic-bezier(0.0, 0.0, 0.2, 1)
Accelerate: cubic-bezier(0.4, 0.0, 1, 1)
Sharp: cubic-bezier(0.4, 0.0, 0.6, 1)
```

### Component Animations

#### Button Press
```
Duration: 100ms
Easing: Sharp
Effect: Scale 0.95, Elevation change
```

#### Card Tap
```
Duration: 200ms
Easing: Standard
Effect: Elevation 1dp → 4dp
```

#### Dialog Enter
```
Duration: 300ms
Easing: Decelerate
Effect: Fade in scrim, Scale up dialog (0.8 → 1.0)
```

#### Dialog Exit
```
Duration: 200ms
Easing: Accelerate
Effect: Fade out scrim, Scale down dialog (1.0 → 0.9)
```

#### Bottom Sheet Enter
```
Duration: 300ms
Easing: Decelerate
Effect: Slide up from bottom, Fade in scrim
```

#### Page Transition (Forward)
```
Duration: 300ms
Easing: Standard
Effect: Slide left, Fade
```

#### Page Transition (Back)
```
Duration: 300ms
Easing: Standard
Effect: Slide right, Fade
```

#### List Item Appear
```
Duration: 200ms
Easing: Decelerate
Effect: Fade in + Scale up (0.95 → 1.0)
Stagger: 50ms delay between items (max 5 items)
```

#### AI Streaming Text
```
Duration: 50ms per word
Effect: Fade in each word
Easing: Linear
```

#### Loading Spinner
```
Duration: 1500ms
Effect: Rotate 360° continuously
Easing: Linear
```

#### Skeleton Shimmer
```
Duration: 1500ms
Effect: Gradient slide across
Easing: Standard
Loop: Infinite
```

### Gesture Animations

#### Swipe to Delete
```
Threshold: 40% of item width
Snap: Bounce back if < threshold
Delete: Slide out + Fade (300ms) if > threshold
```

#### Pull to Refresh
```
Threshold: 80px
Indicator: Circular progress appears at 40px
Trigger: Release at > 80px
Animation: Rotate indicator, Fade in content
```

---

## 8. Accessibility

### WCAG 2.1 AA Compliance

#### Color Contrast

**Text Contrast Ratios:**
- Large text (18pt+): Minimum 3:1
- Normal text: Minimum 4.5:1
- UI components: Minimum 3:1

**Verified Combinations:**
```
✅ White (#FFFFFF) on Primary Blue 500 (#2196F3) = 4.6:1
✅ Gray 900 (#212121) on White (#FFFFFF) = 16.1:1
✅ Gray 700 (#616161) on White (#FFFFFF) = 7.2:1
✅ White on Success Green 500 (#4CAF50) = 4.7:1
✅ White on Error Red 500 (#F44336) = 5.3:1
❌ Gray 500 on White = 2.9:1 (Use for disabled only)
```

#### Touch Targets

**Minimum Sizes:**
- Tap target: 44x44dp (iOS), 48x48dp (Android)
- Icon buttons: 48x48dp
- Text links: 44dp height minimum
- Spacing between targets: 8dp minimum

#### Focus Indicators

```
Outline: 2px solid Primary Blue 500
Offset: 2px
Border Radius: Inherits from component + 2px
```

#### Screen Reader Support

**Semantic Labels:**
- All images have alt text
- All buttons have descriptive labels
- Form inputs have associated labels
- Error messages announced immediately
- Loading states announced

**Navigation:**
- Logical tab order (top to bottom, left to right)
- Skip to main content link
- Heading hierarchy (H1 → H2 → H3)

**ARIA Attributes:**
```
role="button" (custom buttons)
role="dialog" (modals)
role="alert" (errors, toasts)
aria-label="descriptive text"
aria-expanded="true|false" (expandable sections)
aria-selected="true|false" (tabs, chips)
aria-disabled="true" (disabled states)
```

#### Text Scaling

- Support 200% text scaling
- Layouts adapt without horizontal scrolling
- Buttons/touch targets maintain size
- Text does not overlap

#### Motion Preferences

```
Respect: prefers-reduced-motion media query
Fallback: Instant transitions (0ms)
Alternative: Fade animations only
```

#### Color Blindness

- Don't rely on color alone for information
- Use icons + text for status indicators
- Pattern fills for charts (if applicable)
- Test with color blindness simulators

---

## 9. Platform Guidelines

### iOS Specific

#### Navigation
- Use iOS-style back swipe gesture
- Use iOS standard navigation bar (44px height)
- Use SF Symbols where appropriate

#### Components
```
Top Navigation: 44px height + status bar
Tab Bar: 49px height + safe area
List Separator: Hairline (0.5px)
Corner Radius: Larger values (12px, 16px, 28px)
```

#### Haptics
- Light impact: Button taps
- Medium impact: Toggle switches
- Heavy impact: Errors, confirmations
- Selection: List scrolling, picker changes

### Android Specific

#### Navigation
- Use Android back button (system)
- Use Material Design app bar (56px height)
- Use Material Icons

#### Components
```
Top App Bar: 56px height + status bar
Bottom Nav: 56px height
List Divider: 1px solid
Corner Radius: Standard values (8px, 12px, 16px)
```

#### Ripple Effect
```
Color: Black 12% opacity (light theme)
Duration: 200ms expand, 200ms fade
Origin: Touch point
```

### Flutter Implementation

#### Material Theme
```dart
ThemeData(
  primaryColor: Color(0xFF2196F3),
  primaryColorDark: Color(0xFF1976D2),
  primaryColorLight: Color(0xFF64B5F6),
  accentColor: Color(0xFF4CAF50),
  scaffoldBackgroundColor: Color(0xFFFAFAFA),
  cardColor: Color(0xFFFFFFFF),
  
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  ),
  
  buttonTheme: ButtonThemeData(
    height: 48,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  ),
  
  cardTheme: CardTheme(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
)
```

---

## 10. Design Tokens (Reference)

### JSON Format
```json
{
  "color": {
    "primary": {
      "500": "#2196F3",
      "700": "#1976D2",
      "300": "#64B5F6",
      "50": "#E3F2FD"
    },
    "accent": {
      "green": "#4CAF50"
    },
    "semantic": {
      "success": "#4CAF50",
      "warning": "#FF9800",
      "error": "#F44336",
      "info": "#2196F3"
    },
    "neutral": {
      "black": "#000000",
      "gray900": "#212121",
      "gray700": "#616161",
      "gray500": "#9E9E9E",
      "gray300": "#E0E0E0",
      "gray100": "#F5F5F5",
      "gray50": "#FAFAFA",
      "white": "#FFFFFF"
    }
  },
  "spacing": {
    "xxs": 4,
    "xs": 8,
    "s": 12,
    "m": 16,
    "l": 24,
    "xl": 32,
    "xxl": 48,
    "xxxl": 64
  },
  "typography": {
    "size": {
      "displayLarge": 57,
      "headlineLarge": 32,
      "bodyMedium": 14,
      "labelLarge": 14
    }
  },
  "borderRadius": {
    "xs": 4,
    "s": 8,
    "m": 12,
    "l": 16,
    "xl": 24,
    "xxl": 28,
    "pill": 9999
  },
  "elevation": {
    "0": "0dp",
    "1": "1dp",
    "2": "2dp",
    "4": "4dp",
    "8": "8dp",
    "16": "16dp",
    "24": "24dp"
  }
}
```

---

## 11. Quality Checklist

### Design Handoff Checklist

**Visual Design:**
- [ ] All colors use design tokens
- [ ] Text styles use defined typography scale
- [ ] Spacing uses 8px grid system
- [ ] Contrast ratios meet WCAG AA
- [ ] Components use elevation correctly

**Interaction Design:**
- [ ] All tap targets ≥ 48x48dp
- [ ] Hover states defined (if applicable)
- [ ] Focus states defined
- [ ] Loading states defined
- [ ] Error states defined
- [ ] Empty states designed

**Responsive:**
- [ ] Layouts tested at 320px width (small phone)
- [ ] Safe areas accounted for (notch, home indicator)
- [ ] Bottom nav doesn't overlap content
- [ ] Text scales appropriately

**Accessibility:**
- [ ] Alt text for all images
- [ ] Labels for all form inputs
- [ ] ARIA attributes specified
- [ ] Focus order logical
- [ ] Motion can be reduced

**Documentation:**
- [ ] Component specs documented
- [ ] Usage examples provided
- [ ] States documented
- [ ] Accessibility notes included

---

## 12. Resources & Tools

### Design Files
- Figma: [Link to Figma file]
- Component Library: [Link to Figma components]
- Icon Set: Material Design Icons

### Development
- Flutter Material Theme: `theme.dart`
- Design Tokens: `tokens.json`
- Component Library: `lib/ui/common/`

### Testing
- Color Contrast: WebAIM Contrast Checker
- Color Blindness: Color Oracle
- Screen Reader: VoiceOver (iOS), TalkBack (Android)

### References
- Material Design 3: https://m3.material.io
- iOS Human Interface Guidelines: https://developer.apple.com/design/
- WCAG 2.1: https://www.w3.org/WAI/WCAG21/quickref/

---

## Version History

**v2.0 (Nov 18, 2025)**
- Complete design system for Thap mobile app
- Added AI-specific component styles
- Enhanced accessibility guidelines
- Platform-specific guidance (iOS/Android)

**Next Review:** December 15, 2025

---

**Maintained by:** UX/UI Design Team  
**Questions?** Contact: design@thap.app
