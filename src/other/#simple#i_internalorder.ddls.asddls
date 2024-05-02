@ObjectModel.representativeKey: 'InternalOrder'
@EndUserText.label: 'Internal Order'
@AbapCatalog.sqlViewName: '/SIMPLE/IFIIORD'
@VDM.viewType: #BASIC
//@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.createEnabled:true
@ObjectModel.updateEnabled:true
@ObjectModel.deleteEnabled:true
@AbapCatalog.buffering: {type: #NONE, numberOfKeyFields: 0, status: #NOT_ALLOWED}
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions:true



//--[ GENERATED:012:GFBfhxvv7jY4pHq{eVxSQ0
@AccessControl.privilegedAssociations: ['_ControllingAreaText','_InternalOrderTypeText']
// ]--GENERATED

define view /SIMPLE/I_InternalOrder
  as select from aufk

  //--[ GENERATED:012:GFBfhxvv7jY4pHq{eVxSQ0
  association [0..1] to I_ControllingArea           as _ControllingAreaText    on  $projection.ControllingArea = _ControllingAreaText.ControllingArea
  association [0..*] to I_InternalOrderTypeText     as _InternalOrderTypeText  on  $projection.OrderType = _InternalOrderTypeText.OrderType
  // ]--GENERATED
  association [0..1] to I_ControllingArea           as _ControllingArea        on  $projection.ControllingArea = _ControllingArea.ControllingArea

  association [0..1] to I_CompanyCode               as _CompanyCode            on  $projection.CompanyCode = _CompanyCode.CompanyCode

  association [0..*] to I_ProfitCenter              as _ProfitCenter           on  $projection.ControllingArea = _ProfitCenter.ControllingArea
                                                                               and $projection.ProfitCenter    = _ProfitCenter.ProfitCenter

  association [0..1] to I_FunctionalArea            as _FunctionalArea         on  $projection.FunctionalArea = _FunctionalArea.FunctionalArea

  association [0..1] to I_ControllingObjectClass    as _ControllingObjectClass on  $projection.ControllingObjectClass = _ControllingObjectClass.ControllingObjectClass

  association [0..1] to /SIMPLE/I_InternalOrderType as _InternalOrderType      on  $projection.OrderType = _InternalOrderType.OrderType

  association [0..*] to /SIMPLE/I_CostCenter        as _CostCenter             on  $projection.ControllingArea       = _CostCenter.ControllingArea
                                                                               and $projection.ResponsibleCostCenter = _CostCenter.CostCenter

  association [0..1] to I_User                      as _User                   on  $projection.InternalOrderResponsibleUser = _User.UserID

  association [0..*] to I_InternalOrderSystemStatus as _SystemStatus           on  $projection.ControllingObject = _SystemStatus.ControllingObject

  association [0..1] to I_WBSElementBasicData       as _WBSElementBasicData    on  $projection.WBSElementInternalID = _WBSElementBasicData.WBSElementInternalID
  association [1..1] to E_LogisticsOrder            as _Extension              on  $projection.InternalOrder = _Extension.OrderID

{
      @ObjectModel.text.element: ['InternalOrderDescription']
  key aufnr                                         as InternalOrder,

      @Semantics.text: true
      cast(ktext as fis_internalorder_text)         as InternalOrderDescription,
      autyp                                         as OrderCategory,
      cast(gsber as fis_rbusa)                      as BusinessArea,
      //      //--[ GENERATED:012:GFBfhxvv7jY4pHq{eVxSQ0
      //      @Consumption.valueHelpDefinition: [
      //        { entity:  { name:    'I_ControllingArea',
      //                     element: 'ControllingArea' }
      //        }]
      //      @ObjectModel.text.association: '_ControllingAreaText'
      //      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ControllingArea'
      cast(kokrs as fis_kokrs)                      as ControllingArea,
      werks                                         as Plant,
      @Semantics.currencyCode
      waers                                         as Currency,
      astkz                                         as IsStatisticalOrder,
      cast(refnr as fis_aufrefnr)                   as ReferenceOrder,
      kdauf                                         as SalesOrder,
      kdpos                                         as SalesOrderItem,
      //      pspel                                 as WBSElement,
      cast ( pspel as ps_s4_pspnr preserving type ) as WBSElementInternalID,
      _WBSElementBasicData.WBSElement               as WBSElement,
      akstl                                         as RequestingCostCenter,
      abukr                                         as RequestingCompanyCode,
      anfaufnr                                      as RequestingOrder,
      stort                                         as Location,
      sowrk                                         as LocationPlant,
      aufex                                         as ExternalOrderNumber,
      cycle                                         as ActualPostedCostCenter,
      plint                                         as PlanningIsIntegrated,
      kstar                                         as SettlementCostElement,
      cast(kostl as fis_kostl)                      as CostCenter,
      cast(saknr as fis_racct)                      as GLAccount,
      ivpro                                         as InvestmentMeasureProfile,
      sizecl                                        as InvestmentObjectScale,
      izwek                                         as InvestmentReason,
      umwkz                                         as EnvironmentalInvestmentReason,
      user0                                         as Applicant,
      user1                                         as ApplicantTelephoneNumber,
      user2                                         as ResponsiblePerson,
      user3                                         as ResponsiblePersonTelephone,
      @Semantics.amount.currencyCode: 'Currency'
      user4                                         as EstimatedTotalOrderCost,
      user5                                         as ApplicationDate,
      user7                                         as WorkStart,
      user8                                         as WorkEnd,
      user9                                         as WorkApprovalIdentifier,
      abkrs                                         as ProcessingGroup,
      cast(user6 as ad_dprtmnt)                     as Department,
      loekz                                         as IsDeleted,
      erdat                                         as CreationDate,
      ernam                                         as CreatedByUser,
      erfzeit                                       as CreationTime,
      aenam                                         as LastChangedByUser,
      aedat                                         as LastChangedDate,
      aezeit                                        as LastChangeTime,
      ltext                                         as LongTextExist,
      cckey                                         as CostCollector,
      //@ObjectModel.foreignKey.association: '_SystemStatus'
      objnr                                         as ControllingObject,
      //      //--[ GENERATED:012:GFBfhxvv7jY4pHq{eVxSQ0
      //      @Consumption.valueHelpDefinition: [
      //        { entity:  { name:    'I_CompanyCodeStdVH',
      //                     element: 'CompanyCode' }
      //        }]
      //      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_CompanyCode' //Inserted by VDM CDS Suite Plugin
      cast(bukrs as fis_bukrs)                      as CompanyCode,
      //      //--[ GENERATED:012:GFBfhxvv7jY4pHq{eVxSQ0
      //      @Consumption.valueHelpDefinition: [
      //        { entity:  { name:    'I_ProfitCenterStdVH',
      //                     element: 'ProfitCenter' },
      //          additionalBinding: [{ localElement: 'ControllingArea',
      //                                element: 'ControllingArea' }]
      //        }]
      //      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ProfitCenter' //Inserted by VDM CDS Suite Plugin
      cast(prctr as fis_prctr)                      as ProfitCenter,
      @ObjectModel.foreignKey.association: '_FunctionalArea' //Inserted by VDM CDS Suite Plugin
      cast(func_area as fm_farea)                   as FunctionalArea,
      @ObjectModel.foreignKey.association: '_ControllingObjectClass' //Inserted by VDM CDS Suite Plugin
      cast(scope as fis_scope_cv_conv)              as ControllingObjectClass,
      //      //--[ GENERATED:012:GFBfhxvv7jY4pHq{eVxSQ0
      //      @Consumption.valueHelpDefinition: [
      //        { entity:  { name:    'I_InternalOrderTypeStdVH',
      //                     element: 'OrderType' }
      //        }]
      //      @ObjectModel.text.association: '_InternalOrderTypeText'
      //      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_InternalOrderType'
      auart                                         as OrderType,
      //      //--[ GENERATED:012:GFBfhxvv7jY4pHq{eVxSQ0
      //      @Consumption.valueHelpDefinition: [
      //        { entity:  { name:    'I_CostCenterStdVH',
      //                     element: 'CostCenter' },
      //          additionalBinding: [{ localElement: 'ControllingArea',
      //                                element: 'ControllingArea' }]
      //        }]
      //      // ]--GENERATED
      cast( _InternalOrderType.RevenuePostingAllowed as boole_d )
                                                    as RevenuePostingAllowed,
      --_InternalOrderType.RevenuePostingAllowed      as RevenuePostingAllowed,
      @ObjectModel.foreignKey.association: '_CostCenter'
      kostv                                         as ResponsibleCostCenter,
      //@ObjectModel.foreignKey.association: '_Username'
      veraa_user                                    as InternalOrderResponsibleUser,
      zschm                                         as InterestProfile,
      zschl                                         as OverheadKey,
      kalsm                                         as CostingSheet,
      abgsl                                         as ResultsAnalysisKey,

      phas0                                         as IsCreated,
      phas1                                         as IsReleased,
      phas2                                         as IsCompleted,
      phas3                                         as IsClosed,

      idat1                                         as ReleaseDate,
      idat2                                         as CompletionDate,
      idat3                                         as CloseDate,

      _ControllingArea,
      _CompanyCode,
      _ProfitCenter,
      _FunctionalArea,
      _ControllingObjectClass,
      _InternalOrderType,
      _CostCenter,
      _User,
      _SystemStatus,
      //--[ GENERATED:012:GFBfhxvv7jY4pHq{eVxSQ0
      @Consumption.hidden: true
      _ControllingAreaText,
      @Consumption.hidden: true
      _InternalOrderTypeText
      // ]--GENERATED


}
where
     autyp = '01'
  or autyp = '02'
  or autyp = '03';
