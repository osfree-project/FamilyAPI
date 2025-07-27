
		.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

	EXTERN	SETFINDBUF: PROC
	EXTERN	FindBuffer: NEAR

_TEXT	segment byte public 'CODE' USE16


;--------------------------------------------------------------
;/*!
;   @brief      Поиск следующего файла по заданному handle
;   @details    Продолжает поиск файлов, используя ранее созданный handle
;
;   @param[in]  ulSearchHandle  Handle поиска
;   @param[out] pSearchBuf      Указатель на буфер для результатов
;   @param[in]  cbSearchBuf     Размер буфера результатов
;
;   @return     AX = 0 при успехе, код ошибки при сбое
;   @retval     NO_ERROR                 Успешное выполнение
;   @retval     ERROR_INVALID_PARAMETER  Неверный handle
;   @retval     ERROR_FILE_NOT_FOUND     Файлы больше не найдены
;
;   @remark     Требует предварительного вызова DosFindFirst
;*/
@PROLOG DOSFINDNEXT
	SearchCount		DD	?	; [BP+6]
    cbSearchBuf     DW  ?   ; [BP+10]
    pSearchBuf      DD  ?   ; [BP+12]
    ulSearchHandle  DD  ?   ; [BP+16]
    @START DOSFINDNEXT
    
    ; Проверка handle
    les bx, [bp].ARGS.ulSearchHandle
    cmp word ptr es:[bx], 1
    jne error_next

    ; Установка DTA
    mov ax, word ptr [bp].ARGS.ulSearchHandle+2 ; Тип буфера
    test ax, ax
    jnz custom_dta
    mov ax, seg FindBuffer        ; Буфер по умолчанию
    mov dx, offset FindBuffer
    jmp set_dta_next

custom_dta:
    mov dx, ax
    xor ax, ax

set_dta_next:
    mov ds, ax
    mov ah, 1Ah
    int 21h

    ; Вызов FindNext
    mov ah, 4Fh
    int 21h
    jnc copy_next
    mov ax, 04Fh                  ; Ошибка поиска
    jmp exit_next

copy_next:
    mov si, dx
    les di, [bp].ARGS.pSearchBuf   ; Буфер назначения
    mov cx, [bp].ARGS.cbSearchBuf  ; Размер буфера
    call SETFINDBUF

    ; Успешное завершение
    xor ax, ax
    jmp exit_next

error_next:
    mov ax, ERROR_INVALID_PARAMETER

exit_next:
    @EPILOG DOSFINDNEXT
	
_TEXT	ends

	end
