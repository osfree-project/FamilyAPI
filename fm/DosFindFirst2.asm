
		.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

_TEXT	segment byte public 'CODE' USE16

;--------------------------------------------------------------
;/*!
;   @brief      Заглушка для расширенного поиска
;   @remark     Не реализована в этой версии
;   @return     Всегда возвращает управление сразу
;*/

	@PROLOG DOSFINDFIRST2
    @START DOSFINDFIRST2
    @EPILOG DOSFINDFIRST2
	
        
_TEXT	ends

	end
