import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';
import { verifyToken } from '../../../utils/auth';

const prisma = new PrismaClient();

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'PUT') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const user = await verifyToken(req);
    if (!user) {
      return res.status(401).json({ error: 'Unauthorized' });
    }

    const {
      overlayPosition,
      overlaySize,
      overlayOpacity,
      hotkeyCombination,
      theme,
      defaultInfoDisplayMode,
      showSpoilers
    } = req.body;

    const updatedSettings = await prisma.userSettings.upsert({
      where: {
        clerkUserId: user.userId
      },
      update: {
        overlayPosition,
        overlaySize,
        overlayOpacity,
        hotkeyCombination,
        theme,
        defaultInfoDisplayMode,
        showSpoilers,
        updatedAt: new Date()
      },
      create: {
        clerkUserId: user.userId,
        overlayPosition,
        overlaySize,
        overlayOpacity,
        hotkeyCombination,
        theme,
        defaultInfoDisplayMode,
        showSpoilers
      }
    });

    return res.status(200).json(updatedSettings);
  } catch (error) {
    console.error('Settings update error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
} 