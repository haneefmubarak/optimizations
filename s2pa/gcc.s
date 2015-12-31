.file "gcc.s"
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
s2pa:
        xor     eax, eax  # x
        shl     rdx, 3    # n,		# clang wouldn't accept "sal"...?
        je      .L7 #,
.L5:
        movzx   r8d, BYTE PTR [rdi]   # D.4428, MEM[base: _2, offset: 0B]
        add     rdi, 4    # ivtmp.7,
        mov     rcx, QWORD PTR [rsi]      # *pa_6(D).r, *pa_6(D).r
        mov     BYTE PTR [rcx+rax], r8b   # *_8, D.4428
        movzx   r8d, BYTE PTR [rdi-3] # D.4428, MEM[base: _2, offset: 1B]
        mov     rcx, QWORD PTR [rsi+8]    # *pa_6(D).g, *pa_6(D).g
        mov     BYTE PTR [rcx+rax], r8b   # *_15, D.4428
        movzx   r8d, BYTE PTR [rdi-2] # D.4428, MEM[base: _2, offset: 2B]
        mov     rcx, QWORD PTR [rsi+16]   # *pa_6(D).b, *pa_6(D).b
        mov     BYTE PTR [rcx+rax], r8b   # *_19, D.4428
        movzx   r8d, BYTE PTR [rdi-1] # D.4428, MEM[base: _2, offset: 3B]
        mov     rcx, QWORD PTR [rsi+24]   # *pa_6(D).a, *pa_6(D).a
        mov     BYTE PTR [rcx+rax], r8b   # *_23, D.4428
        add     rax, 1    # x,
        cmp     rdx, rax  # n, x
        jne     .L5       #,
.L7:
        ret
