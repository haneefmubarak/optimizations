.file "hand.s"
.intel_syntax noprefix

.data

.align	16
shift:
.zero	3
.byte	0xFF
.zero	3
.byte	0xFF
.zero	3
.byte	0xFF
.zero	3
.byte	0xFF

.text

# rgba_s:	struct {
#			uint8_t r;
#			uint8_t g;
#			uint8_t b;
#			uint8_t a;
#		}

# rgba_pa:	struct {
#			uint8_t *restrict r;
#			uint8_t *restrict g;
#			uint8_t *restrict b;
#			uint8_t *restrict a;
#		}

.globl	s2pa
.type	s2pa, @function
# void s2pa (const rgba_s *restrict s, rgba_pa *restrict pa, size_t n)
# s2pa (rdi *, rsi *, rdx)
s2pa:	# sandy optimized

	# free rename | free load s.r shift | prefetch vector read
	xor	eax, eax
	vmovdqa	xmm0, XMMWORD PTR [shift + rip]
	prefetcht1	[rdi]

	# processed in blocks of 8 structures
#	shl	rdx, 3

	# zero check
	cmp	rdx, rax
	je	.s2pa_RET

	# load in pa indexes | calculate masks s.{g,b,a} | zero pa offset
	mov	r8, QWORD PTR [rsi]
	mov	r9, QWORD PTR [rsi + 8]
	vpsrld	xmm1, xmm0, 8
	vpsrld	xmm2, xmm0, 16

	mov	r10, QWORD PTR [rsi + 16]
	mov	r11, QWORD PTR [rsi + 24]
	vpsrld	xmm3, xmm0, 24
#	xor	ecx, ecx

.s2pa_LOOP:
	# load in *s | prefetch next s
	vmovdqu		xmm15, XMMWORD PTR [rdi + rax * 8]
#	prefetcht1	[rax + rdi + 32]

	# mask what we want | prefetch next pa.{r,g,b,a} for write
	vpand		xmm4, xmm15, xmm0
	vpand		xmm5, xmm15, xmm1
#	vpand		xmm4, xmm0, XMMWORD PTR [rdi + rax * 8]
#	vpand		xmm5, xmm1, XMMWORD PTR [rdi + rax * 8]
#	prefetchwt1	[rcx + r8 + 4]
#	prefetchwt1	[rcx + r9 + 4]
	prefetcht1	[r8 + rax * 2 + 4]
	prefetcht1	[r9 + rax * 2 + 4]

	vpand		xmm6, xmm15, xmm2
	vpand		xmm7, xmm15, xmm3
#	vpand		xmm6, xmm2, XMMWORD PTR [rdi + rax * 8]
#	vpand		xmm7, xmm3, XMMWORD PTR [rdi + rax * 8]
	prefetcht1	[r10 + rax * 2 + 4]
	prefetcht1	[r11 + rax * 2 + 4]

	# shift r,g,b (a is already in place) | prefetch next s
	vpsrld	xmm4, xmm4, 24
	vpsrld	xmm5, xmm5, 16
	vpsrld	xmm6, xmm6, 8
	prefetcht1	[rdi + rax * 8  + 32]

	# reduce 32 to 16
	vpackusdw	xmm4, xmm4, xmm4
	vpackusdw	xmm5, xmm5, xmm5
	vpackusdw	xmm6, xmm6, xmm6
	vpackusdw	xmm7, xmm7, xmm7

	# reduce 16 to 8
	vpackuswb	xmm4, xmm4, xmm4
	vpackuswb	xmm5, xmm5, xmm5
	vpackuswb	xmm6, xmm6, xmm6
	vpackuswb	xmm7, xmm7, xmm7

	# we need to write v/4 at a time (reversed due to little endian)
#	vmovd	DWORD PTR [rcx + r8], xmm4
#	vmovd	DWORD PTR [rcx + r9], xmm5
#	vmovd	DWORD PTR [rcx + r10], xmm6
#	vmovd	DWORD PTR [rcx + r11], xmm7
	vmovd	DWORD PTR [r11 + rax * 2], xmm4
	vmovd	DWORD PTR [r10 + rax * 2], xmm5
	vmovd	DWORD PTR [r9 + rax * 2], xmm6
	vmovd	DWORD PTR [r8 + rax * 2], xmm7

	# loop end
#	add	rcx, 4
#	add	rax, 16
	add	rax, 2
	cmp	rax, rdx
	jne	.s2pa_LOOP

.s2pa_RET:
	ret
