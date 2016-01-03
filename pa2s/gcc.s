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

.globl	pa2s
.type	pa2s, @function
# void pa2s (const rgba_pa *restrict pa, rgba_s *restrict s, size_t n)
# pa2s (rdi *, rsi *, rdx)
pa2s:
        mov     rcx, rdx  # n, n
        shl     rcx, 3    # n,
        je      .L36        #,
        push    r15     #
        shl     rdx, 5    # D.4550,
        push    r14     #
        add     rdx, rsi  # D.4552, s
        push    r13     #
        push    r12     #
        push    rbp     #
        push    rbx     #
        mov     r8, QWORD PTR [rdi]       # D.4551, pa_9(D)->r
        mov     r9, QWORD PTR [rdi+8]     # D.4551, pa_9(D)->g
        mov     r10, QWORD PTR [rdi+16]   # D.4551, pa_9(D)->b
        mov     rdi, QWORD PTR [rdi+24]   # D.4551, pa_9(D)->a
        lea     rax, [r8+rcx]     # D.4546,
        cmp     rsi, rax  # s, D.4546
        setnb   bl    #, D.4547
        cmp     r8, rdx   # D.4551, D.4552
        setnb   al    #, D.4547
        or      ebx, eax    # D.4547, D.4547
        lea     rax, [r9+rcx]     # D.4546,
        cmp     rsi, rax  # s, D.4546
        setnb   al    #, D.4547
        cmp     rdx, r9   # D.4552, D.4551
        setbe   r11b  #, D.4547
        or      eax, r11d   # D.4547, D.4547
        and     eax, ebx  # D.4547, D.4547
        cmp     rcx, 15   # n,
        seta    r11b    #, D.4547
        and     eax, r11d # D.4547, D.4547
        lea     r11, [r10+rcx]    # D.4546,
        cmp     rsi, r11  # s, D.4546
        setnb   bl    #, D.4547
        cmp     rdx, r10  # D.4552, D.4551
        setbe   r11b  #, D.4547
        or      r11d, ebx   # D.4547, D.4547
        test    al, r11b        # D.4547, D.4547
        je      .L11        #,
        lea     rax, [rdi+rcx]    # D.4546,
        cmp     rsi, rax  # s, D.4546
        setnb   r11b  #, D.4547
        cmp     rdx, rdi  # D.4552, D.4551
        setbe   al    #, D.4547
        or      r11b, al    # tmp302, D.4547
        je      .L11        #,
        lea     rdx, [rcx-16]     # D.4555,
        shr     rdx, 4    # D.4555,
        lea     r12, [rdx+1]      # bnd.16,
        sub     rdx, 4    # D.4555,
        mov     rax, r12  # x, bnd.16
        shl     rax, 4    # x,
        cmp     rdx, -6   # D.4555,
        ja      .L21        #,
        shr     rdx, 2    # D.4555,
        mov     r13, rdi  # vectp_pretmp.28, D.4551
        mov     rbp, r10  # vectp_pretmp.25, D.4551
        lea     r15, [4+rdx*4]    # ivtmp.66,
        mov     rbx, r9   # vectp_pretmp.22, D.4551
        mov     rdx, rsi  # vectp_s.31, s
        mov     r11, r8   # vectp_pretmp.19, D.4551
        xor     r14d, r14d        # D.4549
