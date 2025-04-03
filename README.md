# FridayAI Gaming Assistant - Product Requirements Document (PRD)

**Version:** 0.1 (MVP)  
**Date:** April 3, 2025  
**Owner:** Vedant Gosavi

---

## 1. Product Overview

FridayAI is a cross-platform gaming assistant designed to provide real-time game information, quest tracking, and immersive guides for popular titles such as Elden Ring and Baldur’s Gate 3. It features a lightweight Tauri-based desktop overlay (written in Rust & TypeScript) that interacts with a Next.js backend for user authentication, data storage, and content delivery.  

Key points:
- Cross-platform desktop app using Tauri  
- Transparent, always-on-top overlay for in-game assistance  
- Next.js & React for the primary user interface and backend endpoints  
- Authentication and user management via Clerk  
- Payment processing and purchase flows via Stripe  
- PostgreSQL for storing user progress, quest data, item databases, etc.  

References:  
- Technical overview:   
- Monetization structure:   
- Database schema and architecture:   

---

## 2. Goals & Objectives

1. **Enhance Gameplay Experience**  
   Provide players with real-time guidance (quests, items, maps) within an unobtrusive overlay.  

2. **Offer Comprehensive Game Data Packs**  
   Each supported title comes with curated data: quest lines, items, NPCs, and location intel.  

3. **Enable Seamless Purchasing & Upgrades**  
   One-click purchases of premium data packs, themes, or other add-ons directly in the overlay.  

4. **Ensure Cross-Platform Compatibility**  
   Deliver a lightweight, responsive overlay solution for Windows, macOS, and Linux, without high resource usage.  

5. **Scale for Additional Titles**  
   Maintain a modular code structure that allows new game support by simply adding data schemas and front-end packages.  

---

## 3. User Personas

1. **Casual Gamer**  
   - Wants quick quest help or item locations but minimal screen clutter.  
   - Likely to use the free or basic data packs.  

2. **Hardcore Completionist**  
   - Desires extensive data on quests, hidden items, and advanced stats.  
   - More inclined to purchase premium features or expansions.  

3. **Streamers / Content Creators**  
   - Needs an overlay to provide quick references, minimize alt-tabbing.  
   - Often invests in advanced or brandable (custom themes) overlays.  

---

## 4. Core Features & Requirements

### 4.1 Tauri-Based Overlay
- **Always-on-top** and **transparent** window to overlay on full-screen or windowed games.  
- **Configurable** position, size, and hotkey-based toggle.  
- **Frameless** approach for a clean, integrated look within games.  

### 4.2 Game Data Packs
- **Quest Data:** Step-by-step instructions, prerequisites, rewards, spoiler-level tagging.  
- **Item Database:** Searchable by name, type, or stats.  
- **NPC Information:** Location, factions, quest involvement, schedules.  
- **Maps & Locations:** Interactive or static references for dungeons, open world zones, etc.  

### 4.3 User Progress & Personalization
- **Quest Progress**: Users can mark steps completed, “in progress,” or “skipped.”  
- **Bookmarks**: Quick references for frequently accessed items, quests, or NPCs.  
- **Custom Overlay Themes**: Basic and premium skins, background opacities, or color schemes.  
- **Spoiler Controls**: Option to hide or show end-game or major plot spoilers.  

### 4.4 Authentication & Purchases
- **Clerk** for login, logout, and password resets.  
- **Stripe** for secure purchase flows:
  - One-time purchase for individual game packs.  
  - Optional premium add-ons (themes, advanced features).  
  - Trials or free demos.  

### 4.5 Multi-Platform Support
- **Windows**: Must support Windows 10+ with minimal system overhead.  
- **macOS**: Support the latest two versions of macOS.  
- **Linux**: Main distros (Ubuntu, Fedora), ensuring a functional overlay.  

---

## 5. Monetization Strategy

1. **Individual Game Data Packs** (e.g., Elden Ring, Baldur’s Gate 3), sold at \$5.99 each.  
2. **Premium Add-ons**: Themes, advanced map layers, voice narration, etc., sold at separate price points (\$2.49 – \$3.99).  
3. **Trial Access**: 7-day trial at \$0.99 for new users to test the product.  

