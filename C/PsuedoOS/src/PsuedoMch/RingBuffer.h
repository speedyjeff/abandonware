#include <windows.h>
#include <stdio.h>
#include <tchar.h>

#ifndef _RINGBUFFER__H
#define _RINGBUFFER__H

#define RING_SIZE 128

class RingBuffer
{
public:
	RingBuffer();

	void Push(TCHAR c);
	char Pop();

	bool IsEmpty();

	void Reset();

private:
	TCHAR tcBuffer[RING_SIZE];
	DWORD dwFrontIndex;
	DWORD dwRearIndex;
};

#endif

