@AbapCatalog.sqlViewName: '/SIMPLE/IPPIT'
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Core view Product Plant Intrntionl Trade'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE

define view /SIMPLE/I_ProductPlantIntlTrd
  as select from nsdm_e_marc as InternationalTrade  

  association [0..1] to E_Productplant as _ProdPlantIntlTrdExt on  $projection.Product = _ProdPlantIntlTrdExt.Product
                                                               and $projection.Plant   = _ProdPlantIntlTrdExt.Plant

//  association [0..1] to /SIMPLE/I_Country      as _CountryOfOrigin     on  $projection.CountryOfOrigin = _CountryOfOrigin.Country
//  association [0..*] to /SIMPLE/I_CountryText  as _CountryName         on  $projection.CountryOfOrigin = _CountryName.Country
//  association [0..1] to /SIMPLE/I_Region       as _RegionOfOrigin      on  $projection.RegionOfOrigin  = _RegionOfOrigin.Region
//                                                               and $projection.CountryOfOrigin = _RegionOfOrigin.Country
//  association [0..*] to /SIMPLE/I_RegionText   as _RegionName          on  $projection.RegionOfOrigin  = _RegionName.Region
                                                               and $projection.CountryOfOrigin = _RegionName.country
//  association [1..1] to /SIMPLE/I_Product      as _Product             on  $projection.Product = _Product.Product
{
  key InternationalTrade.matnr                                                 as Product,
  key InternationalTrade.werks                                                 as Plant,
      @ObjectModel: {
          foreignKey.association: '_CountryOfOrigin',
          text.association: '_CountryName'
      }
      cast (InternationalTrade.herkl as countryoforigin preserving type )      as CountryOfOrigin,
      @ObjectModel: {
          foreignKey.association: '_RegionOfOrigin',
          text.association: '_RegionName'
      }
      cast (InternationalTrade.herkr as regionoforigin preserving type )       as RegionOfOrigin,
      InternationalTrade.steuc                                                 as ConsumptionTaxCtrlCode,

      // New fields from MDG model, as part of unified API development
      InternationalTrade.mtver                                                 as ExportAndImportProductGroup,
      InternationalTrade.casnr                                                 as ProductCASNumber,
      InternationalTrade.expme                                                 as CommoditiyCodeNumberUnit,
      InternationalTrade.gpnum                                                 as ProdIntlTradeClassification

//      _CountryOfOrigin,
//      _CountryName,
//      _RegionOfOrigin,
//      _RegionName,
//      _Product

}
