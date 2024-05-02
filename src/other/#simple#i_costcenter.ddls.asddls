@AbapCatalog.sqlViewName: '/SIMPLE/IFICOSTC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@ObjectModel.createEnabled:true
@ObjectModel.updateEnabled:true
@ObjectModel.deleteEnabled:true
@Analytics:{
    dataCategory: #DIMENSION,
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture: {
        automatic: true
        }
    }
}

@ObjectModel.representativeKey: 'CostCenter'

@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@AccessControl.privilegedAssociations: [ '_UserRespContactCard', '_UserCrtedContactCard' ]

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@EndUserText.label: 'Cost Center'
@VDM.viewType: #BASIC

@ObjectModel.usageType: {
  dataClass: #ORGANIZATIONAL,
  serviceQuality: #A,
  sizeCategory: #L
}

@ClientHandling.algorithm: #SESSION_VARIABLE
@Search.searchable: true
@Consumption.filter.businessDate.at: true
define view /SIMPLE/I_CostCenter
  as select distinct from csks

  association [1]    to I_ControllingArea          as _ControllingArea             on  $projection.ControllingArea = _ControllingArea.ControllingArea
  association [0..*] to /SIMPLE/I_CostCenterText           as _Text                        on  $projection.ControllingArea = _Text.ControllingArea
                                                                                   and $projection.CostCenter      = _Text.CostCenter
                                                                                   and $projection.ValidityEndDate = _Text.ValidityEndDate
  association [0..*] to I_CostCenterHierarchyNode  as _CostCenterHierarchyNode     on  $projection.ControllingArea = _CostCenterHierarchyNode.ControllingArea
                                                                                   and $projection.CostCenter      = _CostCenterHierarchyNode.CostCenter
  association [0..1] to I_Currency                 as _Currency                    on  $projection.CostCenterCurrency = _Currency.Currency
  association [0..1] to I_CompanyCode              as _CompanyCode                 on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [0..1] to I_BusinessArea             as _BusinessArea                on  $projection.BusinessArea = _BusinessArea.BusinessArea
  association [0..*] to I_ProfitCenter             as _ProfitCenter                on  $projection.ProfitCenter    = _ProfitCenter.ProfitCenter
                                                                                   and $projection.ControllingArea = _ProfitCenter.ControllingArea

  association [0..1] to I_FunctionalArea           as _FunctionalArea              on  $projection.FunctionalArea = _FunctionalArea.FunctionalArea
  association [0..1] to I_CostCenterCategory       as _CostCenterCategory          on  $projection.CostCenterCategory = _CostCenterCategory.CostCenterCategory
  association [0..1] to I_Country                  as _Country                     on  $projection.Country = _Country.Country
  association [0..1] to I_Region                   as _Region                      on  $projection.Region  = _Region.Region
                                                                                   and $projection.Country = _Region.Country
  association [0..1] to I_CostingSheetProcedure    as _CostingSheetProcedure       on  _CostingSheetProcedure.ConditionUsage        = 'A'
                                                                                   and _CostingSheetProcedure.ConditionApplication  = 'KA'
                                                                                   and _CostingSheetProcedure.CostingSheetProcedure = $projection.CostingSheet
  association [0..1] to I_UserContactCard          as _UserRespContactCard         on  $projection.CostCtrResponsibleUser = _UserRespContactCard.ContactCardID
  association [0..1] to I_UserContactCard          as _UserCrtedContactCard        on  $projection.CostCenterCreatedByUser = _UserCrtedContactCard.ContactCardID

  association [0..1] to I_Language                 as _Language                    on  $projection.Language = _Language.Language
  association [0..1] to I_AvailabilityCtrlProfile as _AvailabilityCtrlProfile      on  $projection.AvailabilityControlProfile = _AvailabilityCtrlProfile.AvailabilityControlProfile
  association [1..1] to E_CostCenter               as _Extension                   on  $projection.ControllingArea = _Extension.ControllingArea
                                                                                   and $projection.CostCenter      = _Extension.CostCenter
                                                                                   and $projection.ValidityEndDate = _Extension.ValidityEndDate

  association [0..1] to I_ActivityBasedCostingTmpl as _ActivityBasedCostingTmplCpi on  _ActivityBasedCostingTmplCpi.ControllingArea              = $projection.ControllingArea
                                                                                   and _ActivityBasedCostingTmplCpi.ActivityBasedCostingEnvrmt   = 'CPI'
                                                                                   and _ActivityBasedCostingTmplCpi.ActivityBasedCostingTemplate = $projection.ActyIndepFormulaPlanningTmpl

  association [0..1] to I_ActivityBasedCostingTmpl as _ActivityBasedCostingTmplCpd on  _ActivityBasedCostingTmplCpd.ControllingArea              = $projection.ControllingArea
                                                                                   and _ActivityBasedCostingTmplCpd.ActivityBasedCostingEnvrmt   = 'CPD'
                                                                                   and _ActivityBasedCostingTmplCpd.ActivityBasedCostingTemplate = $projection.ActyDepdntFormulaPlanningTmpl

  association [0..1] to I_ActivityBasedCostingTmpl as _ActivityBasedCostingTmplSci on  _ActivityBasedCostingTmplSci.ControllingArea              = $projection.ControllingArea
                                                                                   and _ActivityBasedCostingTmplSci.ActivityBasedCostingEnvrmt   = 'SCI'
                                                                                   and _ActivityBasedCostingTmplSci.ActivityBasedCostingTemplate = $projection.ActyIndependentAllocationTmpl

  association [0..1] to I_ActivityBasedCostingTmpl as _ActivityBasedCostingTmplScd on  _ActivityBasedCostingTmplScd.ControllingArea              = $projection.ControllingArea
                                                                                   and _ActivityBasedCostingTmplScd.ActivityBasedCostingEnvrmt   = 'SCD'
                                                                                   and _ActivityBasedCostingTmplScd.ActivityBasedCostingTemplate = $projection.ActyDependentAllocationTmpl

  association [0..1] to I_ActivityBasedCostingTmpl as _ActivityBasedCostingTmplSki on  _ActivityBasedCostingTmplSki.ControllingArea              = $projection.ControllingArea
                                                                                   and _ActivityBasedCostingTmplSki.ActivityBasedCostingEnvrmt   = 'SKI'
                                                                                   and _ActivityBasedCostingTmplSki.ActivityBasedCostingTemplate = $projection.ActlIndepStatisticalKeyFigures

  association [0..1] to I_ActivityBasedCostingTmpl as _ActivityBasedCostingTmplSkd on  _ActivityBasedCostingTmplSkd.ControllingArea              = $projection.ControllingArea
                                                                                   and _ActivityBasedCostingTmplSkd.ActivityBasedCostingEnvrmt   = 'SKD'
                                                                                   and _ActivityBasedCostingTmplSkd.ActivityBasedCostingTemplate = $projection.ActlDepStatisticalKeyFigures
{
      @ObjectModel.foreignKey.association: '_ControllingArea'
      //key cast( kokrs as fis_kokrs )  as ControllingArea,
  key kokrs                                           as ControllingArea,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @ObjectModel.text.association: '_Text'
      @ObjectModel.Hierarchy.association: '_CostCenterHierarchyNode'
  key kostl                                           as CostCenter,
      @Semantics.businessDate.to: true
  key datbi                                           as ValidityEndDate,
      @Semantics.businessDate.from: true
      datab                                           as ValidityStartDate,
      bkzkp                                           as IsBlkdForPrimaryCostsPosting,
      pkzkp                                           as IsBlockedForPlanPrimaryCosts,
      @ObjectModel.foreignKey.association: '_CompanyCode'
      bukrs                                           as CompanyCode,
      @ObjectModel.foreignKey.association: '_BusinessArea'
      gsber                                           as BusinessArea,
      @ObjectModel.foreignKey.association: '_CostCenterCategory'
      kosar                                           as CostCenterCategory,
      verak                                           as CostCtrResponsiblePersonName,
      @ObjectModel.foreignKey.association: '_UserRespContactCard'
      verak_user                                      as CostCtrResponsibleUser,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_Currency'
      waers                                           as CostCenterCurrency,
      @ObjectModel.foreignKey.association: '_CostingSheetProcedure'
      kalsm                                           as CostingSheet,
      txjcd                                           as TaxJurisdiction,
      @ObjectModel.foreignKey.association: '_ProfitCenter'
      prctr                                           as ProfitCenter,
      werks                                           as Plant,
      logsystem                                       as LogicalSystem,
      ersda                                           as CostCenterCreationDate,
      @ObjectModel.foreignKey.association: '_UserCrtedContactCard'
      usnam                                           as CostCenterCreatedByUser,
      bkzks                                           as IsBlkdForSecondaryCostsPosting,
      bkzer                                           as IsBlockedForRevenuePosting,
      bkzob                                           as IsBlockedForCommitmentPosting,
      cast(pkzks as fis_pkzks preserving type)        as IsBlockedForPlanSecondaryCosts,
      cast(pkzer as fis_pkzer preserving type)        as IsBlockedForPlanRevenues,
      vmeth                                           as CostCenterAllocationMethod,
      mgefl                                           as ConsumptionQtyIsRecorded,
      abtei                                           as Department,
      nkost                                           as SubsequentCostCenter,
      kvewe                                           as ConditionUsage,
      kappl                                           as ConditionApplication,
      koszschl                                        as CostCenterAccountingOverhead,
      @ObjectModel.foreignKey.association: '_Country'
      land1                                           as Country,
      anred                                           as FormOfAddress,
      name1                                           as AddressName,
      name2                                           as AddressAdditionalName,
      name3                                           as CostCenterAddrName3,
      name4                                           as CostCenterAddrName4,
      ort01                                           as CityName,
      ort02                                           as District,
      stras                                           as StreetAddressName,
      pfach                                           as POBox,
      pstlz                                           as PostalCode,
      pstl2                                           as POBoxPostalCode,
      @ObjectModel.foreignKey.association: '_Region'
      regio                                           as Region,
      @ObjectModel.foreignKey.association: '_Language'
      spras                                           as Language,
      telbx                                           as TeleboxNumber,
      telf1                                           as PhoneNumber1,
      telf2                                           as PhoneNumber2,
      telfx                                           as FaxNumber,
      teltx                                           as TeletexNumber,
      telx1                                           as TelexNumber,
      datlt                                           as DataCommunicationPhoneNumber,
      drnam                                           as CostCenterPrinterDestination,
      khinr                                           as CostCenterStandardHierArea,
      cckey                                           as CostCollector,
      kompl                                           as CostCenterIsComplete,
      cast(stakz as fins_xkostl_stat preserving type) as IsStatisticalCostCenter,
      objnr                                           as ObjectInternalID,
      funkt                                           as CostCenterFunction,
      afunk                                           as CostCenterAlternativeFunction,
      @ObjectModel.foreignKey.association: '_FunctionalArea'
      func_area                                       as FunctionalArea,
      @ObjectModel.foreignKey.association: '_ActivityBasedCostingTmplCpi'
      cpi_templ                                       as ActyIndepFormulaPlanningTmpl,
      @ObjectModel.foreignKey.association: '_ActivityBasedCostingTmplCpd'
      cpd_templ                                       as ActyDepdntFormulaPlanningTmpl,
      @ObjectModel.foreignKey.association: '_ActivityBasedCostingTmplSci'
      sci_templ                                       as ActyIndependentAllocationTmpl,
      @ObjectModel.foreignKey.association: '_ActivityBasedCostingTmplScd'
      scd_templ                                       as ActyDependentAllocationTmpl,
      @ObjectModel.foreignKey.association: '_ActivityBasedCostingTmplSki'
      ski_templ                                       as ActlIndepStatisticalKeyFigures,
      @ObjectModel.foreignKey.association: '_ActivityBasedCostingTmplSkd'
      skd_templ                                       as ActlDepStatisticalKeyFigures,
      vname                                           as JointVenture,
      recid                                           as JointVentureRecoveryCode,
      etype                                           as JointVentureEquityType,
      jv_otype                                        as JointVentureObjectType,
      jv_jibcl                                        as JointVentureClass,
      jv_jibsa                                        as JointVentureSubClass,
      budget_carrying_cost_ctr                        as BudgetCarryingCostCenter,
      avc_profile                                     as AvailabilityControlProfile,
      avc_active                                      as AvailabilityControlIsActive,
      
      fund                                            as Fund,
      grant_id                                        as GrantID,
      fund_fix_assigned                               as FundIsFixAssigned,
      grant_fix_assigned                              as GrantIDIsFixAssigned,
      func_area_fix_assigned                          as FunctionalAreaIsFixAssigned,

      _ControllingArea,
      _Text,
      _CostCenterHierarchyNode,
      _Currency,
      _CompanyCode,
      _BusinessArea,
      @Consumption.filter.businessDate.at: true
      _ProfitCenter,
      _FunctionalArea,
      _CostCenterCategory,
      _Country,
      _Region,
      _CostingSheetProcedure,
      _Language,
      _AvailabilityCtrlProfile,
      _UserRespContactCard,
      _UserCrtedContactCard,
      _ActivityBasedCostingTmplCpi,
      _ActivityBasedCostingTmplCpd,
      _ActivityBasedCostingTmplSci,
      _ActivityBasedCostingTmplScd,
      _ActivityBasedCostingTmplSki,
      _ActivityBasedCostingTmplSkd
}
