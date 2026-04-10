# Counting_Shapes_8086_Assembly

---

## WHAT IS 8086 ASM

8086 ASM is a low-level programming language for Intel's 8086 processor (released 1978). You're writing instructions that talk directly to the CPU

## Key Characteristics
- Registers over variables, instead of named variables, you work with a fixed set of CPU registers like AX, BX, CX, DX
- Manual memory management, you define and manage memory yourself via segments (DATA_SEG, CODE_SEG, STACK_SEG)
- Interrupts for I/O, to print text or read input, you call DOS interrupts like INT 21h instead of printf or scanf
- No data types, everything is just bytes and words (DB, DW).

---

## GENERAL PURPOSE REGISTERS

-8086 CPU has 8 general purpose registers, each register has its own name:
-AX - the accumulator register (divided into AH / AL).
-BX - the base address register (divided into BH / BL).
-CX - the count register (divided into CH / CL).
-DX - the data register (divided into DH / DL).
-SI - source index register.
-DI - destination index register.
-BP - base pointer.
-SP - stack pointer.

-To access memory we can use these four registers: BX, SI, DI, BP.

-The value in segment register (CS, DS, SS, ES) is called a segment, and the value in general purpose register (BX, SI, DI, BP) is called an offset.

-DB define byte - single value
-DW define word - larger value
-DD define doubleword
-DQ define quadword

-DATA_SEG        SEGMENT
-	var_name 	type 	value
-	A                	DB    	9
-	MESSAGE        DB		'HELLOWORLD'   ;10 values (0-9)
-DATA_SEG        ENDS

-$ = terminate string
-13,10 = \r\n

Arrays in 8086

-name 	type 	value
-a		DB		22h, 23h, 24h, 25h
-				a[0], a[1], a[2], a[3]

---
