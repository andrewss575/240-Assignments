;Below is c pseudocode, take this code and convert it into assembly

;unsigned short num1 = 40000;			//data type: 16 bits
;unsigned short num2 = 60000;			//data type: 16 bits
;unsigned short num3 = 50000;			//data type: 16 bits
;unsigned short num4 = 201;			//data type: 16 bits
;unsigned int sum = 0;				//data type: 32 bits
							
;unsigned long product = 0;			//data type: 64 bits
;unsigned int quotient = 0;			//data type: 32 bits

;sum = int(num1 + num2);
;product = long(sum * int(num3));
;quotient = int(product / int(num4));

;//also have a remainder variable in assembly for its remainder


section .data

;declaring varibales with the SAME size as declared in the C psuedocode above
num1		dw	40000			;num1 = 0x9C40
num2		dw	60000			;num2 = 0xEA60
num3		dw	50000			;num3 = 0xC350
num4		dw	201			;num4 = 0x00C0
sum		dd	0			;sum = 0x0000 0000
product		dq	0			;product = 0x0000 0000 0000 0000
quotient	dd	0			;quotient = 0x0000 0000
remainder	dd	0			;remainder = 0x0000 0000

section .text

global _start

_start:
	;adding num1 + num2 and storing into sum
	mov ax, word[num1]			;ax = 40000 = 0x9C40
	add ax, word[num2]			;ax + word[num1] = 40000(0x9C40) + 60000(0xEA60) = 100000(0x186A0) -> ax = 0x86A0
	
	; The add instruction above attempts to add 40,000 and 60,000 and stores it into 16-bit register ax. 
	; But because the answer is 100000(0x186A0 - 17 bits), and 100000 cannot fit in ax(since ax is a word size and 
	; the limit for an unsiged word is 0 - 65,535), the least significant  16 bits gets stored in ax (0x86A0), 
	; while that extra unaccounted 17th bit gets stored into our CF(carry flag). Now our CF is 1, we 
	; have to extract that 1 and store it into a register using the adc command. It can be any 
	; register(other than the register we chose to add with, ax), as long as its 16-bits 
	; too (because we used ax which is 16-bits). I chose cx here, and what the adc command does is it adds
	; 0(because that's what we put after the comma) and CF(which is currenlty 1 due to the previous add instruction) 
	; and stores it into cx
	adc cx, 0				;cx = 0 + CF = 0 + 1 = 1 = 0x0001
	
	; so now at this point ax is 0x86A0 and cx is 0x0001. If you look at them seperately, they do not equal 100000 
	; but if you concatenate(combine) them together, you will. We can then store that concatenation into the sum variable by
	; the next two operations below. We can do this because the sum variable was declared as a double word instead, so 100000 
	; can fit into it
	mov word[sum], ax			;sum = ax = 0x0000 86A0
	
	; we want to add cx(0x0001) to the front of sum's hex (0x86A0) in order to get 0x186A0. To do that, we have to '+ 2' to sum.
	; This is because if we were to simply move the value cx into sum, it would replace sum with what it already contained, 
	; so sum would just convert to 1. To avoid that, we use the + operator where, for every 1 that you add, you move 2 hex 	
	; digits(which represents a byte) to the left. So the instruction 'mov word[sum+2], cx' will move cx's contents (0x0001),
	; to sum but 4 hex digits in. So sum would then go from 0x0000 86A0 to 0x0001 86A0 which is 100,000.
	mov word[sum+2], cx			;sum = 0x0001 86A0
	
	;sum * num3 = product
	
	; When it comes to multiplication, it always uses an rax register(rax, eax, ax, or al) as one of the multipliers.
	; Since we are multiplying sum, we can store sum into an rax register, and because sum is a dword(32-bits), we use eax(32-bits).
	mov eax, dword[sum]
	
	; Now we would want to multiply by num3, but there is a problem. The problem is, when completing an operation between two 
	; values, those values but be in the same data range. So, because sum/eax is a double word and num3 is a word, we cannot 
	; compute the multiplication.
	
	; There are two possible solutions. The first solution is to just treat num3 as a double word even though we declared it as a 
	; word. This will work, however, it doesnt follow the c code above that we want to transform into assembly. The professor may 
	; knock points off if this method is used
	;
	; The second solution follows the c code from above and is what I will be using. You know to use this method if you see 
	; something like 'int(num3)' in c code. This lets us know that we want to take num3 and convert it to an int(32-bits)
	; For this solution, we move num3 into a word-size register(it can be any word size register that is NOT ax), and then 
	; we expand that register to double-word size register(32-bits). This practice is called widening conversion and is done 
	; through the instruction : movzx( for unisgned numbers). When we widen the register, both multipliers will be the same 
	; data size, and then it would be possible to use the mul instruction
	mov dx, word[num3]			;dx = num3 = 50000 = 0xC350
	
	;Here we are widening 16-bit dx(second argument) to 32-bit register edx(first argument)
	movzx edx, dx				;dx = 0xC350 -> eax = 0x0000 C350
	
	; When we multiply 100000*50000, you get 5 billion, and the assembler attempts to store that into eax. However, eax is 
	; double-word sized(32-bits), and the max number unsigned 32-bits can hold is 4,294,967,296, so 5 billion cannot simply fit 
	; into eax. To combat this, the mul instruction automatically stores the leading bits int edx (no need to involve the CF). 
	; Note: The leading bits will always get stored in an rdx register. So for this case, the least significant 
	; 32-bits of 5 billion gets stored in eax (0x2A05 F200), while the remaining bits gets stored
	; in edx (0x0000 00001)
	mul edx					;edx:eax = eax * edx = 100000 * 50000 = 5,000,000,000
	
	; so now at this point eax is 0x2A05 F200 and edx is 0x0000 0001. If you look at them seperately, they do not equal 5 billion
	; but if you concatenate(combine) them together, you will. We can then store that concatenation into the product variable by
	; the next two operations below. We can do this because the product variable was declared as a quad-word instead(64-bits), so 
	; 5 billion can fit into it
	mov dword[product], eax			;product = eax = 0x0000 0000 2A05 F200
	
	; we want to add edx(0x0000 0001) to the front of product's hex (0x2A05 F200) in order to get 0x0000 00001 2A05 F200 or 
	; 5 billion. To do that, we have to '+ 4' to the product variable. This is because if we were to simply move the value edx 
	; into product, it would replace product varibale with what it already contained, so product would just convert to 1. 
	; To avoid that, we use the + operator where, for every 1 that you add, you move 2 hex digits(which represents a byte)
	; to the left. So the instruction 'mov dword[product+4], edx' will move edx's contents (0x0000 0001), to product but 
	; 8 hex digits in. So product would then go from 0x0000 0000 2A05 F200 to 0x0000 0001 2A05 F200 which is 5 billion
	mov dword[product + 4], edx		;product = 0x0000 0001 2A05 F200 = 5,000,000,000
	
	; product / num4 = quotient (remainder too)
	; Now division is a bit tricky. The same idea falls true that when completing any operation like division, where data sizes 
	; of all values invloved have to be the same. So we have to manipulate our data to make that assumption true. We know that 
	; the product variable is 64-bits(quad-word) and our divisior(num4) is 16-bits(word). We want these variables to be the same 
	; data size in order to run the div instruction. Heres how we do it:
	
	; First, we can break down our 64-bit variable, product, into 2 seperate 32-bit numbers by splitting it into the eax and edx 
	; registers. That is shown in next two instructions. The div instruction will automatically take into account both edx and eax 
	; as the dividend when dividing. Please note that eax and edx already had the right values in them from our previous mul 
	; instruction, but I split product into the registers again just for learning purposes.
	mov eax, dword[product]			;eax = 0x 2A05 F200
	mov edx, dword[product+4]		;edx = 0x 0000 0001
	
	; At this point, we moved product into 2 32-bit registers but num4 is still word-sized. We need num4 to also be             ;
	; 32-bits(double-word sized) so we start with moving num4 into a word sized register. It can be any register besides 
	; one from rax and rdx, as long as its word-sized. I chose cx. Then, we use widening conversions to convert 16-bit cx into 32 
	; bit ecx. This is shown in next two instructions.
	mov cx, word[num4]			;cx = 0x009C
	movzx ecx, cx				;ecx = cx = 0x0000 009C
	
	; now that product is split into 2 32-bit registers eax and edx, and num4 is moved into a 32-bit register ecx, we can now 
	; correctly divide without any errors. The quotient will get stored in eax while remainder gets stored in edx.
	div ecx					;edx:eax/ecx = 5,000,000,000/201 = 24875621 R 179
	
	;moving the quotient(eax) and remainder(edx) into their respected variables
	mov dword[quotient], eax		;quotient = eax = 24875621 = 0x017B 9265
	mov dword[remainder], edx		;remainder = edx = 179 = 0x0000 00B3
	
	;instructions to end program
	mov rax, 60
	mov rdi, 0
	syscall
	
	
	
