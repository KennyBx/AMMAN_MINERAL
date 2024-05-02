@AbapCatalog.sqlViewName: '/SIMPLE/ICFNCLCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Classification Class Characteristic'
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER
define view /SIMPLE/I_ClfnClassCharc
  as select from /SIMPLE/I_ClfnClassHierCharc as ClassCharacteristic
//  association [0..*] to /SIMPLE/I_ClfnCharacteristic as _Characteristic on $projection.CharcInternalID = _Characteristic.CharcInternalID
//  association [0..1] to /SIMPLE/I_ClfnClass          as _Class          on $projection.ClassInternalID = _Class.ClassInternalID
{
  key ClassInternalID,
  key AncestorClassInternalID,
  key CharcInternalID,
      CharcPositionNumber,
      Characteristic,
      ClassType,
      ChangeNumber,
      CharcIsPrintRelevant,
      CharcIsSearchRelevant,
      CharcIsDisplayRelevant,
      CharcIsProposalRelevant,
      CharcIsPrptnOrProdUnitRelevant,
      CharcIsInherited,
      ValidityStartDate,
      ValidityEndDate

//      _Class,
//      _Characteristic
}