.L13:
        vmovdqu xmm1, XMMWORD PTR [r11]   # MEM[base: vectp_pretmp.19_105, offset: 0B], MEM[base: vectp_pretmp.19_105, offset: 0B]
        add     r14, 4    # D.4549,
        add     r11, 64   # vectp_pretmp.19,
        prefetcht0      [rdx+560]   #
        vmovdqu xmm2, XMMWORD PTR [rbx]   # MEM[base: vectp_pretmp.22_109, offset: 0B], MEM[base: vectp_pretmp.22_109, offset: 0B]
        add     rbp, 64   # vectp_pretmp.25,
        add     rbx, 64   # vectp_pretmp.22,
        add     r13, 64   # vectp_pretmp.28,
        vmovdqu xmm5, XMMWORD PTR [r13-64]        # MEM[base: vectp_pretmp.28_117, offset: 0B], MEM[base: vectp_pretmp.28_117, offset: 0B]
        prefetcht0      [rdx+624]   #
        prefetcht0      [rdx+688]   #
        prefetcht0      [rdx+752]   #
        vmovdqu xmm0, XMMWORD PTR [rbp-64]        # MEM[base: vectp_pretmp.25_113, offset: 0B], MEM[base: vectp_pretmp.25_113, offset: 0B]
        add     rdx, 256  # vectp_s.31,
        vpunpcklbw      xmm4, xmm2, xmm5    # D.4548, MEM[base: vectp_pretmp.22_109, offset: 0B], MEM[base: vectp_pretmp.28_117, offset: 0B]
        vpunpcklbw      xmm3, xmm1, xmm0    # D.4548, MEM[base: vectp_pretmp.19_105, offset: 0B], MEM[base: vectp_pretmp.25_113, offset: 0B]
        vpunpckhbw      xmm0, xmm1, xmm0    # D.4548, MEM[base: vectp_pretmp.19_105, offset: 0B], MEM[base: vectp_pretmp.25_113, offset: 0B]
        vpunpckhbw      xmm1, xmm2, xmm5    # D.4548, MEM[base: vectp_pretmp.22_109, offset: 0B], MEM[base: vectp_pretmp.28_117, offset: 0B]
        vpunpcklbw      xmm2, xmm3, xmm4    # D.4548, D.4548, D.4548
        vpunpckhbw      xmm3, xmm3, xmm4    # D.4548, D.4548, D.4548
        vmovups XMMWORD PTR [rdx-256], xmm2       # MEM[base: vectp_s.31_121, offset: 0B], D.4548
        vpunpcklbw      xmm2, xmm0, xmm1    # D.4548, D.4548, D.4548
        vpunpckhbw      xmm0, xmm0, xmm1    # D.4548, D.4548, D.4548
        vmovups XMMWORD PTR [rdx-240], xmm3       # MEM[base: vectp_s.31_121, offset: 16B], D.4548
        vmovups XMMWORD PTR [rdx-224], xmm2       # MEM[base: vectp_s.31_121, offset: 32B], D.4548
        vmovups XMMWORD PTR [rdx-208], xmm0       # MEM[base: vectp_s.31_121, offset: 48B], D.4548
        vmovdqu xmm1, XMMWORD PTR [r11-48]        # MEM[base: vectp_pretmp.19_105, offset: 16B], MEM[base: vectp_pretmp.19_105, offset: 16B]
        vmovdqu xmm2, XMMWORD PTR [rbx-48]        # MEM[base: vectp_pretmp.22_109, offset: 16B], MEM[base: vectp_pretmp.22_109, offset: 16B]
        vmovdqu xmm5, XMMWORD PTR [r13-48]        # MEM[base: vectp_pretmp.28_117, offset: 16B], MEM[base: vectp_pretmp.28_117, offset: 16B]
        vmovdqu xmm0, XMMWORD PTR [rbp-48]        # MEM[base: vectp_pretmp.25_113, offset: 16B], MEM[base: vectp_pretmp.25_113, offset: 16B]
        vpunpcklbw      xmm4, xmm2, xmm5    # D.4548, MEM[base: vectp_pretmp.22_109, offset: 16B], MEM[base: vectp_pretmp.28_117, offset: 16B]
        vpunpcklbw      xmm3, xmm1, xmm0    # D.4548, MEM[base: vectp_pretmp.19_105, offset: 16B], MEM[base: vectp_pretmp.25_113, offset: 16B]
        vpunpckhbw      xmm0, xmm1, xmm0    # D.4548, MEM[base: vectp_pretmp.19_105, offset: 16B], MEM[base: vectp_pretmp.25_113, offset: 16B]
        vpunpckhbw      xmm1, xmm2, xmm5    # D.4548, MEM[base: vectp_pretmp.22_109, offset: 16B], MEM[base: vectp_pretmp.28_117, offset: 16B]
        vpunpcklbw      xmm2, xmm3, xmm4    # D.4548, D.4548, D.4548
        vpunpckhbw      xmm3, xmm3, xmm4    # D.4548, D.4548, D.4548
        vmovups XMMWORD PTR [rdx-192], xmm2       # MEM[base: vectp_s.31_121, offset: 64B], D.4548
        vpunpcklbw      xmm2, xmm0, xmm1    # D.4548, D.4548, D.4548
        vpunpckhbw      xmm0, xmm0, xmm1    # D.4548, D.4548, D.4548
        vmovups XMMWORD PTR [rdx-176], xmm3       # MEM[base: vectp_s.31_121, offset: 80B], D.4548
        vmovups XMMWORD PTR [rdx-160], xmm2       # MEM[base: vectp_s.31_121, offset: 96B], D.4548
        vmovups XMMWORD PTR [rdx-144], xmm0       # MEM[base: vectp_s.31_121, offset: 112B], D.4548
        vmovdqu xmm1, XMMWORD PTR [r11-32]        # MEM[base: vectp_pretmp.19_105, offset: 32B], MEM[base: vectp_pretmp.19_105, offset: 32B]
        vmovdqu xmm2, XMMWORD PTR [rbx-32]        # MEM[base: vectp_pretmp.22_109, offset: 32B], MEM[base: vectp_pretmp.22_109, offset: 32B]
        vmovdqu xmm5, XMMWORD PTR [r13-32]        # MEM[base: vectp_pretmp.28_117, offset: 32B], MEM[base: vectp_pretmp.28_117, offset: 32B]
        vmovdqu xmm0, XMMWORD PTR [rbp-32]        # MEM[base: vectp_pretmp.25_113, offset: 32B], MEM[base: vectp_pretmp.25_113, offset: 32B]
        vpunpcklbw      xmm4, xmm2, xmm5    # D.4548, MEM[base: vectp_pretmp.22_109, offset: 32B], MEM[base: vectp_pretmp.28_117, offset: 32B]
        vpunpcklbw      xmm3, xmm1, xmm0    # D.4548, MEM[base: vectp_pretmp.19_105, offset: 32B], MEM[base: vectp_pretmp.25_113, offset: 32B]
        vpunpckhbw      xmm0, xmm1, xmm0    # D.4548, MEM[base: vectp_pretmp.19_105, offset: 32B], MEM[base: vectp_pretmp.25_113, offset: 32B]
        vpunpckhbw      xmm1, xmm2, xmm5    # D.4548, MEM[base: vectp_pretmp.22_109, offset: 32B], MEM[base: vectp_pretmp.28_117, offset: 32B]
        vpunpcklbw      xmm2, xmm3, xmm4    # D.4548, D.4548, D.4548
        vpunpckhbw      xmm3, xmm3, xmm4    # D.4548, D.4548, D.4548
        vmovups XMMWORD PTR [rdx-128], xmm2       # MEM[base: vectp_s.31_121, offset: 128B], D.4548
        vpunpcklbw      xmm2, xmm0, xmm1    # D.4548, D.4548, D.4548
        vpunpckhbw      xmm0, xmm0, xmm1    # D.4548, D.4548, D.4548
        vmovups XMMWORD PTR [rdx-112], xmm3       # MEM[base: vectp_s.31_121, offset: 144B], D.4548
        vmovups XMMWORD PTR [rdx-96], xmm2        # MEM[base: vectp_s.31_121, offset: 160B], D.4548
        vmovups XMMWORD PTR [rdx-80], xmm0        # MEM[base: vectp_s.31_121, offset: 176B], D.4548
        vmovdqu xmm1, XMMWORD PTR [r11-16]        # MEM[base: vectp_pretmp.19_105, offset: 48B], MEM[base: vectp_pretmp.19_105, offset: 48B]
        vmovdqu xmm2, XMMWORD PTR [rbx-16]        # MEM[base: vectp_pretmp.22_109, offset: 48B], MEM[base: vectp_pretmp.22_109, offset: 48B]
        vmovdqu xmm0, XMMWORD PTR [rbp-16]        # MEM[base: vectp_pretmp.25_113, offset: 48B], MEM[base: vectp_pretmp.25_113, offset: 48B]
        vmovdqu xmm5, XMMWORD PTR [r13-16]        # MEM[base: vectp_pretmp.28_117, offset: 48B], MEM[base: vectp_pretmp.28_117, offset: 48B]
        vpunpcklbw      xmm3, xmm1, xmm0    # D.4548, MEM[base: vectp_pretmp.19_105, offset: 48B], MEM[base: vectp_pretmp.25_113, offset: 48B]
        vpunpckhbw      xmm0, xmm1, xmm0    # D.4548, MEM[base: vectp_pretmp.19_105, offset: 48B], MEM[base: vectp_pretmp.25_113, offset: 48B]
        vpunpcklbw      xmm4, xmm2, xmm5    # D.4548, MEM[base: vectp_pretmp.22_109, offset: 48B], MEM[base: vectp_pretmp.28_117, offset: 48B]
        vpunpckhbw      xmm1, xmm2, xmm5    # D.4548, MEM[base: vectp_pretmp.22_109, offset: 48B], MEM[base: vectp_pretmp.28_117, offset: 48B]
        vpunpcklbw      xmm2, xmm3, xmm4    # D.4548, D.4548, D.4548
        vpunpckhbw      xmm3, xmm3, xmm4    # D.4548, D.4548, D.4548
        vmovups XMMWORD PTR [rdx-64], xmm2        # MEM[base: vectp_s.31_121, offset: 192B], D.4548
        vpunpcklbw      xmm2, xmm0, xmm1    # D.4548, D.4548, D.4548
        vpunpckhbw      xmm0, xmm0, xmm1    # D.4548, D.4548, D.4548
        vmovups XMMWORD PTR [rdx-48], xmm3        # MEM[base: vectp_s.31_121, offset: 208B], D.4548
        vmovups XMMWORD PTR [rdx-32], xmm2        # MEM[base: vectp_s.31_121, offset: 224B], D.4548
        vmovups XMMWORD PTR [rdx-16], xmm0        # MEM[base: vectp_s.31_121, offset: 240B], D.4548
        cmp     r15, r14  # ivtmp.66, D.4549
        jne     .L13      #,
