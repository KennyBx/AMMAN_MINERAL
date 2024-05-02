// Product Valuation
@AbapCatalog.sqlViewName: '/SIMPLE/IPRDVAL'
@VDM.viewType: #COMPOSITE
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Valuation active core entity'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.dataClass: #MIXED
@ObjectModel.usageType.sizeCategory: #XL
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true

define view /SIMPLE/I_ProductValuation
  as select from Mbv_Mbew as Valuation
    inner join   t001k on Valuation.bwkey = t001k.bwkey
    inner join   marv  on marv.bukrs = t001k.bukrs
    inner join   t001  on t001.bukrs = t001k.bukrs


  association [1..1] to I_Product               as _Product                      on  $projection.Product = _Product.Product

  association [0..1] to I_Prodvaluationclass    as _ValuationClass               on  $projection.ValuationClass = _ValuationClass.ValuationClass
  association [0..*] to I_Prodvaluationclasstxt as _ValuationClassText           on  $projection.ValuationClass = _ValuationClassText.ValuationClass
  association [0..1] to I_Prodvaluationclass    as _ValnClassSalesOrderStock     on  $projection.ValuationClassSalesOrderStock = _ValnClassSalesOrderStock.ValuationClass
  association [0..*] to I_Prodvaluationclasstxt as _ValnClassSalesOrderStockText on  $projection.ValuationClassSalesOrderStock = _ValnClassSalesOrderStockText.ValuationClass
  association [0..1] to I_Prodvaluationclass    as _ValnClassProjectStock        on  $projection.ProjectStockValuationClass = _ValnClassProjectStock.ValuationClass
  association [0..*] to I_Prodvaluationclasstxt as _ValnClassProjectStockText    on  $projection.ProjectStockValuationClass = _ValnClassProjectStockText.ValuationClass


  association [0..1] to E_Productvaluation      as _ProdValuationExt             on  $projection.Product       = _ProdValuationExt.Product
                                                                                 and $projection.ValuationArea = _ProdValuationExt.ValuationArea
                                                                                 and $projection.ValuationType = _ProdValuationExt.ValuationType

