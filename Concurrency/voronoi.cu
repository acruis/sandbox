// ---------------
// CS3211 CUDA Lab
// ---------------

__device__ __host__ int distance(int x1, int y1, int x2, int y2) 
{
	return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2); 
}

/* The CPU version of Voronoi Diagram computation */ 
void cpuVoronoiDiagram(Point2D *points, int *output, int noPoints, int width, int height) 
{
	int id = 0; 

	for (int j = 0; j < height; j++) 
		for (int i = 0; i < width; i++) {
			int best = 0; 
			int minDist = distance(i, j, points[0].x, points[0].y);

			for (int k = 1; k < noPoints; k++) {
				int myDist = distance(i, j, points[k].x, points[k].y); 

				if (myDist < minDist) {
					minDist = myDist; 
					best = k;
				}
			}

			output[id++] = best; 
		}
}

/* GPU Version of Voronoi diagram computation 
 * Naive implementation
 */
__global__ void kernelNaiveVoronoiDiagram(Point2D *points, int *result, int noPoints, int width) 
{
	int threadX = (blockIdx.x * blockDim.x) + threadIdx.x;
	int threadY = (blockIdx.y * blockDim.y) + threadIdx.y;

	int best = 0;
	int minDist = distance(threadX, threadY, points[0].x, points[0].y);

	for (int i = 1; i < noPoints; i++) {
		int myDist = distance(threadX, threadY, points[i].x, points[i].y);

		if (myDist < minDist) {
			minDist = myDist;
			best = i;
		}
	}

	result[(threadY * width) + threadX] = best;
}

/* GPU Version of Voronoi diagram computation
 * Using shared memory
 * We assume for simplicity that noPoints is divisible by TILE
 */
__global__ void kernelSharedVoronoiDiagram(Point2D *points, int *result, int noPoints, int width) 
{
	int threadX = (blockIdx.x * blockDim.x) + threadIdx.x;
	int threadY = (blockIdx.y * blockDim.y) + threadIdx.y;

	int best = 0;
	int minDist = distance(threadX, threadY, points[0].x, points[0].y);

	__shared__ Point2D interPoints[TILE];

	for (int m = 0; m < noPoints; m += TILE) {
		int interPointIdx = (threadIdx.y * blockDim.x) + threadIdx.x;
		int pointIdx = m + interPointIdx;
		interPoints[interPointIdx] = points[pointIdx];

		__syncthreads();

		for (int k = 0; k < TILE; k++) {
			int myDist = distance(threadX, threadY, interPoints[k].x, interPoints[k].y);

			if (myDist < minDist) {
				minDist = myDist;
				best = m + k;
			}
		}

		__syncthreads();
	}

	result[(threadY * width) + threadX] = best;
}

