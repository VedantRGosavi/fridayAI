#fridayAI-database-schema
Below is a reviewed and updated version of the FridayAI database schema, originally designed for a PHP project using SQLite, now adapted for the current tech stack of Next.js, PostgreSQL, and Clerk for authentication. The focus remains on supporting two games: Elden Ring and Baldur's Gate 3. I’ve evaluated the original schema, removed PHP-specific considerations, and made necessary changes to align with PostgreSQL’s capabilities, Clerk’s authentication system, and the project’s current goals.
Overview of Changes
The original schema used separate SQLite databases: one for system data (system.sqlite) and one per game (elden_ring.sqlite, baldurs_gate3.sqlite). With PostgreSQL, I’ve consolidated this into a single database (fridayai_db) with multiple schemas to maintain modularity while simplifying management:
system schema: Handles user-related data like subscriptions, settings, progress, and analytics.
elden_ring schema: Contains game-specific data for Elden Ring.
baldurs_gate3 schema: Contains game-specific data for Baldur’s Gate 3.
Key updates include:
Clerk Integration: Replaced the users table with Clerk’s user IDs, leveraging Clerk for authentication and basic user management.
PostgreSQL Features: Utilized JSONB for structured data, TIMESTAMP WITH TIME ZONE for dates, TEXT[] for arrays, and full-text search with tsvector instead of SQLite’s FTS5.
Data Types: Adjusted types for better PostgreSQL compatibility (e.g., BOOLEAN instead of INTEGER for flags).
Foreign Keys: Maintained where possible within schemas, relaxed across schemas for game-specific references to avoid complexity.
Updated Database Schema
Database Structure
Database Name: fridayai_db
Schemas:
system: User-related tables
elden_ring: Elden Ring game data
baldurs_gate3: Baldur’s Gate 3 game data
Below are the detailed table definitions for each schema.
system Schema
This schema manages user data, integrating with Clerk and Stripe for authentication and subscriptions.
subscriptions
Tracks user subscription details linked to Clerk and Stripe.
sql
CREATE TABLE system.subscriptions (
    id SERIAL PRIMARY KEY,
    clerk_user_id TEXT UNIQUE NOT NULL, -- References Clerk's user ID
    stripe_subscription_id TEXT UNIQUE NOT NULL,
    status TEXT NOT NULL, -- e.g., 'active', 'canceled'
    current_period_end TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);
purchases (Optional)
Records one-time purchases, kept for potential premium features or game-specific access. Remove if subscriptions cover all access.
sql
CREATE TABLE system.purchases (
    id SERIAL PRIMARY KEY,
    clerk_user_id TEXT NOT NULL, -- References Clerk's user ID
    game_id TEXT NOT NULL, -- e.g., 'elden_ring'
    payment_intent_id TEXT UNIQUE,
    status TEXT NOT NULL, -- e.g., 'pending', 'completed'
    amount INTEGER NOT NULL, -- In cents
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    completed_at TIMESTAMP WITH TIME ZONE
);
user_settings
Stores user preferences for the overlay tool.
sql
CREATE TABLE system.user_settings (
    clerk_user_id TEXT PRIMARY KEY, -- References Clerk's user ID
    overlay_position TEXT, -- e.g., 'top-right'
    overlay_size TEXT, -- e.g., 'medium'
    overlay_opacity REAL DEFAULT 0.85 CHECK (overlay_opacity BETWEEN 0 AND 1),
    hotkey_combination TEXT DEFAULT 'ctrl+shift+j',
    theme TEXT DEFAULT 'dark',
    default_info_display_mode TEXT DEFAULT 'concise',
    show_spoilers BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);
user_game_progress
Tracks user progress in quests for each game.
sql
CREATE TABLE system.user_game_progress (
    id SERIAL PRIMARY KEY,
    clerk_user_id TEXT NOT NULL, -- References Clerk's user ID
    game_id TEXT NOT NULL, -- e.g., 'elden_ring'
    quest_id TEXT NOT NULL, -- References quests in game schema
    step_id TEXT, -- References quest_steps in game schema
    completed BOOLEAN DEFAULT FALSE,
    marked_status TEXT DEFAULT 'untracked', -- e.g., 'in_progress', 'skipped'
    notes TEXT,
    last_accessed TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    CONSTRAINT unique_user_game_quest UNIQUE (clerk_user_id, game_id, quest_id)
);
Note: No foreign key constraints on quest_id or step_id due to cross-schema references. Integrity is managed in the application.
user_bookmarks
Stores user-saved game content.
sql
CREATE TABLE system.user_bookmarks (
    id SERIAL PRIMARY KEY,
    clerk_user_id TEXT NOT NULL, -- References Clerk's user ID
    game_id TEXT NOT NULL, -- e.g., 'elden_ring'
    resource_type TEXT NOT NULL, -- e.g., 'quest', 'item'
    resource_id TEXT NOT NULL, -- ID of the resource in game schema
    display_name TEXT NOT NULL,
    bookmark_group TEXT DEFAULT 'default',
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    CONSTRAINT unique_bookmark UNIQUE (clerk_user_id, game_id, resource_type, resource_id)
);
usage_logs
Records user activity for analytics.
sql
CREATE TABLE system.usage_logs (
    id SERIAL PRIMARY KEY,
    clerk_user_id TEXT NOT NULL, -- References Clerk's user ID
    game_id TEXT NOT NULL, -- e.g., 'elden_ring'
    action_type TEXT NOT NULL, -- e.g., 'view', 'search'
    resource_type TEXT, -- e.g., 'quest', 'npc'
    resource_id TEXT,
    session_id TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);
