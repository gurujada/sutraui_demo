# Sutra UI Demo Site - Implementation Plan

> Living document - updated as discussion progresses

## Overview

A **shadcn-inspired documentation site** built entirely with Sutra UI components, demonstrating the "atomic → composed → view" philosophy. The site itself showcases what's possible with pure Phoenix LiveView.

**Key Technical Note:** All Sutra UI hooks are **runtime colocated hooks** (Phoenix 1.8+). This is a major differentiator - no separate JS files, hooks live alongside component templates.

---

## Design Vision (per SKILL.md)

### Aesthetic Direction: **Editorial/Magazine meets Developer Tool**

Not another generic docs site. We're building something that feels like a **beautifully typeset technical magazine** - refined, confident, with editorial flair.

**Tone:** Sophisticated minimalism with sharp accents. Clean but not sterile. Professional but not boring.

**Typography:**
- Display font: Something distinctive (NOT Inter, Roboto, Arial) - consider JetBrains Mono for code, paired with a refined serif or geometric sans for headings
- Generous line-height, comfortable reading measure
- Typography as a feature, not an afterthought

**Color & Theme:**
- Dominant neutral base with **one bold accent color** per theme
- High contrast, crisp edges
- Dark mode as a first-class citizen (not an afterthought)
- Themes: Blue (default), Green, Rose, Orange, Violet - each with light/dark variants

**Spatial Composition:**
- Generous whitespace
- Asymmetric sidebar layout
- Component demos in clean "stages" with subtle borders/shadows
- Preview/Code tabs feel tactile

**Motion & Details:**
- Subtle page transitions
- Code block hover states
- Smooth theme switching
- Copy button feedback

