
# 8086 GAS (AT&T) - scroll "SHE" back and forth on 8-digit 7-seg display via 8255
# Figure A wiring: Port A = digit select (active-low), Port B = segments (active-high)
# Assumes the stack (SS:SP) is already initialized by the system.

.code16
.global _start

# --- Constants: 8255 ports (display at 0x640) ---
PORTA = 0x640   # Port A, digit select (active low)
PORTB = 0x641   # Port B, segment data (active high)
PORTC = 0x642   # Port C, not used
CTRL = 0x643   # control register (A1 A0 = 11)
S_PAT = 0x6D   # S = a,c,d,f,g (0110 1101)
H_PAT = 0x76   # H = b,c,e,f,g (0111 0110)
E_PAT = 0x79   # E = a,d,e,f,g (0111 1001)
DELAY = 300    # ~1 ms per digit, tune for CPU clock
FRAMES = 100   # refresh count per scroll step (~0.3 s)
.section .text
_start:

# --- 8255 setup phase ---
mov $0x80, %al 	# control word 1000 0000b
               	# D7=1 mode set, D6-D5=00 group A mode 0
              	# D4=0 port A out, D3=0 port C upper out
               	# D2=0 group B mode 0, D1=0 port B out, D0=0 port C lower out
mov $CTRL, %dx 	# DX = control register
out %al, %dx 		# program the 8255
mov $0xFF, %al 	# all 1s = all digits off (active low)
mov $PORTA, %dx
out %al, %dx 		# blank the display
mov $2, %si 		# SI = digit holding S (start at far right)
mov $1, %bp 		# BP = direction, +1 = left, -1 = right

# --- Scroll phase ---
scroll_loop:
mov $FRAMES, %di 	# DI = refresh count for this position
refresh_loop:

# --- Display S on digit SI ---
mov $S_PAT, %bl 	# BL = pattern for S
mov %si, %cx 		# CX = digit position of S
mov $0xFF, %al
mov $PORTA, %dx
out %al, %dx 		# blank all digits (no ghosting)
mov %bl, %al
mov $PORTB, %dx
out %al, %dx 		# send S segments to port B
mov $0xFE, %al 	# 1111 1110, one 0 at bit 0
rol %cl, %al 		# rotate the 0 to bit CL
mov $PORTA, %dx
out %al, %dx 		# turn on that digit
mov $DELAY, %cx 	# CX = delay count
delay_s:
loop delay_s 		# ~1 ms, dec cx and jnz

# --- Display H on digit SI-1 ---
mov $H_PAT, %bl 	# BL = pattern for H
mov %si, %cx
dec %cx 		# H is one digit right of S
mov $0xFF, %al
mov $PORTA, %dx
out %al, %dx 		# blank all digits
mov %bl, %al
mov $PORTB, %dx
out %al, %dx 		# send H segments to port B
mov $0xFE, %al
rol %cl, %al 		# rotate the 0 to bit CL
mov $PORTA, %dx
out %al, %dx 		# turn on that digit
mov $DELAY, %cx
delay_h:
loop delay_h

# --- Display E on digit SI-2 ---
mov $E_PAT, %bl 	# BL = pattern for E
mov %si, %cx
sub $2, %cx 		# E is two digits right of S
mov $0xFF, %al
mov $PORTA, %dx
out %al, %dx 		# blank all digits
mov %bl, %al
mov $PORTB, %dx
out %al, %dx 		# send E segments to port B
mov $0xFE, %al
rol %cl, %al 		# rotate the 0 to bit CL
mov $PORTA, %dx
out %al, %dx 		# turn on that digit
mov $DELAY, %cx
delay_e:
loop delay_e
dec %di 		# one frame done
jne refresh_loop 	# jump if != (Z=0): frames left?

# --- Shift phase ---
add %bp, %si 		# move the word one digit
cmp $7, %si 		# S on dig-7 (leftmost)?
jne check_right
mov $-1, %bp 		# yes, now scroll right
check_right:
cmp $2, %si 		# E on dig-0 (rightmost)?
jne scroll_loop 	# no, keep going
mov $1, %bp 		# yes, now scroll left
jmp scroll_loop

