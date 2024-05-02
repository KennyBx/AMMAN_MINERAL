@AbapCatalog.preserveKey: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: '/SIMPLE/ICLSUP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Clfn Cl Superior Hierarchy'
@VDM.viewType: #COMPOSITE
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API

@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.dataClass: #MIXED
define view /SIMPLE/I_CLFNCLASSSUPERIOR
  as select from /SIMPLE/I_ClfnClass          as AncestorClass
    inner join   /SIMPLE/I_ClfnClassHierarchy as Hierarchy             on Hierarchy.DescendantClassInternalID = AncestorClass.ClassInternalID
    inner join   /SIMPLE/I_ClfnClass          as DirectDescendantClass on DirectDescendantClass.ClassInternalID = Hierarchy.AncestorClassInternalID
{
  key Hierarchy.DescendantClassInternalID   as ClassInternalID,
  key DirectDescendantClass.ClassInternalID as AncestorClassInternalID,
  key AncestorClass.ClassType               as ClassType,
      AncestorClass.Class                   as Class,
      DirectDescendantClass.Class           as AncestorClass,
      AncestorClass.ClassClassfctnAuthGrp
}
