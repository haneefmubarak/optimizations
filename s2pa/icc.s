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

.globl	s2pa
.type	s2pa, @function
# void s2pa (const rgba_s *restrict s, rgba_pa *restrict pa, size_t n)
# s2pa (rdi *, rsi *, rdx)
s2pa:
        xor       eax, eax                                      #26.8
        shl       rdx, 3                                        #23.3
        test      rdx, rdx                                      #26.19
        jbe       ..B1.5        # Prob 10%                      #26.19
..B1.3:                         # Preds ..B1.1 ..B1.3
        mov       r8, QWORD PTR [rsi]                           #27.5
        mov       cl, BYTE PTR [rdi+rax*4]                      #27.16
        mov       BYTE PTR [r8+rax], cl                         #27.5
        mov       r10, QWORD PTR [8+rsi]                        #28.5
        mov       r9b, BYTE PTR [1+rdi+rax*4]                   #28.16
        mov       BYTE PTR [r10+rax], r9b                       #28.5
        mov       rcx, QWORD PTR [16+rsi]                       #29.5
        mov       r11b, BYTE PTR [2+rdi+rax*4]                  #29.16
        mov       BYTE PTR [rcx+rax], r11b                      #29.5
        mov       r9, QWORD PTR [24+rsi]                        #30.5
        mov       r8b, BYTE PTR [3+rdi+rax*4]                   #30.16
        mov       BYTE PTR [r9+rax], r8b                        #30.5
        inc       rax                                           #26.22
        cmp       rax, rdx                                      #26.19
        jb        ..B1.3        # Prob 82%                      #26.19
..B1.5:                         # Preds ..B1.3 ..B1.1
        ret                                                     #33.3
