.file "clang.s"
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
pa2s:                                   # @pa2s
        shl     rdx, 3
        test    rdx, rdx
        je      .LBB1_3
        mov     r8, qword ptr [rdi]
        mov     r9, qword ptr [rdi + 8]
        mov     rax, qword ptr [rdi + 16]
        mov     rdi, qword ptr [rdi + 24]
        add     rsi, 3
.LBB1_2:                                # =>This Inner Loop Header: Depth=1
        mov     cl, byte ptr [r8]
        mov     byte ptr [rsi - 3], cl
        mov     cl, byte ptr [r9]
        mov     byte ptr [rsi - 2], cl
        mov     cl, byte ptr [rax]
        mov     byte ptr [rsi - 1], cl
        mov     cl, byte ptr [rdi]
        mov     byte ptr [rsi], cl
        inc     r8
        inc     r9
        inc     rax
        inc     rdi
        add     rsi, 4
        dec     rdx
        jne     .LBB1_2
.LBB1_3:                                # %._crit_edge
        ret
