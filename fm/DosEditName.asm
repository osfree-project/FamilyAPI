;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosEditName
;
;   (c) osFree Project 2025, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: https://osfree.org/doku/en:docs:fapi:doseditname
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

        @PROLOG DOSEDITNAME
TargetBufLen    DW  ?       ;!< Size of target buffer in bytes
TargetBuf   DD  ?       ;!< Pointer to target buffer
EditString     DD  ?       ;!< Pointer to edit template
SourceString   DD  ?       ;!< Pointer to source filename
EditLevel       DW  ?       ;!< Operation flags 
        @START DOSEDITNAME

		CMP		DOS1020API, 0FFFFH
		JNE		NOVDM

		; EditLevel
		MOV		AX, [BP].ARGS.EditLevel
		PUSH	AX
		
		; SourceString
		LES		DI, [BP].ARGS.SourceString
		PUSH	ES
		PUSH	DI
		
		; EditString
		LES		DI, [BP].ARGS.EditString
		PUSH	ES
		PUSH	DI
		
		; TargetBuf
		LES		DI, [BP].ARGS.TargetBuf
		PUSH	ES
		PUSH	DI
		
		; TargetBufLen
		MOV		AX, [BP].ARGS.TargetBufLen
		PUSH	AX

		; ES:DI - Pointer to args frame
		PUSH	SS
		POP		ES
		MOV		DI, SP

		; Call VDM DosEditName
		MOV		AX, 06400h
		MOV		CX, 0636Ch
		MOV		BX, 000BFH
		INT		21H
		
		JMP	EXIT

NOVDM:
        ; Проверка уровня редактирования
        MOV AX, [BP].ARGS.EditLevel
        CMP AX, 1
        JNE INVALID_PARAM

        ; Проверка указателей
        LDS BX, [BP].ARGS.SourceString
        MOV CX, DS
        OR  CX, BX
        JZ  INVALID_PARAM

        LDS BX, [BP].ARGS.EditString
        MOV CX, DS
        OR  CX, BX
        JZ  INVALID_PARAM

        LDS BX, [BP].ARGS.TargetBuf
        MOV CX, DS
        OR  CX, BX
        JZ  INVALID_PARAM

        ; Проверка длины буфера
        MOV CX, [BP].ARGS.TargetBufLen
        CMP CX, 1
        JB  INVALID_PARAM

        ; Проверка строки редактирования
        LES DI, [BP].ARGS.EditString
CHECK_PATH_DELIMS:
        MOV AL, ES:[DI]
        INC DI
        TEST AL, AL
        JZ  PATH_CHECK_OK
        CMP AL, '\'
        JE  INVALID_NAME
        CMP AL, '/'
        JE  INVALID_NAME
        CMP AL, ':'
        JE  INVALID_NAME
        JMP CHECK_PATH_DELIMS

INVALID_NAME:
        MOV AX, ERROR_INVALID_NAME
        JMP EXIT

INVALID_PARAM:
        MOV AX, ERROR_INVALID_PARAMETER
        JMP EXIT

PATH_CHECK_OK:
        ; Извлечение имени файла из пути
        LDS SI, [BP].ARGS.SourceString
        XOR BX, BX      ; Позиция последнего разделителя

FIND_LAST_COMP:
        LODSB
        TEST AL, AL
        JZ  FIND_COMP_DONE
        CMP AL, '\'
        JE  FOUND_DELIM
        CMP AL, '/'
        JE  FOUND_DELIM
        CMP AL, ':'
        JE  FOUND_DELIM
        JMP FIND_LAST_COMP

FOUND_DELIM:
        MOV BX, SI      ; Сохранить позицию после разделителя
        JMP FIND_LAST_COMP

FIND_COMP_DONE:
        TEST BX, BX
        JZ  USE_START
        MOV SI, BX      ; Начало имени файла
        JMP HAVE_FILENAME

BUFFER_FULL:
        POP DS
        MOV AX, ERROR_INVALID_PARAMETER
        JMP EXIT

USE_START:
        LDS SI, [BP].ARGS.SourceString

