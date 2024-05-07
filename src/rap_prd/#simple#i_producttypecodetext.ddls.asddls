@AbapCatalog.sqlViewName: '/SIMPLE/IPTYPCT'
@Analytics: { dataCategory: #DIMENSION }
@VDM.viewType: #BASIC
@ObjectModel.dataCategory: #TEXT
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'ProductTypeCode'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Product type code text'

define view /SIMPLE/I_ProductTypeCodeText
  as select from cmd_prdtype_t
{

  key prod_type_code as ProductTypeCode,
      @Semantics.language: true
  key spras          as Language,
      @Semantics.text: true
      description    as Name
}
