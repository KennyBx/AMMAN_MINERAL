CLASS /simple/cl_convertion_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .

    CLASS-METHODS convert_raw_to_char for table function /SIMPLE/TF_DocInfRcdObjectLink.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /SIMPLE/CL_CONVERTION_AMDP IMPLEMENTATION.


  method convert_raw_to_char
          by database function for hdb
          language sqlscript
          options read-only
          using STKO DRAD .
*    RETURN select ppa_request.client as client,
*                  ppa_request.ppa_req_id as ppa_req_id,
*               cast(ppa_request.ppa_req_id as char(32)) as set_uuid,
*               cast(ppa_request.data_guid  as char(32)) as event_uuid
*           from gho_ppa_request as ppa_request;

    RETURN select D.mandt as CLIENT,
                  D.DOKOB as LinkedSAPObject,
                  D.OBJKY as LinkedSAPObjectKey,
                  D.OBZAE as DocObjectLinkCounter,
                  M.guidx as GUID
            from DRAD as D left join STKO as M
            on D.mandt = M.mandt
            and D.OBJKY = M.guidx;

  endmethod.
ENDCLASS.
