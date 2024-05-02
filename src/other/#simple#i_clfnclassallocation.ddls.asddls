@AbapCatalog.sqlViewName: '/SIMPLE/ICLALLOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Classification Class Allocation'
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_REMOTE_API

@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
define view /SIMPLE/I_ClfnClassAllocation
  as select from /SIMPLE/I_ClfnObjectClassBasic as ObjectClass
    inner join   /SIMPLE/I_ClfnClass            as Class on ObjectClass.ClfnObjectID = Class.ClassInternalID
  association [0..*] to /SIMPLE/I_ClfnObjCharcValBasic as _CharcValue on  $projection.SubClassID     = _CharcValue.ClfnObjectID
                                                                      and $projection.ClfnObjectType = _CharcValue.ClfnObjectType
{
  key ObjectClass.ClfnObjectID                           as SubClassID,
  key ObjectClass.ClfnObjectType,
  key ObjectClass.ClassType,
  key ObjectClass.ClassInternalID                        as SuperiorClassID,
  key ObjectClass.TimeIntervalNumber,
      Class.Class                                        as SubClass,
      ObjectClass.ClfnStatus,
      @Semantics.businessDate.from: true
      ObjectClass.ValidityStartDate,
      @Semantics.businessDate.to: true
      ObjectClass.ValidityEndDate,
      ObjectClass.IsDeleted,
      ObjectClass.ChangeNumber,
      ObjectClass.ClassPositionNumber,
      cast( ObjectClass.ClassIsStandardClass as normda ) as ClassIsStandardClass,
      ObjectClass.BOMIsRecursive,
      Class.MMSClassType,
      Class.MMSView,
      _CharcValue
}
where
      ObjectClass.ClfnObjectType = 'K'   // Allocation between Classes
  and ObjectClass.ClassType      = '026' // Retail Class
  and Class.MMSClassType         = '0' // MCH
