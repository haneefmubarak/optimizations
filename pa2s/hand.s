.file "hand.s"
.intel_syntax noprefix

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

.globl	pa2s
.type	pa2s, @function
# void pa2s (const rgba_pa *restrict pa, rgba_s *restrict s, size_t n)
# pa2s (rdi *, rsi *, rdx)
pa2s:	# sandy optimized

	# clear sse registers eliminate sse switch penalty
	vzeroupper

	# free rename | prefetch vector write
	xor	eax, eax
	prefetcht0	[rdi]

	# processed in blocks of 8 structures
	shl	rdx, 3

	# zero check
	cmp	rdx, rax
	je	.pa2s_RET

	# load in pa indexes
	mov	r8, QWORD PTR [rdi]
	mov	r9, QWORD PTR [rdi + 8]
	mov	r10, QWORD PTR [rdi + 16]
	mov	r11, QWORD PTR [rdi + 24]

.pa2s_LOOP:
	# load and expand 8 to 32 | shift r,g,b (a is already in place) | prefetch next s write
	pmovzxbd	xmm0, DWORD PTR [rax + r8]
	pmovzxbd	xmm1, DWORD PTR [rax + r9]
	pslld		xmm0, 24
	pslld		xmm1, 16
	pmovzxbd	xmm2, DWORD PTR [rax + r10]
	pmovzxbd	xmm3, DWORD PTR [rax + r11]
	pslld		xmm2, 8
	prefetcht0	[rdi + rax * 4 + 32]

	# load 2nd batch | merge 1st batch | shift 2nd batch
	pmovzxbd	xmm4, DWORD PTR [rax + r8 + 4]
	pmovzxbd	xmm5, DWORD PTR [rax + r9 + 4]
	por		xmm0, xmm1
	por		xmm2, xmm3
	pmovzxbd	xmm6, DWORD PTR [rax + r10 + 4]
	pmovzxbd	xmm7, DWORD PTR [rax + r11 + 4]
	por		xmm0, xmm2
	pslld		xmm4, 24

	# shift 2nd batch cont. | write 1st batch | prefetch next pa.{r,g,b,a}
	pslld	xmm5, 16
	pslld	xmm6, 8
	movdqu	XMMWORD PTR [rsi + rax * 4], xmm0
	prefetcht0	[rax + r8 + 8]

	# merge 2nd batch | prefetch next pa.{r,g,b,a} cont.
	por	xmm4, xmm5
	por	xmm6, xmm7
	prefetcht0	[rax + r9 + 8]
	prefetcht0	[rax + r10 + 8]
	por	xmm4, xmm6
	prefetcht0	[rax + r11 + 8]

	# write 2nd batch | loop end
	movdqu	XMMWORD PTR [rsi + rax * 4 + 16], xmm4
	add	rax, 8
	cmp	rax, rdx
	jne	.pa2s_LOOP

.pa2s_RET:
	ret
