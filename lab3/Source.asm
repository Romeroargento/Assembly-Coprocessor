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

ja tworoots; ������������ > 0
jb noroots; ������������ < 0
je oneroot; ������������ = 0

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
	FINIT; ������������� ������������
	FILD fr; �������� 4 � ���� 
	FLD coef[0]; �������� 1-�� �������� ������� � ���� 
	FLD coef[4]; �������� 2-�� �������� ������� � ���� 
	FLD coef[8]; �������� 3-�� �������� ������� � ���� 
	fmul st, st(2); ��������� A �� C
	fmul st, st(3); ��������� (A*C) �� 4
	fxch st(1); ����� 1-�� � 2-�� ��������� r
	fmul st, st; ���������� "B" � �������
	fsub st, st(1); ��������� (4*A*C) �� B^2
	FLDZ; ���� ���� � ����
	fxch st(1); ����� 1-�� � 2-�� ��������� r
	fcomi st, st(1); ��������� �������������(B^2 - 4*A*C) � 0

	ret
FindRoots endp

exit: 
Invoke ExitProcess,ax 
End Start