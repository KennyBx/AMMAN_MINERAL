@EndUserText.label: 'Supplier Account Group' //same as DDL description
@Analytics.dataCategory: #DIMENSION //or #CUBE or #FACT
@VDM.viewType: #BASIC
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.representativeKey: 'SupplierAccountGroup'
@AbapCatalog.sqlViewName: '/SIMPLE/ISUPAGR' //must start with "I"
@Search.searchable: true
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #MASTER
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_SupAccountGroup //must start with "I_"; same as DDL source name in upper-camelcase notation
  as select from t077k
  association [0..*] to /SIMPLE/I_SupAccountGroupT as _SupplierAccountGroupText on $projection.SupplierAccountGroup = _SupplierAccountGroupText.SupplierAccountGroup
{
      @ObjectModel.text.association: '_SupplierAccountGroupText'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key t077k.ktokk as SupplierAccountGroup,
      _SupplierAccountGroupText //expose the association for use by consumers

}   
  
 