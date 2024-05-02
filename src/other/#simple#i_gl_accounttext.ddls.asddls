@EndUserText.label: 'General Ledger Account Text'
@Analytics:{
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture: {
        automatic: true
        }
    }
}
@ObjectModel.dataCategory: #TEXT
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: '/SIMPLE/IFIGLT'
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
define view /SIMPLE/I_GLAccountText
  as select from skat

  
  //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
  association [0..*] to I_ChartOfAccountsText      as _ChartOfAccountsText on   $projection.ChartOfAccounts = _ChartOfAccountsText.ChartOfAccounts
  // ]--GENERATED
  association [0..1] to I_Language        as _Language        on $projection.Language = _Language.Language

  association [0..1] to I_ChartOfAccounts as _ChartOfAccounts on $projection.ChartOfAccounts = _ChartOfAccounts.ChartOfAccounts

{
      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_ChartOfAccountsStdVH',
                     element: 'ChartOfAccounts' }
        }]
      @ObjectModel.text.association: '_ChartOfAccountsText'
      // ]--GENERATED      
      @ObjectModel.foreignKey.association: '_ChartOfAccounts' //Inserted by VDM CDS Suite Plugin
  key ktopl           as ChartOfAccounts,
  key saknr           as GLAccount,
      @Semantics.language: true
      @ObjectModel.foreignKey.association: '_Language' //Inserted by VDM CDS Suite Plugin
  key spras           as Language,
      @Semantics.text: true
      txt20           as GLAccountName,
      @Semantics.text: true
      txt50           as GLAccountLongName,
      last_changed_ts as LastChangeDateTime,
      _Language,
      _ChartOfAccounts,
      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      @Consumption.hidden: true
      _ChartOfAccountsText
      // ]--GENERATED

}; 
 
