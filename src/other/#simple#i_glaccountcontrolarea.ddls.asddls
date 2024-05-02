@EndUserText.label: 'GL Account in Company Code'
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
@AbapCatalog.sqlViewName: '/SIMPLE/IGLACCCA'
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
define view /SIMPLE/I_GLAccountControlArea
  as select from cskb
  association [0..1] to /SIMPLE/I_GLAccountInCOA as _GLAccountInCOA on $projection.CostElement       = _GLAccountInCOA.GLAccount
{
  key kokrs as ControllingArea,
  key kstar as CostElement,
  key datbi as ValidToDate,
      datab as ValidFromDate,
      katyp as CostElementCategory,
      ersda as EnteredOn,
      usnam as EnteredBy,
      mgefl as IndicatorForRCQuantities,
      msehi as UnitOfMeasurement,
      
      _GLAccountInCOA
};
