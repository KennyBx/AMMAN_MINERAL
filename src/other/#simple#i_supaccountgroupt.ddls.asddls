@AbapCatalog.sqlViewName: '/SIMPLE/ISUPAGRT'
@EndUserText.label: 'Supplier Account Group Text'
@ObjectModel.dataCategory: #TEXT
@AccessControl.authorizationCheck:#CHECK
@ObjectModel.representativeKey: 'SupplierAccountGroup'
@VDM.viewType: #BASIC
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #MASTER
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_SupAccountGroupT
  as select from t077y
  association [1..1] to /SIMPLE/I_SupAccountGroup as _SupplierAccountGroup on _SupplierAccountGroup.SupplierAccountGroup = $projection.SupplierAccountGroup
  association [0..1] to /SIMPLE/I_Language        as _Language             on $projection.Language = _Language.Language
{
      @Semantics.language: true
  key t077y.spras as Language,

  key t077y.ktokk as SupplierAccountGroup,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      t077y.txt30 as AccountGroupName,

      //associations
      _SupplierAccountGroup,
      _Language


}   
  
 