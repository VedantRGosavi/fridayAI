-- CreateTable
CREATE TABLE "elden_ring"."quests" (
    "quest_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "starting_location_id" TEXT,
    "quest_giver_id" TEXT,
    "difficulty" TEXT,
    "is_main_story" BOOLEAN NOT NULL DEFAULT false,
    "rewards" JSONB,
    "related_quests" TEXT[],
    "spoiler_level" INTEGER NOT NULL DEFAULT 0,
    "version_added" TEXT,
    "last_updated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "searchVector" tsvector,

    CONSTRAINT "quests_pkey" PRIMARY KEY ("quest_id")
);

-- CreateTable
CREATE TABLE "elden_ring"."quest_steps" (
    "step_id" TEXT NOT NULL,
    "quest_id" TEXT NOT NULL,
    "step_number" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "objective" TEXT NOT NULL,
    "hints" TEXT,
    "location_id" TEXT,
    "required_items" TEXT[],
    "required_npcs" TEXT[],
    "completion_flags" TEXT,
    "next_step_id" TEXT,
    "alternative_paths" TEXT,
    "spoiler_level" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "quest_steps_pkey" PRIMARY KEY ("step_id")
);

-- CreateTable
CREATE TABLE "elden_ring"."locations" (
    "location_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "parent_location_id" TEXT,
    "coordinates" JSONB,
    "points_of_interest" TEXT[],
    "connected_locations" TEXT[],
    "difficulty_level" TEXT,
    "recommended_level" TEXT,
    "notable_items" TEXT[],
    "notable_npcs" TEXT[],
    "searchVector" tsvector,

    CONSTRAINT "locations_pkey" PRIMARY KEY ("location_id")
);

-- CreateTable
CREATE TABLE "elden_ring"."npcs" (
    "npc_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "role" TEXT,
    "default_location_id" TEXT,
    "faction" TEXT,
    "is_hostile" BOOLEAN NOT NULL DEFAULT false,
    "is_merchant" BOOLEAN NOT NULL DEFAULT false,
    "gives_quests" TEXT[],
    "services" TEXT[],
    "dialogue_summary" TEXT,
    "relationship_to_other_npcs" TEXT,
    "schedule" JSONB,
    "drops_on_defeat" TEXT[],
    "searchVector" tsvector,

    CONSTRAINT "npcs_pkey" PRIMARY KEY ("npc_id")
);

-- CreateTable
CREATE TABLE "baldurs_gate3"."quests" (
    "quest_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "starting_location_id" TEXT,
    "quest_giver_id" TEXT,
    "difficulty" TEXT,
    "is_main_story" BOOLEAN NOT NULL DEFAULT false,
    "rewards" JSONB,
    "related_quests" TEXT[],
    "spoiler_level" INTEGER NOT NULL DEFAULT 0,
    "version_added" TEXT,
    "last_updated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "searchVector" tsvector,

    CONSTRAINT "quests_pkey" PRIMARY KEY ("quest_id")
);

-- CreateTable
CREATE TABLE "baldurs_gate3"."quest_steps" (
    "step_id" TEXT NOT NULL,
    "quest_id" TEXT NOT NULL,
    "step_number" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "objective" TEXT NOT NULL,
    "hints" TEXT,
    "location_id" TEXT,
    "required_items" TEXT[],
    "required_npcs" TEXT[],
    "completion_flags" TEXT,
    "next_step_id" TEXT,
    "alternative_paths" TEXT,
    "spoiler_level" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "quest_steps_pkey" PRIMARY KEY ("step_id")
);

-- CreateTable
CREATE TABLE "baldurs_gate3"."locations" (
    "location_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "parent_location_id" TEXT,
    "coordinates" JSONB,
    "points_of_interest" TEXT[],
    "connected_locations" TEXT[],
    "difficulty_level" TEXT,
    "recommended_level" TEXT,
    "notable_items" TEXT[],
    "notable_npcs" TEXT[],
    "searchVector" tsvector,

    CONSTRAINT "locations_pkey" PRIMARY KEY ("location_id")
);

-- CreateTable
CREATE TABLE "baldurs_gate3"."npcs" (
    "npc_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "role" TEXT,
    "default_location_id" TEXT,
    "faction" TEXT,
    "is_hostile" BOOLEAN NOT NULL DEFAULT false,
    "is_merchant" BOOLEAN NOT NULL DEFAULT false,
    "gives_quests" TEXT[],
    "services" TEXT[],
    "dialogue_summary" TEXT,
    "relationship_to_other_npcs" TEXT,
    "schedule" JSONB,
    "drops_on_defeat" TEXT[],
    "searchVector" tsvector,

    CONSTRAINT "npcs_pkey" PRIMARY KEY ("npc_id")
);

-- CreateTable
CREATE TABLE "elden_ring"."items" (
    "item_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "subtype" TEXT,
    "stats" JSONB,
    "requirements" JSONB,
    "effects" TEXT,
    "locations_found" TEXT[],
    "dropped_by" TEXT[],
    "quest_related" BOOLEAN NOT NULL DEFAULT false,
    "related_quests" TEXT[],
    "rarity" TEXT,
    "image_path" TEXT,
    "searchVector" tsvector,

    CONSTRAINT "items_pkey" PRIMARY KEY ("item_id")
);

-- CreateTable
CREATE TABLE "elden_ring"."npc_locations" (
    "id" SERIAL NOT NULL,
    "npc_id" TEXT NOT NULL,
    "location_id" TEXT NOT NULL,
    "condition_type" TEXT,
    "condition_value" TEXT,
    "notes" TEXT,

    CONSTRAINT "npc_locations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "elden_ring"."quest_prerequisites" (
    "id" SERIAL NOT NULL,
    "quest_id" TEXT NOT NULL,
    "prerequisite_type" TEXT NOT NULL,
    "prerequisite_id" TEXT NOT NULL,
    "notes" TEXT,

    CONSTRAINT "quest_prerequisites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "elden_ring"."quest_consequences" (
    "id" SERIAL NOT NULL,
    "quest_id" TEXT NOT NULL,
    "step_id" TEXT,
    "decision" TEXT NOT NULL,
    "affects_type" TEXT NOT NULL,
    "affects_id" TEXT NOT NULL,
    "effect" TEXT NOT NULL,
    "spoiler_level" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "quest_consequences_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "baldurs_gate3"."items" (
    "item_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "subtype" TEXT,
    "stats" JSONB,
    "requirements" JSONB,
    "effects" TEXT,
    "locations_found" TEXT[],
    "dropped_by" TEXT[],
    "quest_related" BOOLEAN NOT NULL DEFAULT false,
    "related_quests" TEXT[],
    "rarity" TEXT,
    "image_path" TEXT,
    "searchVector" tsvector,

    CONSTRAINT "items_pkey" PRIMARY KEY ("item_id")
);

