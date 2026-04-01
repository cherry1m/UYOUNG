# AGENTS.md

This file defines repository-specific rules for AI coding agents working in this project.

## Project Goal

UYOUNG is a Flutter mobile app that centers on:

- home interactions such as attendance, pearls, and notifications
- memory island creation, invitation, and shared memories
- calendar-based memory browsing
- mypage/profile management
- Supabase-backed authentication and user data flows

## Current Architecture

This repository currently uses a layered structure built around:

- `lib/data`
- `lib/src/view`
- `lib/src/viewModel`

Do not introduce a new top-level architecture such as `lib/features` unless the user explicitly asks for a migration.

## Directory Rules

- Put models in `lib/data/model/<domain>`.
- Put repositories in `lib/data/repositories/<domain>`.
- Put external or persistence access code in `lib/data/sources/...`.
- Put Supabase-specific implementations in `lib/data/sources/supabase/...`.
- Put screens in `lib/src/view/pages/<domain>`.
- Put reusable shared UI in `lib/src/view/common/...`.
- Put `ChangeNotifier` view models in `lib/src/viewModel/<domain>`.

## State Management

- Use `provider` + `ChangeNotifier` as the default state management approach.
- UI should not call Supabase directly.
- Screens should talk to ViewModels.
- ViewModels should talk to repositories.
- Repositories should talk to sources/services.

## Data Integration Rules

- Prefer real Supabase-backed flows over adding new dummy data.
- If a screen already exists with placeholder UI, preserve the visual structure and replace only the data flow unless the user asks for redesign.
- Keep RPC usage inside service/source classes.
- When integrating user-specific data, always use the current authenticated user from Supabase through the existing project patterns.

## UI Rules

- Preserve the current visual language unless the user requests redesign.
- Reuse existing pages and connected flows before creating new temporary pages.
- Put reusable widgets in `common` only when they are used in 2 or more places.
- Avoid leaving fake/image-only screens connected when a real screen already exists.
- New or modified screens must be responsive across common mobile widths.
- Avoid relying only on fixed `Positioned`, fixed widths, and fixed heights when the layout contains text or repeated cards.
- Prefer `Expanded`, `Flexible`, `LayoutBuilder`, `MediaQuery`, and `FittedBox` when adapting existing designs.
- If a screen is image-driven, preserve the visual design but make the tappable and text areas resilient on smaller devices.
- When fixing overflow bugs, prefer local layout corrections over redesigning the whole screen.

## Naming

- Dart file names must use `snake_case.dart`.
- Widget classes use `PascalCase`.
- ViewModel classes must end with `ViewModel`.
- Repository classes must end with `Repository`.
- Service/source classes should reflect their responsibility clearly, for example `profile_service.dart`, `notification_service.dart`.

## Implementation Constraints

- Do not perform large-scale architecture refactors unless explicitly requested.
- Keep changes scoped to the user request.
- Prefer small, reviewable commits.
- When replacing placeholder logic, remove obsolete navigation/imports if they are no longer used.
- Add comments only when they materially improve readability.

## Git Workflow

- Do not work directly on `develop`.
- Create a fresh branch from the latest `develop` for each logical task.
- Do not reuse old feature branches that already carried merged or mixed work.
- Keep commits scoped to one logical change.
- For docs/process updates, use a dedicated docs branch and PR.

## Validation

Run this after code changes when relevant:

```bash
flutter analyze
```

Run targeted validation first when possible, then broaden if needed.

## Project-Specific Guidance

- This project still contains some dummy/local data sources mixed with Supabase-backed flows.
- When touching an area that uses dummy data, prefer documenting or isolating the legacy path rather than rewriting unrelated flows.
- Be careful with existing mixed naming such as `pages`, `presentation`, and older typo-based files. Do not rename broadly unless the user asks for cleanup.
- When fixing bugs in navigation/provider flows, prefer minimal structural fixes over redesigning the page.