Game Schemas (elden_ring and baldurs_gate3)
Each game schema contains identical table structures with game-specific data. Below is the schema definition, applicable to both elden_ring and baldurs_gate3. Replace elden_ring with baldurs_gate3 for the latter.
quests
Main quest information.
sql
CREATE TABLE elden_ring.quests (
    quest_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    type TEXT NOT NULL, -- e.g., 'main', 'side'
    starting_location_id TEXT REFERENCES elden_ring.locations(location_id),
    quest_giver_id TEXT REFERENCES elden_ring.npcs(npc_id),
    difficulty TEXT, -- e.g., 'beginner', 'moderate'
    is_main_story BOOLEAN DEFAULT FALSE,
    rewards JSONB, -- e.g., {"items": ["item_id1"], "experience": 1000}
    related_quests TEXT[], -- Array of quest_ids
    spoiler_level INTEGER DEFAULT 0,
    version_added TEXT,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    search_vector TSVECTOR GENERATED ALWAYS AS (
        to_tsvector('english', name || ' ' || description)
    ) STORED
);

CREATE INDEX quests_search_idx ON elden_ring.quests USING GIN (search_vector);
quest_steps
Detailed steps for quest progression.
sql
CREATE TABLE elden_ring.quest_steps (
    step_id TEXT PRIMARY KEY,
    quest_id TEXT NOT NULL REFERENCES elden_ring.quests(quest_id),
    step_number INTEGER NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    objective TEXT NOT NULL,
    hints TEXT,
    location_id TEXT REFERENCES elden_ring.locations(location_id),
    required_items TEXT[], -- Array of item_ids
    required_npcs TEXT[], -- Array of npc_ids
    completion_flags TEXT,
    next_step_id TEXT REFERENCES elden_ring.quest_steps(step_id),
    alternative_paths TEXT,
    spoiler_level INTEGER DEFAULT 0
);
locations
Game areas and points of interest.
sql
CREATE TABLE elden_ring.locations (
    location_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    region TEXT NOT NULL,
    parent_location_id TEXT REFERENCES elden_ring.locations(location_id),
    coordinates JSONB, -- e.g., {"x": 100, "y": 200}
    points_of_interest TEXT[],
    connected_locations TEXT[], -- Array of location_ids
    difficulty_level TEXT,
    recommended_level TEXT,
    notable_items TEXT[], -- Array of item_ids
    notable_npcs TEXT[], -- Array of npc_ids
    search_vector TSVECTOR GENERATED ALWAYS AS (
        to_tsvector('english', name || ' ' || description)
    ) STORED
);

CREATE INDEX locations_search_idx ON elden_ring.locations USING GIN (search_vector);
npcs
Non-player characters.
sql
CREATE TABLE elden_ring.npcs (
    npc_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    role TEXT,
    default_location_id TEXT REFERENCES elden_ring.locations(location_id),
    faction TEXT,
    is_hostile BOOLEAN DEFAULT FALSE,
    is_merchant BOOLEAN DEFAULT FALSE,
    gives_quests TEXT[], -- Array of quest_ids
    services TEXT[],
    dialogue_summary TEXT,
    relationship_to_other_npcs TEXT,
    schedule JSONB, -- e.g., {"day": "location_id1", "night": "location_id2"}
    drops_on_defeat TEXT[], -- Array of item_ids
    search_vector TSVECTOR GENERATED ALWAYS AS (
        to_tsvector('english', name || ' ' || description)
    ) STORED
);

