import { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';
import { clerkClient } from '@clerk/nextjs';

const prisma = new PrismaClient();

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { email, password } = req.body;

    // Use Clerk for authentication
    const signInAttempt = await clerkClient.signIn.create({
      identifier: email,
      strategy: 'password',
      password,
    });

    if (!signInAttempt || signInAttempt.status !== 'complete') {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    // Get or create user settings
    const userSettings = await prisma.userSettings.upsert({
      where: {
        clerkUserId: signInAttempt.userId,
      },
      update: {},
      create: {
        clerkUserId: signInAttempt.userId,
      },
    });

    return res.status(200).json({
      sessionId: signInAttempt.sessionId,
      settings: userSettings,
    });
  } catch (error) {
    console.error('Login error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
} 