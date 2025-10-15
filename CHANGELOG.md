# Changelog

All notable changes to Reporting Dash will be documented in this file.

## [1.4.0] - 2025-01-14

### Changed
- **KPI Card Visual Redesign**
  - Reduced main KPI number size from 56px to 48px (font-weight 800→700)
  - Reduced percentage badge size from 13px to 11px
  - Reduced "vs last year/month" label size from 11px to 9px
  - Reduced padding on percentage badges (6px 12px → 4px 10px)
  - Adjusted margins for tighter, more compact layout

- **New Static Trend Bar Icons**
  - Replaced mini line chart icons with static vertical bar charts
  - 4 purple gradient bars increasing in height (40%, 60%, 80%, 100%)
  - Positioned in top-right of KPI card header
  - Hover effect: brighter purple with glow
  - Width: 4px per bar, 3px gap between bars

### Design Rationale
- Cleaner, more professional appearance matching modern dashboard standards
- Better visual hierarchy: numbers stand out, metadata is subtle
- Static bars provide consistent visual element across all KPI cards
- Improved scannability and reduced visual clutter

### Impact
- Dashboard Overview tab: All KPI cards updated
- Email reports: All KPI cards updated with inline table-based bars
- Performance tabs: Inherits updated styles

### Technical Details
- CSS: .kpi-value (48px), .kpi-change (11px), .kpi-period (9px)
- New CSS: .kpi-trend-bars with 4 .bar children
- Email: Inline table structure for bar chart (email-safe HTML)
- Bar heights: 40%, 60%, 80%, 100% with purple gradient

## [1.3.1] - 2025-01-14

### Changed
- **Unified Number Formatting Consistency**
  - Numbers with K/M notation now ALWAYS show 1 decimal place
    - Before: 55K, 123K, 10K
    - After: 55.4K, 123.5K, 10.2K (unless exactly .0, then omit)
  - Percentages now ALWAYS round to whole numbers
    - Before: +4.4%, -2.5%, +0.3%
    - After: +4%, -2%, +0%
  - Currency formatting updated to match K/M notation
    - Before: $55K, $10K
    - After: $55.4K, $10.2K

### Examples
- **55,393** → **55.4K** (not 55K)
- **123,456** → **123.5K** (not 123K)
- **10,000** → **10K** (exactly .0, so omitted)
- **4.4%** → **4%** (rounded to whole number)
- **$2,999.68** → **$3K** (rounded)
- **$55,400** → **$55.4K** (1 decimal)

### Impact
- Applies across entire dashboard: KPIs, charts, tables, email reports
- More consistent reading experience
- Easier to compare numbers at a glance
- Still maintains precision where it matters (1 decimal for K/M)

## [1.3.0] - 2025-01-14

### Added
- **Google Ads Account-Level Metrics Support**
  - Parser now extracts Impressions, Clicks, and CTR from Campaign Performance section
  - Supports both inline format: "Impressions: 45,234" and table format
  - New dashboard section displaying account metrics with KPI cards
  - New email template section showing account performance before conversions
  - Automatic detection and formatting (K/M notation for large numbers)

### Features
- **Campaign Performance Dashboard**
  - Account metrics display: Impressions, Clicks, CTR, Total Spend
  - Visual KPI cards with change indicators
  - Responsive grid layout (auto-fit, minmax 200px)
  - Purple gradient styling matching overall theme

- **Email Report Enhancement**
  - "Google Ads Account Performance" section added
  - Shows 2-4 metrics depending on data availability
  - Inline metrics with icons (👁️ 🖱️ 📊 💰)
  - Percentage change tracking vs previous period
  - Only displays when at least one metric is available

### Data Format Support
Accepts these input formats in Campaign Performance section:

**Inline format:**
```
Impressions: 45,234
Clicks: 1,234
CTR: 2.73%
Total costs for this period: $2,999.68
```

**Table format:**
```
| Metric       | Value     | % Change |
| Impressions  | 45,234    | +12%     |
| Clicks       | 1,234     | +8%      |
| CTR          | 2.73%     | -3%      |
```

### Technical Details
- Parser functions: extractCampaignPerformance() enhanced with account metrics
- Metric naming: 'Google Ads Impressions', 'Google Ads Clicks', 'Google Ads CTR'
- Dashboard render: googleAdsAccountMetrics container (index.html:2053)
- Email template: Account metrics section (index.html:5730)
- Display logic: Only renders when data is present

## [1.2.1] - 2025-01-14

### Fixed
- **Added Missing Metrics to Priority System**
  - Customer Inquiries: 75 (high-value engagement metric)
  - Catering Requests: 70 (high-value leads)
  - Information Requests: 65 (general inquiries)
  - Direction Requests: 95 (local intent variant)
  - Contact Form: 50 (engagement)
  - Gift Cards: 45 (transaction-related)

