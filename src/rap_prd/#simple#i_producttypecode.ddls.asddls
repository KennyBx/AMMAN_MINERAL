@AbapCatalog.sqlViewName: '/SIMPLE/IPTYPC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'ProductTypeCode'


@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@EndUserText.label: 'Product Type Code Basic'
@ClientHandling.algorithm: #SESSION_VARIABLE 
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductTypeCode
  as select from cmd_prdtype

  association [0..*] to /SIMPLE/I_ProductTypeCodeText as _Text on $projection.ProductTypeCode = _Text.ProductTypeCode


{
      @ObjectModel.text.association: '_Text'

  key prod_type_code as ProductTypeCode,
      _Text

}   
 