HAVE_FILENAME:
        ; Инициализация обработки
        LES DI, [BP].ARGS.TargetBuf
        MOV DX, DI      ; Сохранить начало буфера
        MOV CX, [BP].ARGS.TargetBufLen
        DEC CX          ; Для завершающего нуля
        JCXZ BUFFER_FULL

        PUSH DS
        LDS BX, [BP].ARGS.EditString

        ; Основной цикл обработки
PROCESS_EDIT:
        MOV AL, [BX]    ; Символ из EditString
        TEST AL, AL
        JZ  EDIT_DONE
        INC BX

        CMP AL, '.'
        JE  HANDLE_DOT
        CMP AL, '?'
        JE  HANDLE_QMARK
        CMP AL, '*'
        JE  HANDLE_STAR
        JMP HANDLE_CHAR

HANDLE_DOT:
        ; Обработка точки (синхронизация)
        MOV AL, '.'
        CALL WRITE_CHAR
        JC  BUFFER_FULL
        CMP BYTE PTR [SI], '.'
        JNE PROCESS_EDIT
        INC SI          ; Пропуск точки в источнике
        JMP PROCESS_EDIT

HANDLE_QMARK:
        ; Обработка '?' (копирование одного символа)
        CMP BYTE PTR [SI], 0
        JE  PROCESS_EDIT
        CMP BYTE PTR [SI], '.'
        JE  PROCESS_EDIT
        MOV AL, [SI]
        INC SI
        CALL WRITE_CHAR
        JC  BUFFER_FULL
        JMP PROCESS_EDIT

HANDLE_STAR:
        ; Обработка звездочки (копирование до следующего символа)
        MOV AL, [BX]    ; Следующий символ в EditString
        TEST AL, AL
        JZ  COPY_REMAIN ; Если конец строки

        ; Копирование до символа AL
STAR_LOOP:
        CMP BYTE PTR [SI], 0
        JE  PROCESS_EDIT
        MOV AH, [SI]
        CMP AH, AL
        JE  STAR_MATCH
        PUSH AX
        MOV AL, AH
        CALL WRITE_CHAR
        POP AX
        JC  BUFFER_FULL
        INC SI
        JMP STAR_LOOP

STAR_MATCH:
        ; Продолжаем обработку со следующего символа
        JMP PROCESS_EDIT

COPY_REMAIN:
        ; Копирование оставшейся части
        CMP BYTE PTR [SI], 0
        JE  PROCESS_EDIT
        MOV AL, [SI]
        CALL WRITE_CHAR
        JC  BUFFER_FULL
        INC SI
        JMP COPY_REMAIN

HANDLE_CHAR:
        ; Обычный символ
        CALL WRITE_CHAR
        JC  BUFFER_FULL
        JMP PROCESS_EDIT

EDIT_DONE:
        POP DS
        ; Завершение строки
        XOR AL, AL
        CALL WRITE_CHAR
        JC  BUFFER_FULL

        ; Преобразование в верхний регистр
        MOV SI, DX      ; Начало буфера
TO_UPPER_LOOP:
        MOV AL, ES:[SI]
        INC SI
        TEST AL, AL
        JZ  TO_UPPER_DONE
        CMP AL, 'a'
        JB  TO_UPPER_LOOP
        CMP AL, 'z'
        JA  TO_UPPER_LOOP
        SUB AL, 32
        MOV ES:[SI-1], AL
        JMP TO_UPPER_LOOP

TO_UPPER_DONE:
        XOR AX, AX      ; NO_ERROR
        JMP EXIT


;--- Процедура записи символа с проверкой буфера ---
WRITE_CHAR PROC NEAR
        JCXZ WRITE_FAIL ; Буфер переполнен?
        STOSB           ; ES:[DI] <- AL
        DEC CX          ; Уменьшить счетчик
        CLC
        RET
WRITE_FAIL:
        STC
        RET
WRITE_CHAR ENDP

EXIT:
        @EPILOG DOSEDITNAME

_TEXT       ENDS

        END
		