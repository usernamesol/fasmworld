include "PROC16.INC" 					; включение файла
;-----------------------------------
use16 									; генерировать 16-битный код для DOS
org 100h 								; начало программы с адреса 100h


start: 									; метка начала программы
	stdcall fib, 10 					; вызов процедуры fib с передачей 2


exit: 									; метка завершения программы
	mov ax, 4C00h 						; завершение программы
	int 21h 							; вызов функции DOS


;-----------------------------------
; Ассемблерный код для процедуры чисел фибоначчи
;-----------------------------------
proc fib stdcall uses cx, my_var		; процедура с сохранением cx и параметром my_var
local local_var dd ? 					; локальная неинициализированная переменная local_var
	mov cx, word[my_var] 				; cx = кол-во чисел фибоначчи
	jcxz .xor_ax 						; переход на метку xor_ax если cx = 0
	dec cx 								; дикремент cx(cx-1)
	jz @f 								; переход на следующую анон. метку если 'z' = 1
	stdcall fib, cx 					; вызов процедуры с передачей cx
	mov word[local_var], ax 			; копирование ax в слово local_var
	mov word[local_var+2], dx 			; копирование dx в слово+2 local_var
	dec cx 								; дикремент cx(cx-1)
	stdcall fib, cx 					; вызов процедуры с передачей cx
	add ax, word[local_var] 			; сложение слова local_var и ax
	adc dx, word[local_var+2] 			; сложение слова+2 local_var и ax с флагом 'c'
	jmp .end_proc 						; переход на метку end_proc
@@: 									; метка установки ax = 1
	mov ax, 1 							; ax = 1
	jmp @f 								; переход на следующую анон. метку
.xor_ax: 								; локальная метка обнуления ax
	xor ax, ax 							; ax = 0
@@: 									; метка конвертации для слова в двойное слово
	cwd 								; конвертация ax=младшая часть, dx=старшая часть
.end_proc: 								; локальная метка end_proc для конца процедуры
	ret									; выход из процедуры
endp 									; конец процедуры
;-----------------------------------
; В этот раз упражнение на дизассемблирование 🙂 Проанализируйте процедуру - (https://fasmworld.ru/content/course/029/shot06.png) и напишите для неё ассемблерный код с использованием макросов PROC16. Что делает эта процедура? Подумайте, какие недостатки у неё есть и как их можно исправить.
