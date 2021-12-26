SAS			struc
SAS_signature		DD	?	; 'SAS '
SAS_tables_data		DW	?	; offset to tables section
SAS_flat_sel		DW	?	; FLAT selector for kernel data
SAS_config_data		DW	?	; offset to configuration section
SAS_dd_data		DW	?	; offset to device driver section
SAS_vm_data		DW	?	; offset to Virtual Memory section
SAS_task_data		DW	?	; offset to Tasking section
SAS_RAS_data		DW	?	; offset to RAS section
SAS_file_data		DW	?	; offset to File System section
SAS_info_data		DW	?	; offset to infoseg section
SAS			ends

SASRAS			struc
SAS_RAS_STDA_p		DW	?	; selector for System Trace Data Area (STDA)
SAS_RAS_STDA_r		DD	?	; segment for System Trace Data Area (STDA)
SAS_RAS_event_mask	DD	?	; offset for trace event mask
SASRAS			ends

end