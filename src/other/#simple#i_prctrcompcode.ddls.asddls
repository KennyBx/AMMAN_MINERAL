@EndUserText.label: 'Profit Center and CompCode'
@Analytics:{
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture: {
        automatic: true
        }
    }
}
//@ObjectModel.dataCategory: #TEXT
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: '/SIMPLE/IFIPCCC'
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
define view /SIMPLE/I_PRCTRCOMPCODE
  as select from cepc_bukrs


  //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
  //  association [0..*] to I_ChartOfAccountsText      as _ChartOfAccountsText on   $projection.ChartOfAccounts = _ChartOfAccountsText.ChartOfAccounts
  // ]--GENERATED
  //  association [0..1] to I_Language        as _Language        on $projection.Language = _Language.Language

  //  association [0..1] to I_ChartOfAccounts as _ChartOfAccounts on $projection.ChartOfAccounts = _ChartOfAccounts.ChartOfAccounts

{
      //      //--[ GENERATED:012:29JlHNUf7jY4ip0dSlCN8W
      //      @Consumption.valueHelpDefinition: [
      //        { entity:  { name:    'I_ChartOfAccountsStdVH',
      //                     element: 'ChartOfAccounts' }
      //        }]
      //      @ObjectModel.text.association: '_ChartOfAccountsText'
      //      // ]--GENERATED
      //      @ObjectModel.foreignKey.association: '_ChartOfAccounts' //Inserted by VDM CDS Suite Plugin
  key kokrs as ControllingArea,
  key prctr as ProfitCenter,
  key bukrs as CompanyCode
};
