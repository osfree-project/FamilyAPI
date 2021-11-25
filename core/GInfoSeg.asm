.8086

PUBLIC gis_cHugeShift
PUBLIC gis_uchMajorVersion
PUBLIC gis_uchMinorVersion
PUBLIC gis_chRevisionLetter

_GINFOSEG SEGMENT BYTE PUBLIC 'DATA' USE16
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
  gis_sgMax               db  1 ;maximum number of sessions
  gis_cHugeShift          db  12 ;shift count for huge elements
  gis_fProtectModeOnly    db  0 ;protect mode only indicator
  gis_pidForeground       dw  ? ;pid of last process in foreground session
  gis_fDynamicSched       db  ? ;dynamic variation flag
  gis_csecMaxWait         db  ? ;max wait in seconds
  gis_cmsecMinSlice       dw  ? ;minimum timeslice (milliseconds)
  gis_cmsecMaxSlice       dw  ? ;maximum timeslice (milliseconds)
  gis_bootdrive           dw  ? ;drive from which the system was booted
  gis_amecRAS             db  32 dup (?) ;system trace major code flag bits
  gis_csgWindowableVioMax db  0 ;maximum number of VIO windowable sessions
  gis_csgPMMax            db  0 ;maximum number of pres. services sessions
_GINFOSEG ends

	end
