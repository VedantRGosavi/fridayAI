1. **Backend & Database Setup**:
   - Initialize PostgreSQL with the defined schemas (system, elden_ring, baldurs_gate3)
   Done.
   - Create Next.js API routes for auth, game data, user progress, and settings
   Done.
Authentication Routes:
/api/auth/login - Handles user login using Clerk
Protected by Clerk middleware
Game Data Routes:
/api/game/save - Saves game progress
Protected by Clerk middleware
Uses userGameProgress table
Progress Routes:
/api/progress/get - Gets user's game progress
Protected by Clerk middleware
Uses userGameProgress table
Settings Routes:
/api/settings/update - Updates user settings
Protected by Clerk middleware
Uses userSettings table
Authentication Middleware:
Protects API routes using Clerk
Handles session management
Routes under /api/game, /api/progress, and /api/settings require authentication
Auth Utilities:
verifyToken function to verify user authentication in API routes
Uses Clerk's session management
The API routes are set up to work with your Prisma schema and use Clerk for authentication. All routes are properly protected and follow the Tauri + Next.js best practices for static exports.

2. **Tauri Shell Development**:
   - Build transparent window capabilities with configurable hotkeys
   - Implement window management to detect/overlay running games
   - Create the offline data caching mechanism

## 1. Transparent Window System
- **Config File Setup**
  - Create JSON-based config for hotkey mappings
  - Implement default mappings for the specified hotkeys
  - Add validation logic for custom configurations

- **Hotkey Registration**
  - Use Tauri's global shortcut API to register all hotkeys
  - Handle platform-specific differences (Windows/macOS)
  - Implement toggle functions for overlay visibility

- **Overlay Rendering**
  - Design transparent window with configurable opacity
  - Create minimal UI frame with drag/resize capabilities
  - Implement state management for overlay visibility

## 2. Game Detection & Window Management
- **Process Detection**
  - Implement system process scanning for Elden Ring and Baldur's Gate 3
  - Create platform-specific detection (Windows/macOS)
  - Set up polling mechanism to detect game state changes

- **Window Positioning**
  - Retrieve game window dimensions and position
  - Configure overlay to position correctly over game window
  - Handle multi-monitor setups and resolution changes

- **Focus Management**
  - Implement click-through for non-interactive overlay areas
  - Handle focus switching between game and overlay
  - Ensure hotkeys work regardless of focus state

## 3. Offline Data Caching
- **Local Storage Structure**
  - Design SQLite schema for cached game data
  - Create data models for quests, items, and maps
  - Implement versioning system for data updates

- **Cache Management**
  - Build data fetching logic from API to local storage
  - Implement cache invalidation and refresh policies
  - Add compression for larger data sets (maps, images)

- **Background Sync**
  - Create background process for data synchronization
  - Implement connection state detection
  - Add progress indicators for initial data download

## Implementation Order
1. Start with the transparent window system as it's foundational
2. Implement game detection and window management
3. Add offline caching mechanisms 

Would you like me to start designing any specific component first, or would you like to refine any part of this plan?




--------------------------------------------------------------
3. **Authentication & Purchases**:
   - Integrate Clerk auth flow in Tauri app
   - Set up Stripe for the defined product IDs
   - Implement purchase validation and entitlement checking

4. **Game Data Integration**:
   - Create data pipeline to sync from external APIs to our database
   - Structure the data according to our schema requirements
   - Build search and filtering capabilities

5. **UI Development**:
   - Develop modular overlay UI components with Tailwind/Shadcn
   - Implement theme system and opacity controls
   - Build quest tracking and progress visualization

Template created! To get started run:
  cd fridayAI
  npm install
  npm run tauri android init
  npm run tauri ios init

For Desktop development, run:
  npm run tauri dev

For Android development, run:
  npm run tauri android dev

For iOS development, run:
  npm run tauri ios dev
