1. **Backend & Database Setup**:
   - Initialize PostgreSQL with the defined schemas (system, elden_ring, baldurs_gate3)
   - Create Next.js API routes for auth, game data, user progress, and settings

2. **Tauri Shell Development**:
   - Build transparent window capabilities with configurable hotkeys
   - Implement window management to detect/overlay running games
   - Create the offline data caching mechanism

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
