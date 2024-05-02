// Product Sales Tax Classification
@AbapCatalog.sqlViewName: '/SIMPLE/IPSLTAX'
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Sales Tax active core entity'

@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MIXED
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true

define view /SIMPLE/I_ProductSalesTax
  as select from mlan as tax
    inner join   tstl as taxType on tax.aland = taxType.talnd

  association [1..1] to /SIMPLE/I_Product     as _Product     on $projection.Product = _Product.Product
//  association [1..1] to /SIMPLE/I_Country     as _Country     on $projection.Country = _Country.Country
//  association [0..*] to /SIMPLE/I_CountryText as _CountryName on $projection.Country = _CountryName.Country

{
      @ObjectModel: {
        foreignKey.association: '_Product'
      }
  key cast (tax.matnr       as productnumber preserving type ) as Product,

      @ObjectModel: {
        foreignKey.association: '_Country',
        text.association: '_CountryName'
      }
  key tax.aland                                                as Country,
  key taxType.tatyp                                            as TaxCategory,


  key case taxType.lfdnr
          when '1' then
              tax.taxm1
          when '2' then
              tax.taxm2
          when '3' then
              tax.taxm3
          when '4' then
              tax.taxm4
          when '5' then
              tax.taxm5
          when '6' then
              tax.taxm6
          when '7' then
              tax.taxm7
          when '8' then
              tax.taxm8
          when '9' then
              tax.taxm9
          else ''
      end                                                      as TaxClassification,

      _Product
//      _Country,
//      _CountryName

      //      tax.taxim                               as TaxIndicator
}
// no purchase tax relevant entries
//where
//  taxim = ''
