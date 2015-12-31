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

void s2pa (const rgba_s *restrict s, rgba_pa *restrict pa, size_t n);

#define	ITEMS	256

rgba_s s[ITEMS] = { [0 ... (ITEMS - 1)] = { 'r', 'g', 'b', 'a' }};

uint8_t r[ITEMS] = { 0 }, g[ITEMS] = { 0 }, b[ITEMS] = { 0 }, a[ITEMS] = { 0 };
rgba_pa pa = { r, g, b, a };

int main (void) {
	size_t x, y;
	for (x = 0; x < (1000 * 1000); x++)
		for (y = 0; y < 64; y++)	// loop unroll
			s2pa (s, &pa, ITEMS/8);

	return 0;
}
