use16					; генерированить 16-битный код(для DOS)
org 100h				; начало программы с адресса 100h

	mov ax, [n]			; копирование значения n в ax
	dec ax				; дикримент(-1) в ax
	sub ax, [r]			; вычитание ax и r

	mov bx, [m]			; копирование значения m в bx
	inc bx				; инкремент(+1) в bx
	sub bx, ax			; вычитание bx и ax

	mov [k], bx			; сохранение результата в k

	mov ax, 4C00h			; ah - завершение программы DOS, al - код завершения
	int 21h				; вызов функции DOS


n dw -1053
r dw -5821
m dw 858
k dw ?
; Напишите программу для вычисления формулы k=m+1-(n-1-r). Все числа 16-битные целые со знаком
