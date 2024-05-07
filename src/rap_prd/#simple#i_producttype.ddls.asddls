@AbapCatalog.sqlViewName: '/SIMPLE/IPTYPE'
@Analytics: { dataCategory: #DIMENSION }
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'ProductType'
@EndUserText.label: 'Product type view'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_Producttype
  as select from t134
  association [0..*] to /SIMPLE/I_ProductTypeText as _Text            on $projection.ProductType = _Text.ProductType
  association [0..1] to /SIMPLE/I_ProductTypeCode as _ProductTypeCode on $projection.ProductTypeCode = _ProductTypeCode.ProductTypeCode

{
      @ObjectModel.text.association: '_Text'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key cast(t134.mtart as producttype preserving type ) as ProductType,
      @ObjectModel.foreignKey.association:'_ProductTypeCode'
      prod_type_code                                   as ProductTypeCode,
      t134.begru                                       as AuthorizationGroup,
      t134.pstat                                       as MaintenanceStatus,
      t134.mtref                                       as ReferenceProductType,
      t134.kkref                                       as AcctCategoryRef,
      _Text,
      _ProductTypeCode

}
