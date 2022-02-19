.8086

PUBLIC  lis_selEnvironment  
PUBLIC  lis_offCmdLine      
PUBLIC  lis_pidCurrent
PUBLIC  lis_pidParent
PUBLIC  lis_tidCurrent


_LINFOSEG SEGMENT PARA PUBLIC 'LDATA' USE16
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
_LINFOSEG ends

	end
