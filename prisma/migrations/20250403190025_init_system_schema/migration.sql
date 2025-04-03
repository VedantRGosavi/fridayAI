-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "baldurs_gate3";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "elden_ring";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "system";

-- CreateTable
CREATE TABLE "system"."subscriptions" (
    "id" SERIAL NOT NULL,
    "clerk_user_id" TEXT NOT NULL,
    "stripe_subscription_id" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "current_period_end" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "system"."user_settings" (
    "clerk_user_id" TEXT NOT NULL,
    "overlay_position" TEXT,
    "overlay_size" TEXT,
    "overlay_opacity" DOUBLE PRECISION DEFAULT 0.85,
    "hotkey_combination" TEXT DEFAULT 'ctrl+shift+j',
    "theme" TEXT DEFAULT 'dark',
    "default_info_display_mode" TEXT DEFAULT 'concise',
    "show_spoilers" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_settings_pkey" PRIMARY KEY ("clerk_user_id")
);

-- CreateTable
CREATE TABLE "system"."user_game_progress" (
    "id" SERIAL NOT NULL,
    "clerk_user_id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "quest_id" TEXT NOT NULL,
    "step_id" TEXT,
    "completed" BOOLEAN NOT NULL DEFAULT false,
    "marked_status" TEXT NOT NULL DEFAULT 'untracked',
    "notes" TEXT,
    "last_accessed" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_game_progress_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "subscriptions_clerk_user_id_key" ON "system"."subscriptions"("clerk_user_id");

-- CreateIndex
CREATE UNIQUE INDEX "subscriptions_stripe_subscription_id_key" ON "system"."subscriptions"("stripe_subscription_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_game_progress_clerk_user_id_game_id_quest_id_key" ON "system"."user_game_progress"("clerk_user_id", "game_id", "quest_id");