.L12:
        xor     r14d, r14d        # ivtmp.61
.L17:
        vmovdqu xmm3, XMMWORD PTR [rbp+0+r14]     # MEM[base: vectp_pretmp.25_158, index: ivtmp.61_82, offset: 0B], MEM[base: vectp_pretmp.25_158, index: ivtmp.61_82, offset: 0B]
        add     r15, 1    # ivtmp.66,
        vmovdqu xmm4, XMMWORD PTR [r13+0+r14]     # MEM[base: vectp_pretmp.28_159, index: ivtmp.61_82, offset: 0B], MEM[base: vectp_pretmp.28_159, index: ivtmp.61_82, offset: 0B]
        vmovdqu xmm0, XMMWORD PTR [r11+r14]       # MEM[base: vectp_pretmp.19_156, index: ivtmp.61_82, offset: 0B], MEM[base: vectp_pretmp.19_156, index: ivtmp.61_82, offset: 0B]
        vmovdqu xmm1, XMMWORD PTR [rbx+r14]       # MEM[base: vectp_pretmp.22_157, index: ivtmp.61_82, offset: 0B], MEM[base: vectp_pretmp.22_157, index: ivtmp.61_82, offset: 0B]
        vpunpcklbw      xmm2, xmm0, xmm3    # D.4548, MEM[base: vectp_pretmp.19_156, index: ivtmp.61_82, offset: 0B], MEM[base: vectp_pretmp.25_158, index: ivtmp.61_82, offset: 0B]
        vpunpckhbw      xmm0, xmm0, xmm3    # D.4548, MEM[base: vectp_pretmp.19_156, index: ivtmp.61_82, offset: 0B], MEM[base: vectp_pretmp.25_158, index: ivtmp.61_82, offset: 0B]
        vpunpcklbw      xmm3, xmm1, xmm4    # D.4548, MEM[base: vectp_pretmp.22_157, index: ivtmp.61_82, offset: 0B], MEM[base: vectp_pretmp.28_159, index: ivtmp.61_82, offset: 0B]
        vpunpckhbw      xmm1, xmm1, xmm4    # D.4548, MEM[base: vectp_pretmp.22_157, index: ivtmp.61_82, offset: 0B], MEM[base: vectp_pretmp.28_159, index: ivtmp.61_82, offset: 0B]
        vpunpcklbw      xmm4, xmm2, xmm3    # D.4548, D.4548, D.4548
        vpunpckhbw      xmm2, xmm2, xmm3    # D.4548, D.4548, D.4548
        vmovups XMMWORD PTR [rdx+r14*4], xmm4     # MEM[base: vectp_s.31_160, index: ivtmp.61_82, step: 4, offset: 0B], D.4548
        vmovups XMMWORD PTR [rdx+16+r14*4], xmm2  # MEM[base: vectp_s.31_160, index: ivtmp.61_82, step: 4, offset: 16B], D.4548
        vpunpcklbw      xmm2, xmm0, xmm1    # D.4548, D.4548, D.4548
        vpunpckhbw      xmm0, xmm0, xmm1    # D.4548, D.4548, D.4548
        vmovups XMMWORD PTR [rdx+32+r14*4], xmm2  # MEM[base: vectp_s.31_160, index: ivtmp.61_82, step: 4, offset: 32B], D.4548
        vmovups XMMWORD PTR [rdx+48+r14*4], xmm0  # MEM[base: vectp_s.31_160, index: ivtmp.61_82, step: 4, offset: 48B], D.4548
        add     r14, 16   # ivtmp.61,
        cmp     r12, r15  # bnd.16, ivtmp.66
        ja      .L17        #,
        lea     rdx, [rsi+rax*4]  # ivtmp.50,
        cmp     rcx, rax  # n, x
        je      .L33        #,
