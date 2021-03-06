.section .vram

.include "consts.s"

.global address_read_table_32bit_dtcm_setup
address_read_table_32bit_dtcm_setup:
	ldr r10,= address_read_table_32bit_dtcm
	ldr r11,= address_read_table_32bit
	mov r12, #0x20C
address_read_table_32bit_dtcm_setup_loop:
	ldr r13, [r11], #4
	strh r13, [r10], #2
	subs r12, #4
	bne address_read_table_32bit_dtcm_setup_loop
	bx lr

.global address_read_table_16bit_dtcm_setup
address_read_table_16bit_dtcm_setup:
	ldr r10,= address_read_table_16bit_dtcm
	ldr r11,= address_read_table_16bit
	mov r12, #0x20C
address_read_table_16bit_dtcm_setup_loop:
	ldr r13, [r11], #4
	strh r13, [r10], #2
	subs r12, #2
	bne address_read_table_16bit_dtcm_setup_loop
	bx lr

.global address_read_table_8bit_dtcm_setup
address_read_table_8bit_dtcm_setup:
	ldr r10,= address_read_table_8bit_dtcm
	ldr r11,= address_read_table_8bit
	mov r12, #0x20C
address_read_table_8bit_dtcm_setup_loop:
	ldr r13, [r11], #4
	strh r13, [r10], #2
	subs r12, #1
	bne address_read_table_8bit_dtcm_setup_loop
	bx lr

.global address_write_table_32bit_dtcm_setup
address_write_table_32bit_dtcm_setup:
	ldr r10,= address_write_table_32bit_dtcm
	ldr r11,= address_write_table_32bit
	mov r12, #0x20C
address_write_table_32bit_dtcm_setup_loop:
	ldr r13, [r11], #4
	strh r13, [r10], #2
	subs r12, #4
	bne address_write_table_32bit_dtcm_setup_loop
	bx lr

.global address_write_table_16bit_dtcm_setup
address_write_table_16bit_dtcm_setup:
	ldr r10,= address_write_table_16bit_dtcm
	ldr r11,= address_write_table_16bit
	mov r12, #0x20C
address_write_table_16bit_dtcm_setup_loop:
	ldr r13, [r11], #4
	strh r13, [r10], #2
	subs r12, #2
	bne address_write_table_16bit_dtcm_setup_loop
	bx lr

.global address_write_table_8bit_dtcm_setup
address_write_table_8bit_dtcm_setup:
	ldr r10,= address_write_table_8bit_dtcm
	ldr r11,= address_write_table_8bit
	mov r12, #0x20C
address_write_table_8bit_dtcm_setup_loop:
	ldr r13, [r11], #4
	strh r13, [r10], #2
	subs r12, #1
	bne address_write_table_8bit_dtcm_setup_loop
	bx lr

.global count_bits_initialize
count_bits_initialize:
	ldr r0,= address_count_bit_table
	mov r1, #0
count_bits_initialize_loop:
	and	r3, r1, #0xAA
	sub	r2, r1, r3, lsr #1
		
	and	r3, r2, #0xCC
	and	r2, r2, #0x33
	add	r2, r2, r3, lsr #2
		
	add	r2, r2, r2, lsr #4
	and	r2, r2, #0xF
	strb r2, [r0], #1
	add r1, r1, #1
	cmp r1, #0x100
	bne count_bits_initialize_loop
	bx lr

count_bits_set_16_lookup:
	ldr r2,= address_count_bit_table
	and r1, r0, #0xFF
	ldrb r1, [r2, r1]
	ldrb r0, [r2, r0, lsr #8]
	add r0, r0, r1
	bx lr

count_bits_set_8_lookup:
	ldr r1,= address_count_bit_table
	ldrb r0, [r1, r0]
	bx lr

.global print_address
print_address:
	push {r0-r4}
	ldr r1,= nibble_to_char
	ldr r4,= (0x06202000 + 32 * 10)
	//print address to bottom screen
	ldrb r2, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	ldrb r3, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	orr r2, r2, r3, lsl #8
	strh r2, [r4], #2

	ldrb r2, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	ldrb r3, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	orr r2, r2, r3, lsl #8
	strh r2, [r4], #2

	ldrb r2, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	ldrb r3, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	orr r2, r2, r3, lsl #8
	strh r2, [r4], #2

	ldrb r2, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	ldrb r3, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	orr r2, r2, r3, lsl #8
	strh r2, [r4], #2
	pop {r0-r4}
	bx lr

.global print_address2
print_address2:
	push {r0-r4}
	ldr r1,= nibble_to_char
	ldr r4,= (0x06202000 + 32 * 11)
	//print address to bottom screen
	ldrb r2, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	ldrb r3, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	orr r2, r2, r3, lsl #8
	strh r2, [r4], #2

	ldrb r2, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	ldrb r3, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	orr r2, r2, r3, lsl #8
	strh r2, [r4], #2

	ldrb r2, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	ldrb r3, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	orr r2, r2, r3, lsl #8
	strh r2, [r4], #2

	ldrb r2, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	ldrb r3, [r1, r0, lsr #28]
	mov r0, r0, lsl #4
	orr r2, r2, r3, lsl #8
	strh r2, [r4], #2
	pop {r0-r4}
	bx lr