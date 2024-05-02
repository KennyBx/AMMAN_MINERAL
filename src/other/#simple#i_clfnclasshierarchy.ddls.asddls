@AbapCatalog.preserveKey: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: '/SIMPLE/CLCLHIER'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Classification Class Hierarchy'
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API

@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER
define view /SIMPLE/I_ClfnClassHierarchy
  as select from ngc_clhier_idx as Hierarchy
{
  key Hierarchy.ancestor    as AncestorClassInternalID,
  key Hierarchy.node        as DescendantClassInternalID,
  key Hierarchy.datuv       as ValidityStartDate,
      Hierarchy.klart       as ClassType,
      Hierarchy.aennr       as ChangeNumber,  
      Hierarchy.datub       as ValidityEndDate
}
