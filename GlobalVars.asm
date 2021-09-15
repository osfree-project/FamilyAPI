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
PUBLIC	DOS_VERSION
PUBLIC	DOS2API
PUBLIC	DOS3API
PUBLIC	DOS33API
PUBLIC	DOS7API
PUBLIC	DOS10API
PUBLIC	DOS1020API
PUBLIC	LFNAPI
PUBLIC	DPMI
PUBLIC	main_buffer
PUBLIC	wMDSta
PUBLIC	wLdrDS
PUBLIC	MAXPATHLEN

_DATA		SEGMENT BYTE PUBLIC 'DATA' USE16

API_INITED		DW	0       ; IS FAMILY API INITIALIZED?

DOS_VERSION		DW	0	; DOS VERSIION

DOS2API			DW	0	; DOS 2.X API SUPPORTED
DOS3API			DW	0	; DOS 3.0 API SUPPORTED
DOS33API		DW	0	; DOS 3.3 API SUPPORTED
DOS7API			DW	0	; DOS 7.0 API SUPPORTED
DOS10API		DW	0	; DOS 10.00 API SUPPORTED
DOS1020API		DW	0	; DOS 10.20 API SUPPORTED
LFNAPI			DW	0	; LFN API SUPPORTED
DPMI			DW	0	; DPMI SUPPORTED
DPMI1			DW	0	; DPMI 1.0 SUPPORTED
TRUEDPMI		DW	0	; TRUE DPMI SUPPORTED

DISPLAY_PAGE		DW	0	; DISPLAY PAGE
VIOFUNCTIONMASK1	DD	0	; VIO FUNCTIONS REDIRECTION MASK 1
VIOFUNCTIONMASK2	DD	0 	; VIO FUNCTIONS REDIRECTION MASK 2

LONG_BUFFER_SIZE    EQU 261
GETCWD_LONG_SIZE    EQU LONG_BUFFER_SIZE
MAIN_BUFFER_SIZE    EQU GETCWD_LONG_SIZE
main_buffer db MAIN_BUFFER_SIZE dup (?)

MAXPATHLEN	DW	80		; SFN, For LFN - 260

;!!!! @todo Rework loader to use LINFOSEG!!!
wMDSta	 dw 0			;segment of 1. element of 16bit MD table
wLdrDS	dw ?			; DATA segment of application (or kernel???)

GINFOSEG struc
  gis_time                dd  ? ;time in seconds
  gis_msecs               dd  ? ;milliseconds
  gis_hour                db  ? ;hours
  gis_minutes             db  ? ;minutes
  gis_seconds             db  ? ;seconds
  gis_hundredths          db  ? ;hundredths
  gis_timezone            dw  ? ;minutes from UTC
  gis_cusecTimerInterval  dw  ? ;timer interval (units = 0.0001 seconds)
  gis_day                 db  ? ;day
  gis_month               db  ? ;month
  gis_year                dw  ? ;year
  gis_weekday             db  ? ;day of week
  gis_uchMajorVersion     db  ? ;major version number
  gis_uchMinorVersion     db  ? ;minor version number
  gis_chRevisionLetter    db  ? ;revision letter
  gis_sgCurrent           db  ? ;current foreground session
  gis_sgMax               db  ? ;maximum number of sessions
  gis_cHugeShift          db  ? ;shift count for huge elements
  gis_fProtectModeOnly    db  ? ;protect mode only indicator
  gis_pidForeground       dw  ? ;pid of last process in foreground session
  gis_fDynamicSched       db  ? ;dynamic variation flag
  gis_csecMaxWait         db  ? ;max wait in seconds
  gis_cmsecMinSlice       dw  ? ;minimum timeslice (milliseconds)
  gis_cmsecMaxSlice       dw  ? ;maximum timeslice (milliseconds)
  gis_bootdrive           dw  ? ;drive from which the system was booted
  gis_amecRAS             db  32 dup (?) ;system trace major code flag bits
  gis_csgWindowableVioMax db  ? ;maximum number of VIO windowable sessions
  gis_csgPMMax            db  ? ;maximum number of pres. services sessions
GINFOSEG ends

LINFOSEG struc
  lis_pidCurrent      dw  ? ;current process id
  lis_pidParent       dw  ? ;process id of parent
  lis_prtyCurrent     dw  ? ;priority of current thread
  lis_tidCurrent      dw  ? ;thread ID of current thread
  lis_sgCurrent       dw  ? ;session
  lis_rfProcStatus    db  ? ;process status
  lis_dummy1          db  ? ;
  lis_fForeground     dw  ? ;current process has keyboard focus
  lis_typeProcess     db  ? ;process type
  lis_dummy2          db  ? ;
  lis_selEnvironment  dw  ? ;environment selector
  lis_offCmdLine      dw  ? ;command line offset
  lis_cbDataSegment   dw  ? ;length of data segment
  lis_cbStack         dw  ? ;stack size
  lis_cbHeap          dw  ? ;heap size
  lis_hmod            dw  ? ;module handle of the application
  lis_selDS           dw  ? ;data segment handle of the application
LINFOSEG ends

_DATA		ENDS

		END