See monetization details in:   

---

## 6. Technical Requirements

### 6.1 Front-End / Overlay
- **Framework**: React + Next.js for UI.  
- **Overlay**: Tauri (Rust + TypeScript) for the cross-platform native shell.  
- **Styling**: Tailwind CSS, Shadcn UI components.  

### 6.2 Backend
- **Next.js App Router** for API endpoints and server-side rendering.  
- **PostgreSQL** for persistent storage of user progress, game data, logs.  
- **Authentication**: Clerk integration (no local user table needed).  
- **Payment**: Stripe integration with robust error handling, subscription webhooks, etc.  

### 6.3 Data Model
- Game-specific schemas (e.g. `elden_ring` and `baldurs_gate3`) containing tables for:
  - `quests`, `quest_steps`, `items`, `npcs`, `locations`  
- A `system` schema for user settings, bookmarks, purchases, etc.  
- Full-text search fields (TSVector, GIN indexes) for quick item/quest lookups.  

For detailed schema structure:   

### 6.4 Security & Privacy
- **Encrypted Communication**: HTTPS for all backend calls.  
- **Secure Auth**: Clerk manages tokens, minimal exposure of user data.  
- **Payment Security**: Rely on Stripe for PCI-compliant transactions.  
- **Minimal Data Storage**: Only store necessary user progress / settings.  

### 6.5 Performance & Stability
- **Lightweight Overlay**: Tauri ensures minimal CPU / RAM overhead, essential for gaming performance.  
- **Caching**: Potential local caching of game data to reduce repeated fetch calls.  
- **Scalability**: Next.js backend on Vercel, with horizontally scalable PostgreSQL (e.g., managed DB).  

---

## 7. User Flow (High-Level)

1. **Download & Install**: User downloads the Tauri desktop client from your website.  
2. **Log In / Sign Up**: Clerk flow inside Tauri for user authentication.  
3. **Purchase or Unlock Game Pack**: Stripe payment flow if not already owned.  
4. **Overlay Settings**: Configure size, hotkeys, spoiler visibility, etc.  
5. **Launch Game**: Overlay remains ready in the background.  
6. **In-Game Usage**: Toggle overlay, search for quests/items, track progress.  
7. **Sync & Save**: Changes saved to the DB for multi-device continuity.  

---

## 8. Success Metrics

- **User Engagement**: Daily active users, average session length.  
- **Conversion Rate**: % of trial users converting to paid.  
- **Churn Rate**: Frequency of subscription cancellations (if a subscription is introduced).  
- **Overlay Usage**: Number of in-game interactions, e.g. quest lookups per session.  
- **Performance Indicators**: CPU/RAM overhead while the overlay is running.  

---


## 9 Non-Functional Requirements

1. **Availability**: 99.9% uptime for the backend to ensure real-time data.  
2. **Maintainability**: Modular architecture for quick expansions (new games).  
3. **Usability**: Overlay must remain intuitive, with minimal learning curve.  
4. **Portability**: Single codebase for Windows, macOS, Linux Tauri builds.  
5. **Localization** (Future Consideration): Ability to add language packs for non-English users.  

---

## 10. Risks & Mitigations

- **Resource Intensity**: Overlays can slow the game. Mitigation: Tauri is lightweight; aggressively optimize.  
- **Licensing & Legal**: Need to confirm fair use of game data. Mitigation: Only include user-created or open-source data, respect developer TOS.  
- **User Privacy**: Potential store of game logs or personal notes. Mitigation: Store minimal data, follow data protection regulations.  

---

## 11. Appendices

- **Monetization & Product IDs**: Detailed SKUs and one-time purchase structures.   
- **Game Documentation**: Best practices for adding new titles, data pack structure.   
- **Database Schema**: System schema vs. game schemas, full DDL.   
- **Technical README**: Overall architecture notes.   

---

**End of Document**  
