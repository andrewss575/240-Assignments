; #begin define print(addr, n)
; rax = 1;
; rdi = 1;
; rsi = addr of string;
; rdx = n;
; syscall;
; #end
;
; #begin define scan(addr, n)
; rax = 1;
; rdi = 1;
; rsi = addr of buffer;
; rdx = n;
; syscall;
; #end
;
; char num1, num2, result;
; char buf[2];
; char msg1[24] = "Input 1st number (0~9): ";
; char msg2[24] = "Input 2nd number (0~9): ";
; char msg3[24] = "Multiplication result : ";
; char ascii[3] = "00\n";
;
; void main() {
; 	rbx = &msg1;
; 	call toNumber(rbx);
; 	num1 = al;
; 	rbx = &msg2;
; 	call toNumber(rbx);
; 	num2 = al;
; 	al = num1;
; 	bl = num2;
; 	call multiplication();
; 	result = al;
; 	di = short(result);
; 	call toAscii();
; 	cout << msg3;
; 	if(result < 10)
; 		cout << ascii+1;
; 	else
; 		cout << ascii;
; }
;
; void toNumber(char[] message) {
; 	do {
; 		cout << message;
; 		cin >> buf;
; 	} while(buf < '0' || buf > '9');
; 		al = atoi(buf);
; 	}
;
; void multiplication() {
; 	ax = al * bl;
; }
;
; void toAscii() {
; 	ascii = itoa(result);
; }
