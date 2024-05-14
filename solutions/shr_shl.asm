use16								; генерированить 16-битный код(для DOS)
org 100h							; начало программы с адресса 100h
;-----------------------------------
	jmp start						; безусловный переход на метку start
;-----------------------------------
array dw 11,22,33,44,55,66,77,88
res dw ?
length db 4
;-----------------------------------
start:								; метка start для начала программы
	movzx cx, [length]				; копирование length в cx с расширением 0
	mov bx, 1 						; копирование 1 в bx для сдвигов
	and si, 00h						; обнуление si для смещений


shifts: 							; метка для сдвигов
	mov dx, cx 						; сохранение cx в dx для счетчика
	mov cx, bx 						; копирование bx в cx для сдвига
	mov ax, word[array+si] 			; копирование в ax слова array со смещением si
	shl ax, cl 						; логический свдиг влево ax на cl бит
	mov word[res+si], ax 			; сохранение результата сдвига в res со смещением si
	add si, 2 						; сложение si и 2 для смещения в массиве
	inc cx 							; увеличиваем cx на 1 для сдвига по условию задачи
	mov ax, word[array+si] 			; копирование в ax слова array со смещением si
	shr ax, cl 						; логический сдвиг вправо ax на cl бит
	mov word[res+si], ax 			; сохранение результата сдвига в res со смещением si
	add si, 2 						; сложение si и 2 для смещения в массиве
	inc cx 							; увеличиваем cx на 1 для сдвига по условию задачи
	mov bx, cx 						; сохранение значения для сдвигов в bx
	mov cx, dx 						; возвращение счетчика в cx для итераций
	loop shifts 					; итерация для сдвигов по метке shifts


exit:
	mov ax, 4C00h					; ah - завершение программы DOS, al - код завершения
	int 21h							; вызов функции DOS
;-----------------------------------
; Объявите массив из 8 слов без знака. Сдвиньте первый элемент на 1 бит влево, второй элемент — на 2 бита вправо (логическим сдвигом), третий элемент — на 3 бита влево и т.д. до конца массива. Используйте циклы. Проверьте работу программы в отладчике. 
