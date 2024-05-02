@EndUserText.label: 'Currency'
@ObjectModel.representativeKey: 'Currency'
@Analytics: {dataCategory: #DIMENSION, dataExtraction.enabled: true}
@VDM.viewType: #BASIC 
@AbapCatalog.sqlViewName: '/SIMPLE/ICURR'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true

define view /SIMPLE/I_Currency 
  as select from tcurc
  left outer join tcurx on tcurc.waers = tcurx.currkey
  
//  association [0..*] to /SIMPLE/I_CurrencyText as _Text 
//    on $projection.Currency = _Text.Currency
{
    
    @Semantics.currencyCode: true
    @ObjectModel.text.association: '_Text' 
    key tcurc.waers as Currency,
//    _Text,
    
    cast(COALESCE(tcurx.currdec, 2) as currdec_cds) as Decimals,
           
    @Search.defaultSearchElement: true
    @Search.ranking: #HIGH
    @Search.fuzzinessThreshold: 0.8
    cast(tcurc.isocd  as isocd_cds) as CurrencyISOCode,
    cast(tcurc.altwr  as altwr_cds) as AlternativeCurrencyKey,
    tcurc.xprimary    as IsPrimaryCurrencyForISOCrcy
       
};             
  
  
  
  
  
  
  
  
  
  
  
 