.L14:
        movzx   esi, BYTE PTR [r8+rax]        # D.4554, MEM[base: _32, index: x_80, offset: 0B]
        add     rdx, 4    # ivtmp.50,
        mov     BYTE PTR [rdx-4], sil     # MEM[base: _61, offset: 0B], D.4554
        movzx   esi, BYTE PTR [r9+rax]        # D.4554, MEM[base: _34, index: x_80, offset: 0B]
        mov     BYTE PTR [rdx-3], sil     # MEM[base: _61, offset: 1B], D.4554
        movzx   esi, BYTE PTR [r10+rax]       # D.4554, MEM[base: _36, index: x_80, offset: 0B]
        mov     BYTE PTR [rdx-2], sil     # MEM[base: _61, offset: 2B], D.4554
        movzx   esi, BYTE PTR [rdi+rax]       # D.4554, MEM[base: _38, index: x_80, offset: 0B]
        add     rax, 1    # x,
        mov     BYTE PTR [rdx-1], sil     # MEM[base: _61, offset: 3B], D.4554
        cmp     rcx, rax  # n, x
        ja      .L14        #,
.L33:
        pop     rbx       #
        pop     rbp       #
        pop     r12       #
        pop     r13       #
        pop     r14       #
        pop     r15       #
.L36:
        ret