-- CreateTable
CREATE TABLE "baldurs_gate3"."npc_locations" (
    "id" SERIAL NOT NULL,
    "npc_id" TEXT NOT NULL,
    "location_id" TEXT NOT NULL,
    "condition_type" TEXT,
    "condition_value" TEXT,
    "notes" TEXT,

    CONSTRAINT "npc_locations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "baldurs_gate3"."quest_prerequisites" (
    "id" SERIAL NOT NULL,
    "quest_id" TEXT NOT NULL,
    "prerequisite_type" TEXT NOT NULL,
    "prerequisite_id" TEXT NOT NULL,
    "notes" TEXT,

    CONSTRAINT "quest_prerequisites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "baldurs_gate3"."quest_consequences" (
    "id" SERIAL NOT NULL,
    "quest_id" TEXT NOT NULL,
    "step_id" TEXT,
    "decision" TEXT NOT NULL,
    "affects_type" TEXT NOT NULL,
    "affects_id" TEXT NOT NULL,
    "effect" TEXT NOT NULL,
    "spoiler_level" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "quest_consequences_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "quests_searchVector_idx" ON "elden_ring"."quests" USING GIN ("searchVector");

-- CreateIndex
CREATE UNIQUE INDEX "quest_steps_next_step_id_key" ON "elden_ring"."quest_steps"("next_step_id");

-- CreateIndex
CREATE INDEX "locations_searchVector_idx" ON "elden_ring"."locations" USING GIN ("searchVector");

-- CreateIndex
CREATE INDEX "npcs_searchVector_idx" ON "elden_ring"."npcs" USING GIN ("searchVector");

-- CreateIndex
CREATE INDEX "quests_searchVector_idx" ON "baldurs_gate3"."quests" USING GIN ("searchVector");

-- CreateIndex
CREATE UNIQUE INDEX "quest_steps_next_step_id_key" ON "baldurs_gate3"."quest_steps"("next_step_id");

-- CreateIndex
CREATE INDEX "locations_searchVector_idx" ON "baldurs_gate3"."locations" USING GIN ("searchVector");

-- CreateIndex
CREATE INDEX "npcs_searchVector_idx" ON "baldurs_gate3"."npcs" USING GIN ("searchVector");

-- CreateIndex
CREATE INDEX "items_searchVector_idx" ON "elden_ring"."items" USING GIN ("searchVector");

-- CreateIndex
CREATE INDEX "items_searchVector_idx" ON "baldurs_gate3"."items" USING GIN ("searchVector");

-- AddForeignKey
ALTER TABLE "elden_ring"."quests" ADD CONSTRAINT "quests_starting_location_id_fkey" FOREIGN KEY ("starting_location_id") REFERENCES "elden_ring"."locations"("location_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."quests" ADD CONSTRAINT "quests_quest_giver_id_fkey" FOREIGN KEY ("quest_giver_id") REFERENCES "elden_ring"."npcs"("npc_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."quest_steps" ADD CONSTRAINT "quest_steps_quest_id_fkey" FOREIGN KEY ("quest_id") REFERENCES "elden_ring"."quests"("quest_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."quest_steps" ADD CONSTRAINT "quest_steps_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "elden_ring"."locations"("location_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."quest_steps" ADD CONSTRAINT "quest_steps_next_step_id_fkey" FOREIGN KEY ("next_step_id") REFERENCES "elden_ring"."quest_steps"("step_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."locations" ADD CONSTRAINT "locations_parent_location_id_fkey" FOREIGN KEY ("parent_location_id") REFERENCES "elden_ring"."locations"("location_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."npcs" ADD CONSTRAINT "npcs_default_location_id_fkey" FOREIGN KEY ("default_location_id") REFERENCES "elden_ring"."locations"("location_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."quests" ADD CONSTRAINT "quests_starting_location_id_fkey" FOREIGN KEY ("starting_location_id") REFERENCES "baldurs_gate3"."locations"("location_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."quests" ADD CONSTRAINT "quests_quest_giver_id_fkey" FOREIGN KEY ("quest_giver_id") REFERENCES "baldurs_gate3"."npcs"("npc_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."quest_steps" ADD CONSTRAINT "quest_steps_quest_id_fkey" FOREIGN KEY ("quest_id") REFERENCES "baldurs_gate3"."quests"("quest_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."quest_steps" ADD CONSTRAINT "quest_steps_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "baldurs_gate3"."locations"("location_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."quest_steps" ADD CONSTRAINT "quest_steps_next_step_id_fkey" FOREIGN KEY ("next_step_id") REFERENCES "baldurs_gate3"."quest_steps"("step_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."locations" ADD CONSTRAINT "locations_parent_location_id_fkey" FOREIGN KEY ("parent_location_id") REFERENCES "baldurs_gate3"."locations"("location_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."npcs" ADD CONSTRAINT "npcs_default_location_id_fkey" FOREIGN KEY ("default_location_id") REFERENCES "baldurs_gate3"."locations"("location_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."npc_locations" ADD CONSTRAINT "npc_locations_npc_id_fkey" FOREIGN KEY ("npc_id") REFERENCES "elden_ring"."npcs"("npc_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."npc_locations" ADD CONSTRAINT "npc_locations_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "elden_ring"."locations"("location_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."quest_prerequisites" ADD CONSTRAINT "quest_prerequisites_quest_id_fkey" FOREIGN KEY ("quest_id") REFERENCES "elden_ring"."quests"("quest_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."quest_consequences" ADD CONSTRAINT "quest_consequences_quest_id_fkey" FOREIGN KEY ("quest_id") REFERENCES "elden_ring"."quests"("quest_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "elden_ring"."quest_consequences" ADD CONSTRAINT "quest_consequences_step_id_fkey" FOREIGN KEY ("step_id") REFERENCES "elden_ring"."quest_steps"("step_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."npc_locations" ADD CONSTRAINT "npc_locations_npc_id_fkey" FOREIGN KEY ("npc_id") REFERENCES "baldurs_gate3"."npcs"("npc_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."npc_locations" ADD CONSTRAINT "npc_locations_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "baldurs_gate3"."locations"("location_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."quest_prerequisites" ADD CONSTRAINT "quest_prerequisites_quest_id_fkey" FOREIGN KEY ("quest_id") REFERENCES "baldurs_gate3"."quests"("quest_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."quest_consequences" ADD CONSTRAINT "quest_consequences_quest_id_fkey" FOREIGN KEY ("quest_id") REFERENCES "baldurs_gate3"."quests"("quest_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "baldurs_gate3"."quest_consequences" ADD CONSTRAINT "quest_consequences_step_id_fkey" FOREIGN KEY ("step_id") REFERENCES "baldurs_gate3"."quest_steps"("step_id") ON DELETE SET NULL ON UPDATE CASCADE;
