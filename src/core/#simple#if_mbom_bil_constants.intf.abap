interface /SIMPLE/IF_MBOM_BIL_CONSTANTS
  public .


*  types:
*    BEGIN OF gty_t_bom_header,
*
*      t_create_tp          TYPE TABLE FOR CREATE        /SIMPLE/A_BillOfMaterial,
*      t_update_tp          TYPE TABLE FOR UPDATE        /SIMPLE/A_BillOfMaterial,
*      t_delete_tp          TYPE TABLE FOR DELETE        /SIMPLE/A_BillOfMaterial,
*
*
*      t_failed             TYPE TABLE FOR FAILED        /SIMPLE/I_BillOfMatAPITP,
*      t_mapped             TYPE TABLE FOR MAPPED        /SIMPLE/A_BillOfMaterial,
*      t_reported           TYPE TABLE FOR REPORTED      /SIMPLE/I_BillOfMatAPITP,
*
*      t_lock               TYPE TABLE FOR LOCK          /SIMPLE/A_BillOfMaterial,
*
*      t_read_in            TYPE TABLE FOR READ IMPORT   /SIMPLE/A_BillOfMaterial,
*      t_read_out           TYPE TABLE FOR READ RESULT   /SIMPLE/A_BillOfMaterial,
*
*      t_release_version_bom_in  TYPE TABLE FOR ACTION IMPORT /SIMPLE/A_BillOfMaterial~ReleaseVersionBOM,
*      t_release_version_bom_out TYPE TABLE FOR ACTION RESULT /SIMPLE/A_BillOfMaterial~ReleaseVersionBOM,
*      t_explode_bom_in  TYPE TABLE FOR ACTION IMPORT /SIMPLE/A_BillOfMaterial~ExplodeBOM,
*      t_explode_bom_out TYPE TABLE FOR ACTION RESULT /SIMPLE/A_BillOfMaterial~ExplodeBOM,
*
*      s_update             TYPE LINE OF gty_t_bom_header-t_update_tp,
*      s_key                TYPE gty_t_bom_header-s_update-%key,
*    END OF gty_t_bom_header .
*  types:
*    begin of gty_t_bom_item,
*
*      t_read_in               TYPE TABLE FOR READ IMPORT   /SIMPLE/I_BillOfMatItemAPITP,
*      t_read_by_header_link   TYPE TABLE FOR READ LINK     /SIMPLE/A_BillOfMaterial\_BillOfMaterialItem,
*      t_read_out              TYPE TABLE FOR READ RESULT   /SIMPLE/I_BillOfMatItemAPITP,
**
*      t_create_item_by_header   TYPE TABLE FOR CREATE   /SIMPLE/A_BillOfMaterial\_BillOfMaterialItem,
*      t_create_item             TYPE TABLE for create /SIMPLE/I_BillOfMatItemAPITP,
*
*      t_update_tp   TYPE TABLE FOR UPDATE   /SIMPLE/I_BillOfMatItemAPITP,
*      t_delete_tp   TYPE TABLE FOR DELETE   /SIMPLE/I_BillOfMatItemAPITP,
*      t_failed   TYPE TABLE FOR FAILED   /SIMPLE/I_BillOfMatItemAPITP,
*      t_mapped   TYPE TABLE FOR MAPPED   /SIMPLE/I_BillOfMatItemAPITP,
*      t_reported TYPE TABLE FOR REPORTED /SIMPLE/A_BillOfMaterialItem,
*    END OF gty_t_bom_item .

*  data GT_SUBITEM TYPE STANDARD TABLE OF /SIMPLE/A_BOMSUBITEM.
endinterface.
