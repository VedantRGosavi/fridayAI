import { NextApiRequest } from 'next';
import { getAuth } from '@clerk/nextjs/server';

interface AuthUser {
  userId: string;
}

export async function verifyToken(req: NextApiRequest): Promise<AuthUser | null> {
  try {
    const { userId } = getAuth(req);
    
    if (!userId) {
      return null;
    }

    return { userId };
  } catch (error) {
    return null;
  }
} 