{
  key Valuation.matnr                                                       as Product,
  key Valuation.bwkey                                                       as ValuationArea,
  key Valuation.bwtar                                                       as ValuationType,
      @ObjectModel : {
                foreignKey.association: '_ValuationClass',
                text.association: '_ValuationClassText'
             }
      Valuation.bklas                                                       as ValuationClass,
      Valuation.mlast                                                       as PriceDeterminationControl,
            Valuation.mlmaa                                        as TaxClassificationCategory,   //PSTAT Move : Moved to I_ProductValuationAcct
      //      Valuation.vjbkl                                        as ValuationClassInPrevYear, //pstat changes
      //      Valuation.vmbkl                                        as ValuationClassInPrevPeriod, //pstat changes
      marv.lfmon                                                            as FiscalMonthCurrentPeriod, // pstat
      marv.lfgja                                                            as FiscalYearCurrentPeriod,  //pstat
      Valuation.stprs                                                       as StandardPrice,
      Valuation.peinh                                                       as PriceUnitQty,
      cast(Valuation.vprsv as inventoryvaluationprocedure preserving type ) as InventoryValuationProcedure,
      Valuation.zkprs                                                       as FutureEvaluatedAmountValue, //PSTAT Move : Moved to I_ProductValuationAcct
      Valuation.zkdat                                                       as FuturePriceValidityStartDate, //PSTAT Move : Moved to I_ProductValuationAcct

      //NEW FIELDS
      Valuation.stprv                                                       as PrevInvtryPriceInCoCodeCrcy,

      //      cast (Valuation.lbkum as totalvalstockquantity )       as TotalValStockQuantity,
      Valuation.verpr                                                       as MovingAveragePrice,
      //      cast (Valuation.vmkum as totalvalstockprevperiod )     as TotalValStockPrevPeriod,    //pstat
      //      cast (Valuation.vmsal as totalvalstockprevperiodvalue) as TotalValStockPrevPeriodValue, //pstat
      //      cast (Valuation.vjkum as totalvalstockprevyear )       as TotalValStockPrevYear,  //PSTAT Delete
      //      cast (Valuation.vjsal as totalvalstockprevyearvalue )  as TotalValStockPrevYearValue,  //PSTAT Delete
      Valuation.bwtty                                                       as ValuationCategory,
      //      cast (Valuation.salk3 as totalvalstockvalue   )        as TotalValStockValue,   //pstat
      cast (Valuation.mtuse    as productusagetype preserving type )        as ProductUsageType,
      cast (Valuation.mtorg    as productorigintype preserving type )       as ProductOriginType,
      Valuation.ownpr                                                       as IsProducedInhouse,
      //      Valuation.oklas                                        as ValnClsForSpclStkAtVndr,    //pstat
      Valuation.kaln1                                                       as ProdCostEstNumber,
      //      Valuation.kalnr                                        as CostEstimateNumber,
      Valuation.lvorm                                                       as IsMarkedForDeletion,
      //Retail field

      Valuation.bwspa                                                       as ValuationMargin,
      cast( 'X' as sdraft_is_active preserving type )                       as IsActiveEntity, // to enbale extensibility in Draft 2.0

      //ML fields
      t001k.bukrs                                                           as CompanyCode,
      @ObjectModel : {
         foreignKey.association: '_ValnClassSalesOrderStock',
         text.association: '_ValnClassSalesOrderStockText'
      }

      Valuation.eklas                                                       as ValuationClassSalesOrderStock,
      @ObjectModel : {
                      foreignKey.association: '_ValnClassProjectStock',
                      text.association: '_ValnClassProjectStockText'
                   }
      Valuation.qklas                                                       as ProjectStockValuationClass,
      Valuation.zplp1                                                       as PlannedPrice1InCoCodeCrcy,
      Valuation.zplp2                                                       as PlannedPrice2InCoCodeCrcy,
      Valuation.zplp3                                                       as PlannedPrice3InCoCodeCrcy,
      Valuation.zpld1                                                       as FuturePlndPrice1ValdtyDate,
      Valuation.zpld2                                                       as FuturePlndPrice2ValdtyDate,
      Valuation.zpld3                                                       as FuturePlndPrice3ValdtyDate,
      //      Valuation.bwprs                                        as TaxPricel1InCoCodeCrcy,  //PSTAT Move : Moved to I_ProductValuationAcct
      //      Valuation.bwps1                                        as TaxPrice2InCoCodeCrcy,  //PSTAT Move : Moved to I_ProductValuationAcct
      //      Valuation.vjbws                                        as TaxPrice3InCoCodeCrcy,  //PSTAT Move : Moved to I_ProductValuationAcct
      //      Valuation.bwprh                                        as CommercialPrice1InCoCodeCrcy,  //PSTAT Move : Moved to I_ProductValuationAcct
      //      Valuation.bwph1                                        as CommercialPrice2InCoCodeCrcy,  //PSTAT Move : Moved to I_ProductValuationAcct
      //      Valuation.vjbwh                                        as CommercialPrice3InCoCodeCrcy,  //PSTAT Move : Moved to I_ProductValuationAcct
      //      Valuation.abwkz                                        as DevaluationYearCount,    //PSTAT Move : Moved to I_ProductValuationAcct
      Valuation.bwpei                                                       as TaxBasedPricesPriceUnitQty,
      //      Valuation.mypol                                        as LIFOValuationPoolNumber,    //PSTAT Move : Moved to I_ProductValuationAcct
      //      Valuation.xlifo                                        as IsLIFOAndFIFORelevant,    //PSTAT Move : Moved to I_ProductValuationAcct
      Valuation.laepr                                                       as PriceLastChangeDate,

      Valuation.zplpr                                                       as PlannedPrice,
      //      Valuation.bwva1                                                        as FutrCostEstValuationVariant, //PSTAT Delete : Read only
      //      Valuation.fbwst                                                        as FutrPlanProjSlsOrdValnStrategy, //PSTAT Delete : Read only
      //      Valuation.fplpx                                                        as FixedPortionOfPlannedPrice,  //PSTAT Delete : Read only
      //      Valuation.vers1                                                        as FutureCostEstCostingVersion, //PSTAT Delete : Read only
      t001.waers                                                            as Currency,
            Valuation.pprdz                                                        as FutureCostEstimateFiscalPeriod,
            Valuation.pdatz                                                        as FutureCostEstFiscalYear,
      
      //Missing Fields 200812
        Valuation.xbewm                                                     as ValuatedUoM,          
        Valuation.ekalr                                                     as WithQtyStructure,     
        Valuation.hkmat                                                     as MaterialOrigin,       
        Valuation.hrkft                                                     as OriginGroup,          
        Valuation.kosgr                                                     as OverheadGroup,        
        Valuation.pprdl                                                     as CurrentPeriod,        
        Valuation.pdatl                                                     as CurrentFiscalYear,    
        Valuation.pprdv                                                     as PreviousPeriod,       
        Valuation.pdatv                                                     as PreviousFiscalYear,   
        Valuation.vplpr                                                     as PreviousPlannedPrice, 

      
      _Product,
      _ValuationClass,
      _ValuationClassText,
      _ValnClassSalesOrderStock,
      _ValnClassSalesOrderStockText,
      _ValnClassProjectStock,
      _ValnClassProjectStockText





}
