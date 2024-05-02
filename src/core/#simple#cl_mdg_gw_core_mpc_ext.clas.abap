CLASS /simple/cl_mdg_gw_core_mpc_ext DEFINITION
  PUBLIC
  INHERITING FROM /simple/cl_mdg_gw_core_mpc
  CREATE PUBLIC .

PUBLIC SECTION.

  TYPES:
     BEGIN OF ty_classification .
       TYPES:
         objectkey TYPE string,
         objecttable TYPE string,
         class TYPE string,
         classtype TYPE string,
         action TYPE string,
         tocharacteristic             TYPE STANDARD TABLE OF /simple/cl_mdg_gw_core_mpc=>ts_characteristic WITH DEFAULT KEY,
     END OF ty_classification,

     tt_select_option TYPE STANDARD TABLE OF /iwbep/s_cod_select_option,

     BEGIN OF ty_searchhelp.
       INCLUDE                    TYPE /simple/cl_mdg_gw_core_mpc=>ts_searchhelp.
       TYPES:
         to_searchhelpselectfield TYPE STANDARD TABLE OF /simple/cl_mdg_gw_core_mpc=>ts_searchhelpselectfield WITH DEFAULT KEY,
     END OF ty_searchhelp,

     BEGIN OF ty_searchhelprequest.
       INCLUDE               TYPE /simple/cl_mdg_gw_core_mpc=>ts_searchhelprequest.
       TYPES:
         to_searchhelp       TYPE STANDARD TABLE OF ty_searchhelp WITH DEFAULT KEY,
         to_searchhelpresult TYPE STANDARD TABLE OF /simple/cl_mdg_gw_core_mpc=>ts_searchhelpresult WITH DEFAULT KEY,
     END OF ty_searchhelprequest,

     BEGIN OF ty_multiplesearchhelp.
       INCLUDE                TYPE /simple/cl_mdg_gw_core_mpc=>ts_multiplesearchhelp.
       TYPES:
         to_searchhelprequest TYPE STANDARD TABLE OF ty_searchhelprequest WITH DEFAULT KEY,
     END OF ty_multiplesearchhelp,


     BEGIN OF ty_create_deep_type.
       TYPES:
         objectid TYPE string,
         action TYPE string,
         objecttype TYPE string,
         toclassification               TYPE STANDARD TABLE OF ty_classification WITH DEFAULT KEY,
         tobusinesspartnercreditprofile TYPE /simple/cl_mdg_gw_core_mpc=>ts_businesspartnercreditprofil,
         tobusinesspartnercreditsegment TYPE STANDARD TABLE OF /simple/cl_mdg_gw_core_mpc=>ts_businesspartnercreditsegmen WITH DEFAULT KEY,
         tobusinesspartnerrelationship TYPE STANDARD TABLE OF /simple/cl_mdg_gw_core_mpc=>ts_businesspartnerrelationship WITH DEFAULT KEY,
     END OF ty_create_deep_type .
ENDCLASS.



CLASS /SIMPLE/CL_MDG_GW_CORE_MPC_EXT IMPLEMENTATION.
ENDCLASS.
