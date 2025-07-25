;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief Global vars of DOS wrappers
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

PUBLIC	API_INITED
PUBLIC	DOS2API
PUBLIC	DOS3API
PUBLIC	DOS33API
PUBLIC	DOS4API
PUBLIC	DOS5API
PUBLIC	DOS7API
PUBLIC	DOS710API
PUBLIC	DOS10API
PUBLIC	DOS1020API
PUBLIC	DOS2030API
PUBLIC	LFNAPI
PUBLIC	DPMI
PUBLIC	main_buffer
PUBLIC	wMDSta
PUBLIC	wLdrDS
PUBLIC	MAXPATHLEN
PUBLIC	SHARE
PUBLIC	modesw

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

API_INITED		DW	0       ; IS FAMILY API INITIALIZED?

DOS2API			DW	0	; DOS 2.X API SUPPORTED
DOS3API			DW	0	; DOS 3.X API SUPPORTED
DOS33API		DW	0	; DOS 3.3 API SUPPORTED
DOS4API			DW	0	; DOS 4.X API SUPPORTED
DOS5API			DW	0	; DOS 5.X API SUPPORTED
DOS7API			DW	0	; DOS 7.X API SUPPORTED
DOS710API		DW	0	; DOS 7.1 API SUPPORTED
DOS10API		DW	0	; OS/2 1.x VDM API SUPPORTED
DOS1020API		DW	0	; OS/2 1.2 VDM API SUPPORTED
DOS2030API		DW	0	; OS/2 Warp 4 MVDM API SUPPORTED
LFNAPI			DW	0	; LFN API SUPPORTED
DPMI			DW	0	; DPMI SUPPORTED
DPMI1			DW	0	; DPMI 1.0 SUPPORTED
TRUEDPMI		DW	0	; TRUE DPMI SUPPORTED
SHARE			DW	0	; SHARE.EXE LOADED

modesw			DD	0	; far pointer to DPMI host's
					; mode switch entry point

DISPLAY_PAGE		DW	0	; DISPLAY PAGE

LONG_BUFFER_SIZE    EQU 260
GETCWD_LONG_SIZE    EQU LONG_BUFFER_SIZE
MAIN_BUFFER_SIZE    EQU GETCWD_LONG_SIZE
main_buffer db MAIN_BUFFER_SIZE dup (?)

MAXPATHLEN	DW	80		; SFN, For LFN - 260

;!!!! @todo Rework loader to use LINFOSEG!!!
wMDSta	 dw 0			;segment of 1. element of 16bit MD table
wLdrDS	dw ?			; DATA segment of application (or kernel???)

_DATA		ENDS




		END
