@EndUserText.label: 'GL Account in Company Code'
//@Analytics:{
//    dataExtraction: {
//        enabled: true,
//        delta.changeDataCapture: {
//        automatic: true
//        }
//    }
//}
//@ObjectModel.dataCategory: #TEXT
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: '/SIMPLE/IFIGLCC'
@ObjectModel.entityChangeStateId: 'LastChangeDateTime'
@ObjectModel.representativeKey: 'GLAccount'
@AbapCatalog.buffering.status: #ACTIVE
@AbapCatalog.buffering.type: #FULL
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass:  #MASTER
@ObjectModel.usageType.serviceQuality: #A
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.buffering.numberOfKeyFields: 1
@ObjectModel.createEnabled:true
@ObjectModel.updateEnabled:true
@ObjectModel.deleteEnabled:true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
@AccessControl.authorizationCheck: #CHECK
/*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ]  } */
//--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
@AccessControl.privilegedAssociations: ['_ChartOfAccountsText']
// ]--GENERATED
@AbapCatalog.preserveKey:true
define view /SIMPLE/I_GLAccountCompC
  as select from skb1

    inner join   t001 on skb1.bukrs = t001.bukrs

  association [0..1] to /SIMPLE/I_GLAccountInCOA as _GLAccountInCOA on  $projection.GLAccount       = _GLAccountInCOA.GLAccount
                                                                    and $projection.ChartOfAccounts = _GLAccountInCOA.ChartOfAccounts

  //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
  //  association [0..*] to I_ChartOfAccountsText      as _ChartOfAccountsText on   $projection.ChartOfAccounts = _ChartOfAccountsText.ChartOfAccounts
  // ]--GENERATED
  //  association [0..1] to I_Language        as _Language        on $projection.Language = _Language.Language

  //    association [0..1] to I_ChartOfAccounts as _ChartOfAccounts on $projection.ChartOfAccounts = _ChartOfAccounts.ChartOfAccounts

{
      //      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      //      @Consumption.valueHelpDefinition: [
      //        { entity:  { name:    'I_ChartOfAccountsStdVH',
      //                     element: 'ChartOfAccounts' }
      //        }]
      //      @ObjectModel.text.association: '_ChartOfAccountsText'
      //      // ]--GENERATED
      //      @ObjectModel.foreignKey.association: '_ChartOfAccounts' //Inserted by VDM CDS Suite Plugin
  key skb1.bukrs                                     as CompanyCode,
  key skb1.saknr                                     as GLAccount,
      //      @Semantics.language: true
      //      @ObjectModel.foreignKey.association: '_Language' //Inserted by VDM CDS Suite Plugin
  key skb1.waers                                     as Currency,
      t001.ktopl                                     as ChartOfAccounts,
      zuawa                                          as Sortkey,
      mwskz                                          as TaxCategory,
      fstag                                          as FieldStatusGrp,
      mitkz                                          as IsReconAcct,
      xmwno                                          as TaxisnotReq,
      bewgp                                          as ValuationGroup,
      kdfsl                                          as KeyForExchangeRate,
      altkt                                          as AlternativeAccountNumber,
      wmeth                                          as IndicatorAccountMangedExt,
      infky                                          as InflationKey,
      togru                                          as ToleranceGroup,
      xopvw                                          as IndicatorOpenInManagement,
      xkres                                          as IndicatorLineItemDisplay,
      begru                                          as AuthorizationGroup,
      busab                                          as AccountingClerkAbbre,
      xsalh                                          as ManageBalancesInLocalCur,
      xnkon                                          as IndicatorSuppAutoPost,
      xmitk                                          as IndicatorRecoincilPost,
      fdlev                                          as PlanningLevel,
      xgkon                                          as CashReceiptAccount,
      cast( fipos as /simple/fipos preserving type ) as CommitmentItem,
      hbkid                                          as HouseBankShortKey,
      hktid                                          as AccountDetailID,
      vzskz                                          as IndicatorInterestCal,
      zindt                                          as LastCalculationKeyDate,
      zinrt                                          as CalFrequencyInMonths,
      datlz                                          as LastCalRunDate,
      recid                                          as IndicatorRecovery,
      xspeb                                          as IndicatorAccountPostBlock,
      xloeb                                          as IndicatorMarkedForDeletion,
      xlgclr                                         as ClearingLedgerGroups,
      mcakey                                         as MCAKey,
      xintb                                          as IndicatorAccountPostAuto,

      _GLAccountInCOA

      //      _Language,
      //      _ChartOfAccounts,
      //      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      //      @Consumption.hidden: true
      //      _ChartOfAccountsText
      //      // ]--GENERATED

};
