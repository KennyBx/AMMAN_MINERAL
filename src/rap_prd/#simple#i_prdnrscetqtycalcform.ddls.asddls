@AbapCatalog.sqlViewName: '/SIMPLE/IPDRTQCF'
@AbapCatalog.compiler.compareFilter:true 
@AbapCatalog.preserveKey:true 
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataCategory: #DIMENSION
@ObjectModel.representativeKey: 'ProdnRsceToolQtyCalcFormula'
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Tool Quantity Calculation Formula'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #S, dataClass: #CUSTOMIZING }
@ClientHandling.algorithm: #SESSION_VARIABLE
//@AbapCatalog.buffering: { status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001 }

define view /SIMPLE/I_PrdnRsceTQtyCalcForm
  as select from tc25
  association [0..*] to /SIMPLE/I_PrdnRscTQtyCalcFormT as _Text on $projection.ProdnRsceToolQtyCalcFormula = _Text.ProdnRsceToolQtyCalcFormula
{
      @ObjectModel.text.association: '_Text'
  key ident as ProdnRsceToolQtyCalcFormula,

      // get name
      _Text
};    
