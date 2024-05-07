@AbapCatalog.sqlViewName: '/SIMPLE/IPRTQCFT'
@AbapCatalog.compiler.compareFilter:true 
@AbapCatalog.preserveKey:true 
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'ProdnRsceToolQtyCalcFormula'
@ObjectModel.dataCategory: #TEXT
@VDM.viewType: #BASIC
@EndUserText.label: 'Production Resource Tool Quantity Calculation Formula Desc.'
@ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #S, dataClass: #CUSTOMIZING }
@ClientHandling.algorithm: #SESSION_VARIABLE
//@AbapCatalog.buffering: { status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001 }

define view /SIMPLE/I_PrdnRscTQtyCalcFormT
  as select from tc25t as txt
  association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language
{
      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language'
  key txt.spras      as Language,
      @ObjectModel.text.element: 'ProdnRsceToolQtyCalcFmlaName'
  key txt.ident      as ProdnRsceToolQtyCalcFormula,
      @Semantics.text: true
      txt.txt        as ProdnRsceToolQtyCalcFmlaName,

      // Associations
      _Language
};       
 