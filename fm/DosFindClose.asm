
		.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

_TEXT	segment byte public 'CODE' USE16

;--------------------------------------------------------------
;/*!
;   @brief      Закрытие handle поиска файлов
;   @details    Освобождает ресурсы, связанные с поисковым handle
;
;   @param[in]  ulSearchHandle  Handle поиска для закрытия
;
;   @return     AX = 0 при успехе, код ошибки при сбое
;   @retval     NO_ERROR                 Успешное выполнение
;   @retval     ERROR_INVALID_HANDLE     Неверный handle
;
;   @remark     Для пользовательских буферов освобождает память
;   @remark     Системный буфер (FindBuffer) не освобождается
;*/
	@PROLOG DOSFINDCLOSE
    ulSearchHandle  DD  ?   ; [bp+6]
    @START DOSFINDCLOSE
    
    ; Проверка типа буфера
    mov ax, word ptr [bp].ARGS.ulSearchHandle+2 ; Сегмент буфера
    test ax, ax
    jz exit_close                ; Пропуск для системного буфера

    ; Освобождение памяти
    mov es, ax
    mov ah, 49h
    int 21h
    jnc exit_close
    mov ax, 6                     ; ERROR_INVALID_HANDLE

exit_close:
    xor ax, ax                    ; Всегда возвращаем успех
    @EPILOG DOSFINDCLOSE

	
_TEXT	ends

	end
