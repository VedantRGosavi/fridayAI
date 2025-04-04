import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';
import { verifyToken } from '../../../utils/auth';

const prisma = new PrismaClient();

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const user = await verifyToken(req);
    if (!user) {
      return res.status(401).json({ error: 'Unauthorized' });
    }

    const { gameId, questId, stepId, completed, markedStatus, notes } = req.body;

    const savedProgress = await prisma.userGameProgress.upsert({
      where: {
        unique_user_game_quest: {
          clerkUserId: user.userId,
          gameId,
          questId,
        },
      },
      update: {
        stepId,
        completed,
        markedStatus,
        notes,
        lastAccessed: new Date(),
      },
      create: {
        clerkUserId: user.userId,
        gameId,
        questId,
        stepId,
        completed,
        markedStatus,
        notes,
        lastAccessed: new Date(),
      },
    });

    return res.status(200).json(savedProgress);
  } catch (error) {
    console.error('Game save error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
} 