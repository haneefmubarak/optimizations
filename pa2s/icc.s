.file "icc.s"
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
pa2s:
        xor       eax, eax                                      #40.8
        shl       rdx, 3                                        #37.3
        test      rdx, rdx                                      #40.19
        jbe       ..B2.5        # Prob 10%                      #40.19
..B2.3:                         # Preds ..B2.1 ..B2.3
        mov       rcx, QWORD PTR [rdi]                          #41.14
        mov       r8b, BYTE PTR [rcx+rax]                       #41.14
        mov       BYTE PTR [rsi+rax*4], r8b                     #41.5
        mov       r9, QWORD PTR [8+rdi]                         #42.14
        mov       r10b, BYTE PTR [r9+rax]                       #42.14
        mov       BYTE PTR [1+rsi+rax*4], r10b                  #42.5
        mov       r11, QWORD PTR [16+rdi]                       #43.14
        mov       cl, BYTE PTR [r11+rax]                        #43.14
        mov       BYTE PTR [2+rsi+rax*4], cl                    #43.5
        mov       r8, QWORD PTR [24+rdi]                        #44.14
        mov       r9b, BYTE PTR [r8+rax]                        #44.14
        mov       BYTE PTR [3+rsi+rax*4], r9b                   #44.5
        inc       rax                                           #40.22
        cmp       rax, rdx                                      #40.19
        jb        ..B2.3        # Prob 82%                      #40.19
..B2.5:                         # Preds ..B2.3 ..B2.1
        ret                                                     #47.3