**What makes it UNFORGETTABLE:**
- The quality of the code examples (syntax highlighting that's beautiful)
- The smoothness of Preview/Code switching
- Components that feel alive, not static screenshots

---

## Design Decisions

### Preview/Code Display
- Use Sutra's `<.tabs>` component to toggle between Preview and Code views
- Meta benefit: demonstrates the tabs component while being functional
- Code blocks are copyable with one-click (toast feedback on copy)

### Theming Approach
- **Theme = Color palette with BOTH light and dark modes**
- Each theme changes `--primary`, `--secondary`, etc. CSS variables
- Themes available: Blue (default), Green, Rose, Orange, Violet
- Theme switcher in header: pick theme + separate light/dark toggle
- `/themes` page: ON HOLD until all components done

### Props Documentation Style
- **NO boring props table** - props are shown through examples
- Each significant prop gets its own section with:
  - Section heading (e.g., "Variants", "Sizes", "With Icon")
  - Live preview
  - Copyable code snippet
- Skip obvious/trivial props like `disabled`, `class`, `id` unless special behavior
- **Include special behaviors, gotchas, and notes from component docs**

### Syntax Highlighting

**Makeup vs Plain `<pre>` Tags:**

| | Plain `<pre>` | Makeup |
|---|---|---|
| **Output** | Plain monospace text | Colored syntax (keywords, strings, functions, etc.) |
| **How it works** | Renders text as-is | Parses code with lexers, wraps tokens in `<span>` with CSS classes |
| **Dependencies** | None | `makeup` + lexer packages |

**Decision:** Use Makeup for code blocks in docs pages. The editorial theme demands polish - plain `<pre>` feels unfinished. Makeup provides:
- Visual hierarchy within code (keywords pop, strings distinct, comments fade)
- Matches the "considered, intentional" editorial aesthetic
- CSS syntax colors already defined in `app.css` (lines 467-477)

**Exception:** Very short snippets (2-3 lines) on landing page can use plain `<pre>` - acceptable given brevity.

**Implementation:**
- Use `makeup` + `makeup_elixir` + `makeup_html` for server-side highlighting
- Pure Elixir, zero JS dependencies
- Color tokens work with dark mode automatically
- `code_block` component in `docs_components.ex` handles this

### Search (Phase 4)
- **Command palette** (`Cmd+K`) using Sutra's `<.command>` component
- Sidebar provides browsable navigation; search for quick jumps

### Composed Components
- No `@doc`, `@moduledoc`, or `attr` declarations needed for now
- Keep it simple and functional

---

## Site Structure & Pages

### Landing Page (`/`)
- Hero section with tagline: "Pure Phoenix LiveView Components"
- Key selling points:
  - Zero JS dependencies (runtime colocated hooks)
  - 100% Accessible (WCAG 2.1 AA)
  - Dark mode built-in
  - Phoenix 1.8+ / Tailwind v4
- Quick install snippet (copyable)
- "Get Started" and "View Components" CTAs

### Documentation Pages

#### Introduction (`/docs`)
- What is Sutra UI?
- Philosophy: atomic components, server-driven, CSS-first theming
- Runtime colocated hooks explanation
- When to use Sutra UI

#### Installation (`/docs/installation`)
Detailed step-by-step:
1. **Requirements** - Elixir 1.14+, Phoenix 1.8+, LiveView 1.1+, Tailwind v4
2. **Add dependency** - `{:sutra_ui, "~> 0.1"}`
3. **Remove core_components.ex** - Sutra replaces it
4. **Configure Tailwind CSS v4** - app.css imports
5. **Setup JavaScript hooks** - app.js changes (colocated hooks auto-extracted)
6. **Import components** - my_app_web.ex changes
7. **Verify installation** - simple test

#### Theming (`/docs/theming`)
- How CSS variables work
- List of CSS variables
- Creating custom themes
- Dark mode implementation

### Component Pages (`/docs/components/:component`)

Structure:
```
Component Name
Brief description

[Default Example - Preview/Code tabs with Copy]

## Installation
"Available after installing Sutra UI" (or special setup if needed)

## Usage
Basic usage code snippet

## Examples

### Variants
[Preview/Code tabs]

### Sizes  
[Preview/Code tabs]

### [More props...]

## Notes
Special behaviors, gotchas, accessibility notes
```

---

## Site Layout

### Header (sticky)
- Logo: "Sutra UI" (text, distinctive typography)
- Navigation: Docs | Components
- Search trigger: `⌘K`
- Theme controls: Theme picker + Light/Dark toggle
- GitHub link

### Sidebar (fixed, scrollable)
```
Getting Started
  ├─ Introduction
  ├─ Installation
  └─ Theming

Components
  ├─ Button
  ├─ Badge
  ├─ Card
  ├─ Input
  ├─ Select
  ├─ Dialog
  ├─ Toast
  ├─ Tabs
  ├─ Table
  └─ Dropdown Menu
```

### Main Content Area
- Max-width container (~800px)
- Editorial typography
- Generous spacing

---

## File Structure

```
lib/
├── sutraui_demo/
│   └── component_docs.ex          # Component metadata
│
└── sutraui_demo_web/
    ├── components/
    │   ├── layouts/
    │   │   ├── root.html.heex
    │   │   └── docs.html.heex     # NEW
    │   ├── layouts.ex
    │   └── docs_components.ex      # NEW - composed components
    │
    ├── live/
    │   ├── landing_live.ex
    │   ├── docs/
    │   │   ├── introduction_live.ex
    │   │   ├── installation_live.ex
    │   │   └── theming_live.ex
    │   └── components/
    │       ├── button_live.ex
    │       ├── badge_live.ex
    │       ├── card_live.ex
    │       ├── input_live.ex
    │       ├── select_live.ex
    │       ├── dialog_live.ex
    │       ├── toast_live.ex
    │       ├── tabs_live.ex
    │       ├── table_live.ex
    │       └── dropdown_menu_live.ex
    │
    └── router.ex

assets/
├── css/
│   └── app.css
└── js/
    └── app.js
```

---

## Routes

```elixir
scope "/", SutrauiDemoWeb do
  pipe_through :browser

  live "/", LandingLive, :index

  live "/docs", Docs.IntroductionLive, :index
  live "/docs/installation", Docs.InstallationLive, :index
  live "/docs/theming", Docs.ThemingLive, :index

  live "/docs/components/button", Components.ButtonLive, :index
  live "/docs/components/badge", Components.BadgeLive, :index
  live "/docs/components/card", Components.CardLive, :index
  live "/docs/components/input", Components.InputLive, :index
  live "/docs/components/select", Components.SelectLive, :index
  live "/docs/components/dialog", Components.DialogLive, :index
  live "/docs/components/toast", Components.ToastLive, :index
  live "/docs/components/tabs", Components.TabsLive, :index
  live "/docs/components/table", Components.TableLive, :index
  live "/docs/components/dropdown-menu", Components.DropdownMenuLive, :index
end
```

---

## Implementation Phases

**IMPORTANT:** After each phase, PAUSE. User previews in browser. Only after approval and git commit do we proceed to next phase.

### Phase 1: Foundation
1. [ ] Install and configure sutra_ui dependency
2. [ ] Add makeup + makeup_elixir + makeup_html
3. [ ] Remove core_components.ex, configure sutra_ui
4. [ ] Configure Tailwind CSS v4 with sutra_ui
5. [ ] Configure app.js with sutra hooks
6. [ ] Create docs layout (header + sidebar + main)
7. [ ] Build docs_components.ex (component_demo, code_block, etc.)
8. [ ] Set up all routes
9. [ ] Landing page
10. [ ] Installation page

**→ PAUSE for review**

### Phase 2: First 10 Components
For each component:
1. Read Sutra source + docs for props/slots/behaviors
2. Document metadata
3. Build LiveView with examples
4. Verify in browser

Components:
1. [ ] Button
2. [ ] Badge
3. [ ] Card
4. [ ] Input
5. [ ] Select
6. [ ] Dialog
7. [ ] Toast
8. [ ] Tabs
9. [ ] Table
10. [ ] Dropdown Menu

**→ PAUSE for review**

### Phase 3: Polish & Additional Pages
1. [ ] Introduction page
2. [ ] Theming page
3. [ ] Theme switcher (predefined themes)
4. [ ] Code copy with toast feedback
5. [ ] Mobile responsive sidebar

**→ PAUSE for review**

### Phase 4: Wow Features
1. [ ] Command palette search (Cmd+K)
2. [ ] Smooth page transitions
3. [ ] Any refinements

**→ PAUSE for review**

### Phase 5: Remaining Components
- All remaining ~34 components (separate plan)

---

## Component Checklist Template

For each component:

### [ ] Component: {NAME}

#### 1. Source & Docs Analysis
- [ ] Read `lib/sutra_ui/{component}.ex`
- [ ] Read component `@moduledoc` for special behaviors
- [ ] Extract all `attr` definitions
- [ ] Extract all `slot` definitions
- [ ] Note helper functions
- [ ] Identify props to demo vs skip
- [ ] Note gotchas, accessibility info, usage patterns

#### 2. Metadata Documentation
- [ ] Add to plan/component_docs with complete info

#### 3. LiveView Implementation
- [ ] Create LiveView file
- [ ] docs_header with title/description
- [ ] Default example
- [ ] Installation section (if special)
- [ ] Usage section
- [ ] Examples for each significant prop
- [ ] Notes section with behaviors/gotchas

#### 4. Verification
- [ ] All previews work
- [ ] Code blocks correct
- [ ] Copy works
- [ ] Light/dark mode works
- [ ] User approval

---

## Phase 1 Detailed Checklist

### 1.1 Install sutra_ui
- [ ] Add `{:sutra_ui, path: "../sutra_ui"}` to mix.exs
- [ ] Run `mix deps.get`

### 1.2 Add syntax highlighting
- [ ] Add makeup deps to mix.exs
- [ ] Run `mix deps.get`

### 1.3 Configure sutra_ui
- [ ] Delete core_components.ex
- [ ] Update sutraui_demo_web.ex with `use SutraUI`

### 1.4 Configure Tailwind CSS v4
- [ ] Update assets/css/app.css with sutra imports

### 1.5 Configure JavaScript
- [ ] Update assets/js/app.js with sutra hooks

### 1.6 Create docs layout
- [ ] Header component
- [ ] Sidebar component  
- [ ] Main content wrapper
- [ ] Apply editorial typography/spacing

### 1.7 Build docs_components.ex
- [ ] `component_demo/1` with tabs
- [ ] `code_block/1` with makeup
- [ ] `docs_header/1`
- [ ] `docs_sidebar/1`
- [ ] `section_heading/1`
- [ ] Copy-to-clipboard hook

### 1.8 Set up routes
- [ ] All routes in router.ex
- [ ] Placeholder LiveViews

### 1.9 Landing page
- [ ] Hero section
- [ ] Feature highlights
- [ ] Install snippet
- [ ] CTAs

### 1.10 Installation page
- [ ] All 7 steps with code blocks

---

## Component Metadata (Extracted from Source)

### 1. Button (`SutraUI.Button`)

**Description:** A versatile button component with multiple variants, sizes, and navigation support. Renders as `<button>`, `<a>`, or LiveView navigation link depending on props.

**Props:**
| Prop | Type | Default | Values | Demo? |
|------|------|---------|--------|-------|
| `variant` | string | `"primary"` | `primary`, `secondary`, `destructive`, `outline`, `ghost`, `link` | YES |
| `size` | string | `"default"` | `default`, `sm`, `lg`, `icon` | YES |
| `type` | string | `"button"` | `button`, `submit`, `reset` | NO |
| `loading` | boolean | `false` | - | YES |
| `disabled` | boolean | `false` | - | NO |
| `navigate` | string | `nil` | - | YES |
| `patch` | string | `nil` | - | NO |
| `href` | string | `nil` | - | NO |
| `class` | any | `nil` | - | NO |

**Slots:** `inner_block` (required)

**Special Behaviors:**
- Auto-renders as `<a>` when `navigate`, `patch`, or `href` provided
- Loading state sets `aria-busy="true"` and disables button
- Icon buttons (`size="icon"`) MUST have `aria-label`

**Sections to Demo:**
1. Default
2. Variants (all 6)
3. Sizes (all 4)
4. With Icon
5. Loading State
6. As Link (navigate)

---

### 2. Badge (`SutraUI.Badge`)

**Description:** Small status indicator for counts, labels, or status. Renders as `<span>` or `<a>`.

**Props:**
| Prop | Type | Default | Values | Demo? |
|------|------|---------|--------|-------|
| `variant` | string | `"default"` | `default`, `secondary`, `destructive`, `success`, `outline` | YES |
| `href` | string | `nil` | - | YES |
| `class` | any | `nil` | - | NO |

**Slots:** `inner_block` (required)

**Sections to Demo:**
1. Default
2. Variants (all 5)
3. As Link

---

### 3. Card (`SutraUI.Card`)

**Description:** Container with header, content, and footer. Uses semantic HTML (`<header>`, `<section>`, `<footer>`).

**Props:**
| Prop | Type | Default | Demo? |
|------|------|---------|-------|
| `class` | string | `nil` | NO |

**Slots:**
| Slot | Required | Attributes |
|------|----------|------------|
| `header` | NO | `class` |
| `content` | YES | `class` |
| `footer` | NO | `class` |

**Sections to Demo:**
1. Full Card (all slots)
2. Simple (content only)
3. With Form

---

### 4. Input (`SutraUI.Input`)

**Description:** Form input field with optional label. Integrates with Phoenix forms via `field` prop.

**Props:**
| Prop | Type | Default | Demo? |
|------|------|---------|-------|
| `field` | FormField | `nil` | YES |
| `type` | string | `"text"` | YES |
| `label` | string | `nil` | YES |
| `id` | string | `nil` | NO |
| `name` | string | `nil` | NO |
| `value` | any | `nil` | NO |
| `placeholder` | string | `nil` | NO |
| `class` | string | `nil` | NO |

**Slots:** None

**Special Behaviors:**
- When `label` provided, renders `<label>` before input with matching `for`
- Extracts `id`, `name`, `value` from FormField when provided

**Sections to Demo:**
1. Default
2. With Label
3. Input Types (email, password, number, date)
4. Form Integration

---

### 5. Select (`SutraUI.Select`)

**Description:** Custom select with search/filter (combobox pattern). Full keyboard navigation. Uses runtime colocated `.Select` hook.

**Props:**
| Prop | Type | Default | Values | Demo? |
|------|------|---------|--------|-------|
| `id` | string | REQUIRED | - | NO |
| `name` | string | `nil` | - | NO |
| `value` | string | `nil` | - | NO |
| `searchable` | boolean | `false` | - | YES |
| `search_placeholder` | string | `"Search entries..."` | - | NO |
| `empty_message` | string | `"No results found"` | - | NO |
| `disabled` | boolean | `false` | - | NO |

**Slots:**
- `trigger` (optional) - custom trigger content
- `inner_block` (required) - options

**Sub-components:**
- `select_option/1` - `value` (required), `label`, `disabled`
- `select_group/1` - `label` (required)
- `select_separator/1`

**Keyboard Navigation:**
- Enter/Space: Open or select
- Escape: Close
- Arrow Up/Down: Navigate
- Home/End: Jump
- A-Z: Jump to letter

**Special Behaviors:**
- Renders hidden `<input>` for form compatibility
- Dispatches `change` event on selection
- WAI-ARIA combobox pattern

**Sections to Demo:**
1. Default
2. Searchable
3. With Groups
4. Custom Trigger
5. Form Integration

---

### 6. Dialog (`SutraUI.Dialog`)

**Description:** Modal dialog using native `<dialog>` element. Uses runtime colocated `.Dialog` hook.

**Props:**
| Prop | Type | Default | Demo? |
|------|------|---------|-------|
| `id` | string | REQUIRED | NO |
| `class` | string | `nil` | NO |

**Slots:**
- `inner_block` (required) - main content
- `title` (optional)
- `description` (optional)
- `footer` (optional)

**Helper Functions:**
```elixir
SutraUI.Dialog.show_dialog(js \\ %JS{}, id)
SutraUI.Dialog.hide_dialog(js \\ %JS{}, id)
```

**Special Behaviors:**
- Uses native `showModal()` / `close()`
- Escape key closes
- Backdrop click closes
- Focus trapped automatically
- `aria-labelledby` / `aria-describedby` auto-set

**Sections to Demo:**
1. Basic Dialog
2. Confirmation
3. Form Dialog
4. Chained JS Commands

---

### 7. Toast (`SutraUI.Toast`)

**Description:** Temporary notifications. Flash-based or programmatic. Uses runtime colocated `.ToastContainer` hook.

**toast_container/1:**
| Prop | Type | Default |
|------|------|---------|
| `flash` | map | REQUIRED |
| `class` | string | `nil` |

**toast/1:**
| Prop | Type | Default | Values | Demo? |
|------|------|---------|--------|-------|
| `id` | string | REQUIRED | - | NO |
| `variant` | string | `"default"` | `default`, `success`, `destructive` | YES |

**toast/1 Slots:** `title`, `description`, `action`

**Programmatic Usage:**
```elixir
push_event(socket, "toast", %{
  variant: "success",
  title: "Title",
  description: "Details",
  duration: 5000  # 0 = no auto-dismiss
})
```

**Special Behaviors:**
- Flash-based: cleared on navigate or close
- Programmatic: auto-dismiss after duration
- `role="status"`, `aria-live="polite"`

**Sections to Demo:**
1. Flash-based
2. Variants
3. With Description
4. With Action
5. Programmatic

---

### 8. Tabs (`SutraUI.Tabs`)

**Description:** Tabbed interface. Client-side switching via JS commands. Uses runtime colocated `.Tabs` hook for keyboard nav.

**Props:**
| Prop | Type | Default | Demo? |
|------|------|---------|-------|
| `id` | string | REQUIRED | NO |
| `default_value` | string | REQUIRED | NO |
| `class` | string | `nil` | NO |

**Slots:**
| Slot | Required | Attributes |
|------|----------|------------|
| `tab` | YES | `value` (required), `disabled` |
| `panel` | YES | `value` (required) |

**Keyboard Navigation:**
- Arrow Left/Right: Previous/next tab
- Home/End: First/last tab

**Special Behaviors:**
- No server round-trip for tab changes
- Panels have `tabindex="0"` for keyboard access
- Full ARIA tablist/tab/tabpanel pattern

**Sections to Demo:**
1. Basic Tabs
2. With Disabled Tab
3. With Icons

---

### 9. Table (`SutraUI.Table`)

**Description:** Two variants - simple wrapper and data-driven.

**table/1 (wrapper):**
| Prop | Type | Default |
|------|------|---------|
| `class` | string | `nil` |

**Slots:** `inner_block` (required)

**data_table/1:**
| Prop | Type | Default |
|------|------|---------|
| `rows` | list | REQUIRED |
| `class` | string | `nil` |

**data_table/1 Slots:**
| Slot | Required | Attributes |
|------|----------|------------|
| `caption` | NO | - |
| `col` | YES | `label` (required), `class` |
| `action` | NO | `label` |
| `footer` | NO | - |

**Sections to Demo:**
1. Simple Table
2. Data Table
3. With Actions
4. With Caption/Footer

---

### 10. Dropdown Menu (`SutraUI.DropdownMenu`)

**Description:** Dropdown with full keyboard navigation. Uses runtime colocated `.DropdownMenu` hook.

**Props:**
| Prop | Type | Default | Values | Demo? |
|------|------|---------|--------|-------|
| `id` | string | REQUIRED | - | NO |
| `side` | string | `"bottom"` | `top`, `bottom`, `left`, `right` | YES |
| `align` | string | `"start"` | `start`, `end`, `center` | YES |

**Slots:**
- `trigger` (required)
- `inner_block` (required)

**Sub-components:**
- `dropdown_item/1` - `variant` (`default`/`destructive`), `disabled`, `shortcut`
- `dropdown_separator/1`
- `dropdown_label/1`

**Keyboard Navigation:**
- Arrow Up/Down: Navigate items
- Home/End: First/last
- Enter/Space: Activate
- Escape: Close

**Special Behaviors:**
- Auto-closes on outside click
- Closes other popovers when opened
- WAI-ARIA menu pattern

**Sections to Demo:**
1. Basic
2. With Shortcuts
3. With Groups/Labels
4. Destructive Item
5. Positioning (side/align)

---

## Notes

- Each component page = self-contained, copyable examples
- Code examples = real, working code
- Show components in context where helpful
- Keep descriptions concise
- Highlight runtime colocated hooks as a differentiator
- All hooks are `.HookName` format (dot prefix for colocated)
