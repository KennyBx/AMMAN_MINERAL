@AbapCatalog.sqlViewName: '/SIMPLE/IRTGRAPI'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Routing main (Transactional Processing)'
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type:#PUBLIC_REMOTE_API
@ObjectModel.usageType: {serviceQuality: #D, sizeCategory: #XL, dataClass: #TRANSACTIONAL}

@AbapCatalog.preserveKey: true
define root view /SIMPLE/I_RoutingGroupAPITP
  as select from /SIMPLE/I_BOOGroupData as boo_groupdata
{
      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key boo_groupdata.BillOfOperationsType,
  key boo_groupdata.BillOfOperationsGroup,
      boo_groupdata.EngineeringChangeDocForEdit,
      boo_groupdata.KeyDate
  
      // Associations
      //boo_groupdata._BillOfOperationsType
}
