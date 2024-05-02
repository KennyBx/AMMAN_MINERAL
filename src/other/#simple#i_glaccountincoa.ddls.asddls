@EndUserText.label: 'G/L Account In Chart Of Accounts'
@Analytics: {
    dataCategory: #DIMENSION,
        dataExtraction: {
        enabled: true,
        delta.changeDataCapture: {
        automatic: true
        }
    }
}
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: '/SIMPLE/IFIGLIC'
@ObjectModel.entityChangeStateId: 'LastChangeDateTime'
@ObjectModel.representativeKey: 'GLAccount'
//@AccessControl.authorizationCheck: #CHECK
@AbapCatalog.buffering.status: #NOT_ALLOWED
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass:  #MASTER
@ObjectModel.usageType.serviceQuality: #B
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.createEnabled:true
@ObjectModel.updateEnabled:true
@ObjectModel.deleteEnabled:true
@Search.searchable: true
@Metadata.allowExtensions: true

@AbapCatalog.preserveKey:true
//--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
@AccessControl.privilegedAssociations: ['_ChartOfAccountsText','_GLAccountGroupText']
// ]--GENERATED

define view /SIMPLE/I_GLAccountInCOA
  as select from ska1

  //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
  association [0..*] to I_ChartOfAccountsText       as _ChartOfAccountsText       on  $projection.ChartOfAccounts = _ChartOfAccountsText.ChartOfAccounts
  association [0..*] to I_GLAccountGroupText        as _GLAccountGroupText        on  $projection.GLAccountGroup  = _GLAccountGroupText.GLAccountGroup
                                                                                  and $projection.ChartOfAccounts = _GLAccountGroupText.ChartOfAccounts
  // ]--GENERATED
  association [0..1] to I_ChartOfAccounts           as _ChartOfAccounts           on  $projection.ChartOfAccounts = _ChartOfAccounts.ChartOfAccounts

  association [0..*] to /SIMPLE/I_GLAccountText     as _Text                      on  $projection.ChartOfAccounts = _Text.ChartOfAccounts
                                                                                  and $projection.GLAccount       = _Text.GLAccount
  association [0..*] to /SIMPLE/I_GLAccountCompC    as _CompCode                  on  $projection.GLAccount = _CompCode.GLAccount

  association [0..1] to I_GLAccountType             as _GLAccountType             on  $projection.GLAccountType = _GLAccountType.GLAccountType

  association [0..1] to I_RetainedEarningsGLAccount as _RetainedEarningsGLAccount on  $projection.ChartOfAccounts       = _RetainedEarningsGLAccount.ChartOfAccounts
                                                                                  and $projection.ProfitLossAccountType = _RetainedEarningsGLAccount.ProfitLossAccountType


  association [0..*] to I_GLAccountHierarchyNode    as _GLAccountHierarchyNode    on  $projection.GLAccount       = _GLAccountHierarchyNode.GLAccount
                                                                                  and $projection.ChartOfAccounts = _GLAccountHierarchyNode.ChartOfAccounts

  association [0..1] to I_FunctionalArea            as _FunctionalArea            on  $projection.FunctionalArea = _FunctionalArea.FunctionalArea

  association [1..1] to I_User                      as _User                      on  $projection.CreatedByUser = _User.UserID

  association [1..1] to I_Globalcompany             as _GlobalCompany             on  $projection.PartnerCompany = _GlobalCompany.Company

  association [0..1] to I_GLAccountGroup            as _GLAccountGroup            on  $projection.GLAccountGroup  = _GLAccountGroup.GLAccountGroup
                                                                                  and $projection.ChartOfAccounts = _GLAccountGroup.ChartOfAccounts

  association [0..1] to I_GLAcctInChartOfAcctsProdn as _GLAcctInChartOfAcctsProdn on  $projection.ChartOfAccounts = _GLAcctInChartOfAcctsProdn.ChartOfAccounts
                                                                                  and $projection.GLAccount       = _GLAcctInChartOfAcctsProdn.GLAccount
{
      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ChartOfAccountsStdVH',
                     element: 'ChartOfAccounts' }
        }]
      @ObjectModel.text.association: '_ChartOfAccountsText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ChartOfAccounts' //Inserted by VDM CDS Suite Plugin
      @Search.defaultSearchElement:true
      @Search.fuzzinessThreshold:0.8
      @Search.ranking:#HIGH
  key ska1.ktopl             as ChartOfAccounts,
      @ObjectModel.text.association: '_Text'
      @ObjectModel.hierarchy.association: '_GLAccountHierarchyNode'
  key ska1.saknr             as GLAccount,
      ska1.xbilk             as IsBalanceSheetAccount,
      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_GLAccountGroupStdVH',
                     element: 'GLAccountGroup' },
          additionalBinding: [{ localElement: 'ChartOfAccounts',
                                element: 'ChartOfAccounts' }]
        }]
      @ObjectModel.text.association: '_GLAccountGroupText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_GLAccountGroup'
      ska1.ktoks             as GLAccountGroup,
      //cast(ska1.bilkt as FIS_BILKT_TXT50) as CorporateGroupAccount,
      //add
      //      ska1.CURRENCY        as GLCurrency,
      //end
      ska1.bilkt             as CorporateGroupAccount,
      ska1.gvtyp             as ProfitLossAccountType,
      ska1.mustr             as SampleGLAccount,
      ska1.xloev             as AccountIsMarkedForDeletion,
      ska1.xspea             as AccountIsBlockedForCreation,
      ska1.xspeb             as AccountIsBlockedForPosting,
      ska1.xspep             as AccountIsBlockedForPlanning,
      @ObjectModel.foreignKey.association: '_Globalcompany'
      ska1.vbund             as PartnerCompany,
      @ObjectModel.foreignKey.association: '_FunctionalArea' //Inserted by VDM CDS Suite Plugin
      ska1.func_area         as FunctionalArea,
      ska1.erdat             as CreationDate,
      ska1.ernam             as CreatedByUser,
      ska1.last_changed_ts   as LastChangeDateTime,
      @ObjectModel.foreignKey.association: '_Glaccounttype' //Inserted by VDM CDS Suite Plugin
      ska1.glaccount_type    as GLAccountType,
      ska1.glaccount_subtype as GLAccountSubtype,
      ska1.sakan             as GLAccountExternal,
      @EndUserText.label: 'Profit Loss Account'
      cast(case when ska1.xbilk = 'X' then
          ' '
      else
          'X'
      end as xbilk)          as IsProfitLossAccount,
      _User,
      _ChartOfAccounts,
      _Text,
      _CompCode,
      _GLAccountHierarchyNode,
      _FunctionalArea,
      _RetainedEarningsGLAccount,
      _GLAccountType,
      _GLAccountGroup,
      _GlobalCompany,
      _GLAcctInChartOfAcctsProdn,
      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      @Consumption.hidden: true
      _ChartOfAccountsText,
      @Consumption.hidden: true
      _GLAccountGroupText
      // ]--GENERATED

};
