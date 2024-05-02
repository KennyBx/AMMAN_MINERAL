@AbapCatalog.sqlViewName: '/SIMPLE/IECNOMR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ECMObjectMgmtRecord'
define view /SIMPLE/I_ECMObjectMgmtRecord

  as select from aeoi
  association [0..1] to /SIMPLE/I_ECMObjectType as _ChangeMasterObjectType on $projection.ChangeNumberObjectType = _ChangeMasterObjectType.ChangeNumberObjectType
  //  association [0..1] to I_ChangeMaster           as _ChangeMaster           on  $projection.ChangeNumber = _ChangeMaster.ChangeNumber
  //  association [0..1] to I_ChangeMasterAltDate    as _ChangeMasterAltDate    on  $projection.ChangeNumber                  = _ChangeMasterAltDate.ChangeNumber
  //                                                                            and $projection.ChgNmbrAlternativeDateCounter = _ChangeMasterAltDate.ChgNmbrAlternativeDateCounter
{
      @ObjectModel.text.element: 'ObjMgmtRecdDescription'
  key aennr                                         as ChangeNumber,
  key aetyp                                         as ChangeNumberObjectType,
  key objkt                                         as ObjMgmtRecdObjectInternalID,
      usobj                                         as ObjMgmtRecdObject,
      aedtz                                         as ChgNmbrAlternativeDateCounter,

      oitxt                                         as ObjMgmtRecdDescription,
      aeoi_guid                                     as ObjMgmtRecdItemUUID,

      aedat                                         as ObjMgmtRecdLastChangedAt,
      aenam                                         as ObjMgmtRecdLastChangedBy,
      andat                                         as ObjMgmtRecdCreationDate,
      annam                                         as ObjMgmtRecdCreatedBy,
      objdt                                         as ObjMgmtRecdObjLastChangedAt,
      objnm                                         as ObjMgmtRecdObjLastChangedBy,

      cclck                                         as ObjMgmtRecdObjIsLockedForChg,
      aeost                                         as ObjMgmtRecdObjIsBaselined,
      ccoaa                                         as ObjMgmtRecdChangeType,
      ccvms                                         as ObjMgmtRecdObjIsPlanned,
      
      //      revlv     as ObjMgmtRecdObjRevisionLevel,
      cast(revlv as cc_revlv_nex preserving type)   as ObjMgmtRecdObjRevisionLevel,
      
      /* ECM custom field for creation */
      //Material and Material BOM
      case aetyp when '41' then cast(usobj as /plmb/matnr )
                 when '02' then cast(substring(usobj, 1, 40) as /plmb/matnr)
                 else cast('' as /plmb/matnr ) end as Material,
                 
      case aetyp when '02' then cast(substring(usobj, 41, 4) as werks_d) 
                           else cast('' as werks_d) end as Plant,
                           
      case aetyp when '02' then cast(substring(usobj, 45, 1) as stlan)
                           else cast('' as stlan) end as BillOfMaterialVariantUsage,                
     //Document
      case aetyp when '31' then cast(substring(usobj, 1, 3) as dokar)
                           else cast('' as dokar) end as DocumentType,                
      case aetyp when '31' then cast(substring(usobj, 4, 25) as doknr)
                           else cast('' as doknr) end as DocumentInfoRecord,    
      case aetyp when '31' then cast(substring(usobj, 29, 3) as doktl_d)
                           else cast('' as doktl_d) end as DocumentPart,    
      case aetyp when '31' then cast(substring(usobj, 32, 2) as dokvr)
                           else cast('' as dokvr) end as DocumentVersion,    
                           
      //ltxsp, // Long text original language
      //ccsto, // Partial key for status in engineering change management
      //cont1, // Digital signature status for ECR integration

      _ChangeMasterObjectType
      //      _ChangeMasterAltDate,
      //      _ChangeMaster
}
