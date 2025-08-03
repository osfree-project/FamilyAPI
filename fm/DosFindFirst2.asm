
		.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

		PUBLIC	SETFINDBUF
		PUBLIC	FindBuffer

	
_DATA 	segment byte public 'DATA'
		FindBuffer 	db 43 dup (0)
_DATA 	ends

_TEXT	segment byte public 'CODE' USE16

;--------------------------------------------------------------
;/*!
;   @brief      Заглушка для расширенного поиска
;   @remark     Не реализована в этой версии
;   @return     Всегда возвращает управление сразу
;*/

	@PROLOG DOSFINDFIRST2
RESERVED	DD  ?   ; [bp+6]
FileInfoLevel	DW  ?	; [bp+10]
SearchCount	DD  ?	; [bp+12]
cbSearchBuf     DW  ?   ; [bp+16]
pSearchBuf      DD  ?   ; [bp+18]
FileAttribute   DW  ?   ; [bp+22]
pulSearchHandle DD  ?   ; [bp+24]
pFileName       DD  ?   ; [bp+28]
		@START	DOSFINDFIRST2
		; Проверка handle
    les bx, [bp].ARGS.pulSearchHandle
    xor ax, ax
    xchg ax, es:[bx]          ; Проверка handle
    cmp ax, 1
    jne error_handle
	
		; Выбор буфера	(@todo проверка на ffffh)
    lds si, [bp].ARGS.pulSearchHandle ; Указатель на тип буфера
    cmp word ptr [si], 1
    jne alloc_buffer
    mov dx, seg FindBuffer    ; Буфер по умолчанию
    mov bx, offset FindBuffer
    jmp setdta

alloc_buffer:
    mov bx, 3                 ; 3 параграфа = 48 байт
    mov ah, 48h               ; Функция выделения памяти
    int 21h
    jnc store_segment
    mov ax, 071h              ; Ошибка выделения памяти
    jmp exit

store_segment:
    mov [si], ax              ; Сохраняем сегмент
    xor bx, bx                ; Смещение 0

setdta:
    mov word ptr [bp-4], bx   ; Локальная: смещение DTA
    mov word ptr [bp-2], dx   ; Локальная: сегмент DTA
    lds dx, dword ptr [bp-4]  ; Установка DTA
    mov ah, 1Ah
    int 21h

    ; Вызов FindFirst
    lds dx, [bp].ARGS.pFileName   ; Маска поиска
    mov cx, [bp].ARGS.FileAttribute; Атрибуты файла
    mov ah, 4Eh
    int 21h
    jnc copy_results
    mov ax, 04Fh                  ; Ошибка поиска
    jmp exit

copy_results:
    lds si, dword ptr [bp-4]      ; Результаты поиска
    les di, [bp].ARGS.pSearchBuf  ; Буфер назначения
    mov cx, [bp].ARGS.cbSearchBuf ; Размер буфера
    call SETFINDBUF

    ; Успешное завершение
    les bx, [bp].ARGS.pulSearchHandle
    mov word ptr es:[bx], 1       ; Возвращаем handle=1 (@todo А разве не хэндл???)
    xor ax, ax
    jmp exit

error_handle:
    mov ax, ERROR_INVALID_PARAMETER

exit:
    @EPILOG DOSFINDFIRST2


SETFINDBUF proc
		mov	AX,[SI+16h]
		mov	ES:[DI+0Ah],AX
		mov	AX,[SI+18h]
		mov	ES:[DI+08h],AX
		mov	AX,[SI+1Ah]
		mov	ES:[DI+0Ch],AX
		mov	AX,[SI+1Ch]
		mov	ES:[DI+0Eh],AX
		mov	AL,[SI+15h]
		xor	AH,AH
		mov	ES:[DI+14h],AX
		lea	SI,[SI+1Eh]
		lea	BX,[DI+16h]
		mov	CX,13
		lea	DI,[BX+1]
nextchar:
		lodsb
		stosb
		or	AL,AL
		loopne	nextchar
		lea	AX,[DI-1]
		sub	AX,BX
		dec	AX
		mov	ES:[BX],AL
		ret
SETFINDBUF endp
	
        
_TEXT	ends

	end
