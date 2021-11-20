ALL: ..\lib\ioctl.lib

ASMS=IodBlockRemovable.asm IodFormatTrack.asm IodGetMap.asm IodGetParam.asm IodLock.asm IodReadTrack.asm IodRedetermine.asm &
IodSetMap.asm IodSetParam.asm IodUnLock.asm IodVerifyTrack.asm IodWriteTrack.asm IokCharIn.asm IokClose.asm IokGetCp.asm &
IokGetCpInfo.asm IokGetHotKey.asm IokGetHWID.asm IokGetInputMode.asm IokGetInterimFlag.asm IokGetKeyboardType.asm IokGetShiftState.asm &
IokNotify.asm IokOpen.asm IokPeek.asm IokSetCp.asm IokSetCPID.asm IokSetCustXt.asm IokSetHotKey.asm IokSetInputMode.asm &
IokSetInterimFlag.asm IokSetKCB.asm IokSetNotify.asm IokSetRate.asm IokSetShiftState.asm IokSetStatus.asm IokTranslate.asm &
IomAllowPtrDraw.asm IomGetButtonCount.asm IomGetEventMask.asm IomGetMickeyCount.asm IomGetMouStatus.asm IomGetPtrPos.asm &
IomGetPtrShape.asm IomGetQueStatus.asm IomGetScaleFactors.asm IomMarkCollisionArea.asm IomReadEventQue.asm IomScreenSwitch.asm &
IomSetEventMask.asm IomSetMouStatus.asm IomSetProtDrawAddress.asm IomSetPtrPos.asm IomSetPtrShape.asm IomSetRealDrawAddress.asm &
IomSetScaleFactors.asm IomUnmarkCollisionArea.asm IomUpdateDisplayMode.asm IomVer.asm IopGetFrame.asm IopGetRetry.asm &
IopGetStatus.asm IopInit.asm IopSetFrame.asm IopSetRetry.asm IosSetBaud.asm IosSetLine.asm

OBJS=dosdevioctl.obj

..\lib\ioctl.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

dosdevioctl.obj: dosdevioctl.asm Cat01.asm Cat02.asm Cat03.asm Cat04.asm Cat05.asm Cat06.asm Cat07.asm Cat08.asm Cat09.asm Cat10.asm Cat11.asm $(ASMS)
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm
