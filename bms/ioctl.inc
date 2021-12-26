IOMR_NB		EQU	?	; MouGetNumButtons Get # of mouse buttons
IOMR_MC		EQU	?	; MouGetNumMickeys Get# of mickeys/centimeter
IOMR_GS		EQU	?	; MouGetDevStatus Get device status flags
IOMW_DS		EQU	?	; MouSetDevStatus Set device status flags
IOMR_QS		EQU	?	; MouGetNumQueEI Get event queue status
IOMR_RD		EQU	?	; MouReadEventQue Read event queue contents
IOMR_GF		EQU	?	; MouGetScaleFact Get current scaling factors
IOMW_SS		EQU	?	; MouSetScaleFact Set new scaling factors
IOMR_GM		EQU	?	; MouGetEventMask Get current event mask
IOMW_EM		EQU	?	; MouSetEventMask Set new event mask
NIA MouOpen Open mouse support
NIA MouClose Close mouse support
NIA Mou Register Install a mouse subsystem
NIA MouDeRegister Deinstall a mouse subsystem
NIA MoulnitReal Initialize DOS mode driver
IOMW_SP		EQU	?	; MouSetPtrShape Assign new pointer shape
IOMW_GP		EQU	?	; MouGetPtrShape Assign new pointer shape
IOMW_DP		EQU	?	; MouDrawPtr Unmark collision area
IOMW_RP		EQU	?	; MouRemovePtr Mark collision area