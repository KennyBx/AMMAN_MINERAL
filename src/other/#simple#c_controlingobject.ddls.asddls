@AbapCatalog.sqlViewName: '/SIMPLE/CCOOBJ'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #CONSUMPTION
@EndUserText.label: 'ControlingObject'
define view /SIMPLE/C_ControllingObject
  as select from I_ControllingObject
{
  key ControllingObject              as controllingObject,
      OrderID                        as orderID,
      BusinessProcess                as businessProcess,
      CostCtrActivityType            as costCtrActivityType,
      SalesDocument                  as salesDocument,
      SalesDocumentItem              as salesDocumentItem,
      ControllingArea                as controllingArea,
      CostCenter                     as costCenter,
      WBSElementInternalID           as wbsElementInternalID,
      ProjectInternalID              as projectInternalID,
      ControllingObjectType          as controllingObjectType,
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,

      //  Propagate association(s)
      _ControllingArea,
      _CostCenter,
      _CostCtrActivityType

};
