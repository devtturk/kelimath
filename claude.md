# CLAUDE.md - Context & Guidelines

## Project Overview
- **Type:** "Bir Kelime Bir İşlem" Style Game (Mobile App)
- **Language:** Turkish (Initial Market), extensible to EN.
- **Tech Stack:** Flutter (Frontend), Dart Backend (Shared Logic), Firebase (Auth/DB).
- **Core Loop:** Word Game -> Number Game -> Result Screen (Score + Best Possible Answer + Definitions).

## Build & Run Commands
- `flutter run` : Development build
- `dart test` : Run unit tests (MANDATORY for Solver/Game Engine)
- `flutter pub run build_runner build --delete-conflicting-outputs` : Code generation

## Architecture & Logic (Shared Dart)
- **Engine Location:** `packages/game_engine` (Pure Dart).
    - Contains: `WordSolver`, `NumberSolver`, `ScoringRules`.
    - Used by: Flutter App (Offline Mode), Server (Online Validation/Bot).
- **Validation Authority:**
    - **Online:** Server is the single source of truth. Checks `server_timestamp` vs `submit_timestamp` to prevent speed-hacking.
    - **Offline:** Client validates locally (security is lower priority here).

## Game Mechanics (Strict Rules)

### 1. Word Game (Kelime)
- **Input:** 8 Random Letters + 1 Joker.
- **Rules:**
    - Valid Turkish words (TDK-based, comprehensive).
    - No inflectional suffixes (Çekim eki) unless distinct entry. Derivational suffixes (Yapım eki) OK.
- **Post-Game UX:**
    - Show User's word & Score.
    - Show Server's "Best Possible Word" (Solver result).
    - Show Definition of the found word (Fetch from API).
- **Scoring:** 10pts/letter. Joker uses 5pts. 9-letter bonus (120pts). Time bonus.

### 2. Number Game (İşlem)
- **Input:** 6 Numbers (Max 1 from Large Pool: 10,25,40,50,60,75). Target: 100-999 (Non-prime).
- **Interaction (UI - Option B):**
    - **Tap-Based:** `[Number]` -> `[Op]` -> `[Number]` -> `[New Result]`.
    - **Visuals:** The used numbers disappear, the result appears as a new draggable/clickable item.
    - **Undo:** Must support undoing the last operation step-by-step.
- **Scoring & Tie-Breaker:**
    - Primary: Distance to target (Exact match = max points).
    - Secondary (Multiplayer): **Step Count.** Reaching the target in *fewer operations* wins the tie.
- **Solver:** Server must calculate the solution to show "This was the solution" if user fails.

## Data Strategy
- **Dictionary:** Large, clean dataset stored on Server (DB/Redis).
- **Definitions:** Fetch on-demand (Lazy loading) to keep APK size small.

## Coding Style
- **State Management:** Riverpod.
- **UI Logic:** NO complex calculations in Widgets. Use `GameController` classes.
- **Testing:** TDD (Test Driven Development) is preferred for the Solver engines.