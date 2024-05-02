@AbapCatalog.sqlViewName: '/SIMPLE/IBPTAXNO'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm : #SESSION_VARIABLE
@VDM.viewType: #BASIC
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Core view for Tax Number'
@AccessControl.personalData.blocking: #NOT_REQUIRED

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER

define view /SIMPLE/I_BPtaxnumber
  as select from dfkkbptaxnum as BusinessPartnerTaxNumber

  association [1..1] to /SIMPLE/I_BusinessPartner   as _BusinessPartner on $projection.BusinessPartner = _BusinessPartner.BusinessPartner
  //association [0..*] to C_BPTaxTypeTextTemp as _TaxCategoryText on $projection.BPTaxType = _TaxCategoryText.BPTaxType
{
  key BusinessPartnerTaxNumber.partner      as BusinessPartner,
  key BusinessPartnerTaxNumber.taxtype      as BPTaxType,
      BusinessPartnerTaxNumber.taxnum       as BPTaxNumber,
      BusinessPartnerTaxNumber.taxnumxl     as BPTaxLongNumber,
      _BusinessPartner.AuthorizationGroup,
    //  _TaxCategoryText,
      _BusinessPartner
      //concat(taxtype,taxnum) as FullTax
}