CREATE INDEX npcs_search_idx ON elden_ring.npcs USING GIN (search_vector);
items
Game items.
sql
CREATE TABLE elden_ring.items (
    item_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    type TEXT NOT NULL, -- e.g., 'weapon', 'key_item'
    subtype TEXT,
    stats JSONB, -- e.g., {"damage": 50, "weight": 3.5}
    requirements JSONB, -- e.g., {"strength": 10}
    effects TEXT,
    locations_found TEXT[], -- Array of location_ids
    dropped_by TEXT[], -- Array of npc_ids
    quest_related BOOLEAN DEFAULT FALSE,
    related_quests TEXT[], -- Array of quest_ids
    rarity TEXT,
    image_path TEXT,
    search_vector TSVECTOR GENERATED ALWAYS AS (
        to_tsvector('english', name || ' ' || description)
    ) STORED
);

CREATE INDEX items_search_idx ON elden_ring.items USING GIN (search_vector);
npc_locations
Tracks NPC locations under specific conditions.
sql
CREATE TABLE elden_ring.npc_locations (
    id SERIAL PRIMARY KEY,
    npc_id TEXT NOT NULL REFERENCES elden_ring.npcs(npc_id),
    location_id TEXT NOT NULL REFERENCES elden_ring.locations(location_id),
    condition_type TEXT, -- e.g., 'quest_completed'
    condition_value TEXT, -- e.g., 'q_irina_letter'
    notes TEXT
);
quest_prerequisites
Tracks quest dependencies.
sql
CREATE TABLE elden_ring.quest_prerequisites (
    id SERIAL PRIMARY KEY,
    quest_id TEXT NOT NULL REFERENCES elden_ring.quests(quest_id),
    prerequisite_type TEXT NOT NULL, -- e.g., 'quest', 'item'
    prerequisite_id TEXT NOT NULL,
    notes TEXT
);
quest_consequences
Tracks effects of quest decisions.
sql
CREATE TABLE elden_ring.quest_consequences (
    id SERIAL PRIMARY KEY,
    quest_id TEXT NOT NULL REFERENCES elden_ring.quests(quest_id),
    step_id TEXT REFERENCES elden_ring.quest_steps(step_id),
    decision TEXT NOT NULL,
    affects_type TEXT NOT NULL, -- e.g., 'npc', 'location'
    affects_id TEXT NOT NULL,
    effect TEXT NOT NULL,
    spoiler_level INTEGER DEFAULT 0
);
Key Design Decisions
Clerk Integration:
Removed the users table since Clerk manages authentication and user profiles. clerk_user_id (a text-based UUID) is used directly in tables like subscriptions and user_game_progress.
Single Database with Schemas:
Consolidated separate SQLite databases into one PostgreSQL database with schemas for better management and cross-game querying potential, while retaining modularity.
Full-Text Search:
Replaced SQLite’s search_index (FTS5) with PostgreSQL’s tsvector columns and GIN indexes in quests, locations, npcs, and items tables for efficient searching.
Data Type Enhancements:
Used JSONB for fields like rewards, stats, and coordinates to store structured data.
Used TEXT[] (arrays) for lists like related_quests and required_items.
Converted text-based timestamps to TIMESTAMP WITH TIME ZONE.
Foreign Keys:
Enforced within each schema (e.g., quest_id in quest_steps references quests).
Omitted across schemas (e.g., quest_id in user_game_progress doesn’t reference game schemas) to avoid complexity, relying on application logic for integrity.
Indexes:
Added GIN indexes on search_vector columns for fast full-text search.
Unique constraints (e.g., user_game_progress) ensure data consistency.
Considerations and Recommendations
Performance: PostgreSQL’s concurrency and indexing should handle initial loads. For high traffic, consider adding a caching layer (e.g., Redis) for frequently accessed game data.
Scalability: Adding new games is as simple as creating a new schema (e.g., dark_souls3). Schema design supports this expansion.
Data Updates: Game data can be updated via SQL scripts targeting specific schemas, leveraging PostgreSQL’s transaction support.
Search: Game-specific searches use schema-qualified queries (e.g., SELECT * FROM elden_ring.quests WHERE search_vector @@ to_tsquery('english', 'search term')). A global search across games could be implemented with a view or function if needed later.
Purchases Table: Retained for flexibility (e.g., premium features), but remove if subscriptions cover all access.
Conclusion
This updated schema adapts the original design to PostgreSQL, Clerk, and the focus on Elden Ring and Baldur’s Gate 3. It maintains the modular structure, enhances data types and search capabilities, and aligns with the new tech stack. The use of schemas ensures organization and scalability, while Clerk integration simplifies user management. This foundation supports the overlay tool’s features—quest tracking, interactive maps, item search, and user personalization—while leveraging PostgreSQL’s robust features for performance and reliability.