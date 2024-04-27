.686 
.model flat,stdcall 
 
.stack 100h 
 
.data 
fr dw 4
coef dd -1.5,2.6,1.6
D dd ?
 
.code 
ExitProcess PROTO STDCALL :DWORD 
Start: 

xor eax,eax

call FindRoots  

ja tworoots; Дискриминант > 0
jb noroots; Дискриминант < 0
je oneroot; Дискриминант = 0

tworoots:
mov ax,2
jmp exit

noroots:
mov ax,0
jmp exit

oneroot:
mov ax,1
jmp exit

FindRoots proc
	FINIT; инициализация сопроцессора
	FILD fr; передача 4 в стек 
	FLD coef[0]; передача 1-го элемента массива в стек 
	FLD coef[4]; передача 2-го элемента массива в стек 
	FLD coef[8]; передача 3-го элемента массива в стек 
	fmul st, st(2); умножение A на C
	fmul st, st(3); умножение (A*C) на 4
	fxch st(1); обмен 1-го и 2-го регистров r
	fmul st, st; возведение "B" в квадрат
	fsub st, st(1); вычитание (4*A*C) из B^2
	FLDZ; ввод нуля в стек
	fxch st(1); обмен 1-го и 2-го регистров r
	fcomi st, st(1); сравнение дискриминанта(B^2 - 4*A*C) с 0

	ret
FindRoots endp

exit: 
Invoke ExitProcess,ax 
End Start