.L11:
        xor     eax, eax  # x
.L19:
        movzx   edx, BYTE PTR [r8+rax]        # D.4554, MEM[base: _32, index: x_58, offset: 0B]
        add     rsi, 4    # ivtmp.37,
        mov     BYTE PTR [rsi-4], dl      # MEM[base: _229, offset: 0B], D.4554
        movzx   edx, BYTE PTR [r9+rax]        # D.4554, MEM[base: _34, index: x_58, offset: 0B]
        mov     BYTE PTR [rsi-3], dl      # MEM[base: _229, offset: 1B], D.4554
        movzx   edx, BYTE PTR [r10+rax]       # D.4554, MEM[base: _36, index: x_58, offset: 0B]
        mov     BYTE PTR [rsi-2], dl      # MEM[base: _229, offset: 2B], D.4554
        movzx   edx, BYTE PTR [rdi+rax]       # D.4554, MEM[base: _38, index: x_58, offset: 0B]
        add     rax, 1    # x,
        mov     BYTE PTR [rsi-1], dl      # MEM[base: _229, offset: 3B], D.4554
        cmp     rcx, rax  # n, x
        jne     .L19      #,
        pop     rbx       #
        pop     rbp       #
        pop     r12       #
        pop     r13       #
        pop     r14       #
        pop     r15       #
        jmp     .L36      #
.L21:
        mov     rdx, rsi  # vectp_s.31, s
        mov     r13, rdi  # vectp_pretmp.28, D.4551
        mov     rbp, r10  # vectp_pretmp.25, D.4551
        mov     rbx, r9   # vectp_pretmp.22, D.4551
        mov     r11, r8   # vectp_pretmp.19, D.4551
        xor     r15d, r15d        # ivtmp.66
        jmp     .L12      #
