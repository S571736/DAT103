cr equ 13 ; Vognretur
lf equ 10 ; Linjeskift
SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1
STDERR equ 2

section .bss
a resb 4
i resb 4

section .data
crlf db cr,lf
crlflen equ $ - crlf

section .text

global _start

_start:

mov [a], byte 0
mov [i], byte 0

for:
for_cond:
cmp [i],byte 20 ;sammenligne i med 20
jge for_end

cmp [i], byte 10
jge elseBody ;hopper til elseBody om a er større enn 10
inc byte [a] ;a++
jmp ifEnd

elseBody:
dec byte [a] ;a--

ifEnd:


for_update:
inc byte [i]
jmp for

for_end:

; Printer og exit
add byte [a], '0'
mov ecx, a
mov edx, 1
mov ebx, STDOUT
mov eax, SYS_WRITE
int 80h

call nyLinje


mov eax, 1
mov ebx, 0
int 80h


nyLinje:
push eax
push ebx
push ecx
push edx
mov edx,crlflen
mov ecx,crlf
mov ebx,STDOUT
mov eax,SYS_WRITE
int 80h
pop edx
pop ecx
pop ebx
pop eax
ret

