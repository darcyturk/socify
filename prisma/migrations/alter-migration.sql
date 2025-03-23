-- Update the NotificationType enum to include TAG and STATUS
ALTER TYPE "NotificationType" ADD VALUE 'TAG';
ALTER TYPE "NotificationType" ADD VALUE 'STATUS';

-- Create Reel table
CREATE TABLE "Reel" (
    "id" TEXT NOT NULL,
    "content" TEXT,
    "videoUrl" TEXT,
    "authorId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Reel_pkey" PRIMARY KEY ("id")
);

-- Create Status table
CREATE TABLE "Status" (
    "id" TEXT NOT NULL,
    "authorId" TEXT NOT NULL,
    "image" TEXT,
    "text" TEXT,
    "song" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Status_pkey" PRIMARY KEY ("id")
);

-- Create Viewer table
CREATE TABLE "Viewer" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "statusId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Viewer_pkey" PRIMARY KEY ("id")
);

-- Create index on Viewer table
CREATE INDEX "Viewer_userId_statusId_idx" ON "Viewer"("userId", "statusId");

-- Alter existing Comment table to add reelId and make postId nullable
ALTER TABLE "Comment" ADD COLUMN "reelId" TEXT;
ALTER TABLE "Comment" ALTER COLUMN "postId" DROP NOT NULL;

-- Alter existing Like table to add reelId
ALTER TABLE "Like" ADD COLUMN "reelId" TEXT;

-- Alter existing Notification table to add reelId
ALTER TABLE "Notification" ADD COLUMN "reelId" TEXT;

-- Add foreign key constraints for Reel
ALTER TABLE "Reel" ADD CONSTRAINT "Reel_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Add foreign key constraints for Status
ALTER TABLE "Status" ADD CONSTRAINT "Status_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Add foreign key constraints for Viewer
ALTER TABLE "Viewer" ADD CONSTRAINT "Viewer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "Viewer" ADD CONSTRAINT "Viewer_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "Status"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Add foreign key constraints for Comment with Reel
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_reelId_fkey" FOREIGN KEY ("reelId") REFERENCES "Reel"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Add foreign key constraints for Like with Reel
ALTER TABLE "Like" ADD CONSTRAINT "Like_reelId_fkey" FOREIGN KEY ("reelId") REFERENCES "Reel"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Add foreign key constraints for Notification with Reel
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_reelId_fkey" FOREIGN KEY ("reelId") REFERENCES "Reel"("id") ON DELETE CASCADE ON UPDATE CASCADE;
