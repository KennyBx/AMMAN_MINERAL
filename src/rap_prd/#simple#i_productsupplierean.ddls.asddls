@AbapCatalog.sqlViewName: '/SIMPLE/IPSEAN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product supplier EAN'
define view /SIMPLE/I_ProductSupplierEAN
  as select from mlea
{
  key mlea.matnr as Product, 
  key mlea.lifnr as Supplier,
  key mlea.lfnum as SequenceNumber,
  key mlea.meinh as AlternativeUnit,
      mlea.ean11 as GlobalTradeItemNumber,
      mlea.lfean as IsSupplierMainGTINIndicator,
      mlea.lartn as SupplierProduct
}
