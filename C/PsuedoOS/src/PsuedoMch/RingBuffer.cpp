
#include "RingBuffer.h"

RingBuffer::RingBuffer()
{
	Reset();
}

void RingBuffer::Reset()
{
	dwFrontIndex = 0;
	dwRearIndex  = -1;
}

void RingBuffer::Push(TCHAR c)
{
	tcBuffer[ dwFrontIndex ] = c;
	dwFrontIndex = (dwFrontIndex+1)%RING_SIZE;

	if (-1 == dwRearIndex)
	{
		// this is the first Push
		dwRearIndex = 0;
	}

	if (dwRearIndex == dwFrontIndex)
	{
		// we are about to wrap
		dwRearIndex = (dwRearIndex+1)%RING_SIZE;
	}
}

char RingBuffer::Pop()
{
	char c = '\0';

	if (0 <= dwRearIndex && RING_SIZE > dwRearIndex)
	{
		// BUG BUG! Char convertion!
		c = (char)tcBuffer[ dwRearIndex ];
		dwRearIndex = (dwRearIndex+1)%RING_SIZE;
	}

	if (dwRearIndex == dwFrontIndex)
	{
		Reset();
	}

	return c;	
}

bool RingBuffer::IsEmpty()
{
	return (-1 == dwRearIndex);
}

