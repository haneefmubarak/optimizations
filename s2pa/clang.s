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

.globl	s2pa
.type	s2pa, @function
# void s2pa (const rgba_s *restrict s, rgba_pa *restrict pa, size_t n)
# s2pa (rdi *, rsi *, rdx)
s2pa:                                   # @s2pa
        shl     rdx, 3
        test    rdx, rdx
        je      .LBB0_3
        mov     r8, qword ptr [rsi]
        mov     r9, qword ptr [rsi + 8]
        mov     rax, qword ptr [rsi + 16]
        mov     rsi, qword ptr [rsi + 24]
        add     rdi, 3
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
        mov     cl, byte ptr [rdi - 3]
        mov     byte ptr [r8], cl
        mov     cl, byte ptr [rdi - 2]
        mov     byte ptr [r9], cl
        mov     cl, byte ptr [rdi - 1]
        mov     byte ptr [rax], cl
        mov     cl, byte ptr [rdi]
        mov     byte ptr [rsi], cl
        inc     r8
        inc     r9
        inc     rax
        inc     rsi
        add     rdi, 4
        dec     rdx
        jne     .LBB0_2
.LBB0_3:                                # %._crit_edge
        ret