### Context
- These metrics existed in the normalization/grouping system but were missing from the intelligent email generation priority scoring
- Now properly prioritized in email reports based on local intent value
- "Customer Inquiries" groups: inquire_now, inquiry, request_info, contact_us
- "Table Service" is a display suffix for reservation campaigns, not a separate metric

## [1.2.0] - 2025-01-14

### Parser Intelligence Upgrade
- **Unified Number Formatting System**
  - Smart rounding: 1.2K for 1,234 | 55K for 55,393 | $4.9K for $4,946
  - Context-aware formatting: currency, percentages, ratings, time
  - Consistent display across KPIs, emails, charts, tables
  - Percentages: whole numbers for 10%+, 1 decimal for <10%
  - Tabular numerals for better alignment

- **Intelligent Email Generation**
  - Metric priority scoring (Phone Calls: 100, Directions: 95, Views: 30)
  - Local intent metrics prioritized over vanity metrics
  - Context-aware growth filtering (ignores 2→10 = +400% as meaningless)
  - Geographic relevance scoring (home market > distant spikes)
  - Absolute value + percentage for true impact assessment

- **Smart Metric Filtering**
  - High-priority metrics: lower volume threshold (50+)
  - Medium-priority: require 200+ volume
  - Low-priority: require 500+ volume
  - Filters out "vanity growth" (high % on tiny numbers)
  - Prioritizes business-driving metrics

- **Geographic Intelligence**
  - Auto-detect home market from restaurant name
  - Home territory changes always relevant (even small %)
  - Non-home markets need both volume AND growth
  - Score-based relevance filtering (60+ threshold)
  - Example: Nashville 2,466 users +19% > Birmingham 1,080 users +151%

- **Enhanced Value Parsing**
  - Handles: —, N/A, ∞, +100%, 1.2K, 1.5M, New, multiple values
  - Special character normalization (🟩→positive, ⬆→up)
  - Unicode to ASCII conversion
  - Robust percentage extraction

### Technical Improvements
- New formatting utilities: formatNumber, formatCurrency, formatRating, formatTime, formatChange
- parseAndNormalizeValue for robust input handling
- calculateMetricImpactScore for intelligent prioritization
- shouldMentionGrowth logic prevents irrelevant insights
- scoreGeographicInsight for location-based filtering
- detectHomeMarket mapping for 8+ restaurant markets

### Quality of Life
- Backward compatible with existing code
- No breaking changes to HTML structure
- All improvements in JavaScript layer only
- Maintains all existing features and workflows

## [1.1.0] - 2025-01-14

### Enhanced
- **Visual Design Overhaul** - Complete CSS-only visual enhancement
  - Advanced glassmorphism effects with backdrop blur
  - Animated mesh gradient backgrounds
  - Enhanced color palette with new accent colors
  - Gradient text effects for headers and KPI values
  - Improved shadow system with multiple depth levels

- **Card & Component Styling**
  - KPI cards with radial glow effects on hover
  - Smooth scale and translate animations
  - Enhanced border gradients
  - Backdrop filter effects for depth
  - Staggered entrance animations (50-300ms delays)

- **Interactive Elements**
  - Button shimmer effects on hover
  - Tab transitions with gradient overlays
  - Section tab animations with slide effects
  - Chart bars with shimmer animations
  - Pulse glow effects on active elements

- **Typography Improvements**
  - Gradient text for main headings
  - Tabular numerals for better number alignment
  - Enhanced font weights (700-800 for emphasis)
  - Drop shadow effects for depth
  - Better letter spacing throughout

- **Accessibility Features**
  - Enhanced focus states for keyboard navigation
  - Reduced motion support for users with vestibular disorders
  - High contrast mode support
  - Print stylesheet optimizations
  - Smooth scrolling with motion preferences
  - Custom selection colors

- **Animation System**
  - New animations: fadeInGlow, pulseGlow, slideInFromLeft, slideInFromRight, scaleIn
  - Shimmer effects on bars and buttons
  - Mesh glow background animation (20s cycle)
  - Configurable animation timing variables

### Technical
- Added CSS custom properties for shadows and transitions
- Improved color system with glow variants
- Enhanced responsive breakpoints
- Better z-index layering for effects

## [1.0.0] - 2025-01-14

### Added
- Initial release of Marketing Analytics Dashboard
- Multi-format report parser supporting tables, bullets, and narrative text
- Interactive three-tab dashboard interface
- Google Business Profile metrics visualization
- Google Analytics performance tracking
- Google Ads conversion reporting
- Professional email report generator
- Restaurant client contact mapping (20+ clients)
- Dark mode support for email reports
- Inline email editing capabilities
- Report history tracking with localStorage
- Responsive design for mobile, tablet, and desktop
- Sample data loader for testing
- YoY and MoM comparison charts
