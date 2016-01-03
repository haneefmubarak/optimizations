#include <stdint.h>
#include <stdlib.h>

typedef struct {
	uint8_t r,g,b,a;
} rgba_s;

typedef struct {
	uint8_t *restrict r;
	uint8_t *restrict g;
	uint8_t *restrict b;
	uint8_t *restrict a;
} rgba_pa;

void pa2s (const rgba_pa *restrict pa, rgba_s *restrict s, size_t n);

#define	ITEMS	256

rgba_s s[ITEMS] = { 0 };

uint8_t	r[ITEMS] = { [0 ... (ITEMS - 1)] = 'r' },
	g[ITEMS] = { [0 ... (ITEMS - 1)] = 'g' },
	b[ITEMS] = { [0 ... (ITEMS - 1)] = 'b' },
	a[ITEMS] = { [0 ... (ITEMS - 1)] = 'a' };
rgba_pa pa = { r, g, b, a };

int main (void) {
	size_t x, y;
	for (x = 0; x < (1000 * 1000); x++)
		for (y = 0; y < 64; y++)	// loop unroll
			pa2s (&pa, s, ITEMS/8);

	return 0;
}
