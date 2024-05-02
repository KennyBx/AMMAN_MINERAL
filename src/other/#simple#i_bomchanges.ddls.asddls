@AbapCatalog.sqlViewName: '/SIMPLE/IBOMCHG'
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #SESSION_VARIABLE
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bill Of Material Changes'
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #L, dataClass: #TRANSACTIONAL}
define view /SIMPLE/I_BomChanges
  as select distinct from P_Bomchanges as bomchanges
  
  association [0..1] to /SIMPLE/I_ChangeMasterStatuTxt as StatusText on $projection.ChangeNumberStatus = StatusText.ChangeNumberStatus
                                                                    and StatusText.Language = $session.system_language
  //association [0..*] to I_BOMChangeHistory as _BOMChangeHistory on  $projection.BillOfMaterial            = _BOMChangeHistory.BillOfMaterial
  //                                                              and $projection.BillOfMaterialCategory    = _BOMChangeHistory.BillOfMaterialCategory
  //                                                              and $projection.BillOfMaterialVariant     = _BOMChangeHistory.BillOfMaterialVariant
  //                                                              and $projection.EngineeringChangeDocument = _BOMChangeHistory.EngineeringChangeDocument
{
  key Material,
  key Plant,
  key BillOfMaterial,
  key BillOfMaterialCategory,
  key BillOfMaterialVariant,
  key BillOfMaterialVariantUsage,
  key BillOfMaterialVersion,
  key EngineeringChangeDocument,
      ChangeNumberStatus,
      StatusText.ChangeNumberStatusText,
      ChangeNumberCreationDate,
      ChangeNumberCreatedByUser,
      ChangeNumberValidFromDate as ValidityStartDate  
      //_BOMChangeHistory
} 
  
  
  
 