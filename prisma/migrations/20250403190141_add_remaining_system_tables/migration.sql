-- CreateTable
CREATE TABLE "system"."user_bookmarks" (
    "id" SERIAL NOT NULL,
    "clerk_user_id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "resource_type" TEXT NOT NULL,
    "resource_id" TEXT NOT NULL,
    "display_name" TEXT NOT NULL,
    "bookmark_group" TEXT DEFAULT 'default',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_bookmarks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "system"."usage_logs" (
    "id" SERIAL NOT NULL,
    "clerk_user_id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "action_type" TEXT NOT NULL,
    "resource_type" TEXT,
    "resource_id" TEXT,
    "session_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "usage_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "system"."purchases" (
    "id" SERIAL NOT NULL,
    "clerk_user_id" TEXT NOT NULL,
    "game_id" TEXT NOT NULL,
    "payment_intent_id" TEXT,
    "status" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completed_at" TIMESTAMP(3),

    CONSTRAINT "purchases_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_bookmarks_clerk_user_id_game_id_resource_type_resource_key" ON "system"."user_bookmarks"("clerk_user_id", "game_id", "resource_type", "resource_id");

-- CreateIndex
CREATE UNIQUE INDEX "purchases_payment_intent_id_key" ON "system"."purchases"("payment_intent_id");
