.section .data
	.macro linea
	#	.int 1,-2,1,-2
	#	.int 1,2,-3,-4
	#	.int 0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff
	#	.int 0x80000000, 0x80000000, 0x80000000, 0x80000000
	#	.int 0xf0000000, 0xe0000000, 0xe0000000, 0xd0000000
	#	.int -1,-1,-1,-1
	
	.endm
	.macro linea0
	#	.int 0,-1,-1,-1
	#	.int 0,-2,-1,-1
	#	.int 1,-2,-1,-1
	#	.int 15,-2,-1,-1
	#	.int 32,-2,-1,-1
	#	.int 47,-2,-1,-1
	#	.int 63,-2,-1,-1
	#	.int 64,-2,-1,-1
	#	.int 82,-2,-1,-1
	#	.int 95,-2,-1,-1
	#	.int -31,-2,-1,-1
	#	.int -13,-2,-1,-1
	#	.int 0,-2,-1,-1
	.endm

lista:		linea0
	 .irpc i,1234567
		linea
	.endr
longlista:	
		.int (.-lista)/4
media: .int -1
resto: .int -1

formato:
	.ascii "media=%8d \t resto = %8d \n" 		#formato para 4 nums
	.ascii "hexadec 0x%08x \t resto = 0x%08x\n\0" 	#med/resto, dec/hex

.section .text
#_start:	.global _start
main: .global main

	mov    $lista, %ebx
	mov longlista, %ecx
	call suma
	mov %eax, media
	mov %edx, resto

	push resto
	push media
	push resto
	push media
	push $formato
	call printf
	add $20,%esp

	mov $1, %eax
	mov $0, %ebx
	int $0x80

suma:
	mov $0, %ebp
	mov $0, %edi
	mov $0, %esi

bucle:
	mov (%ebx,%esi,4), %eax
	cltd
	add %eax, %edi
	adc %edx, %ebp #adc es add con acarreo
	inc %esi
	cmp %esi, %ecx
	jne bucle

	mov %edi, %eax
	mov %ebp, %edx
	
	idiv %ecx
	ret

