@AbapCatalog.sqlViewName: '/SIMPLE/ICLOBCLB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Classification Class of Object'
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_REMOTE_API

@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
define view /SIMPLE/I_ClfnObjectClassBasic
  as select from kssk as ObjectClass
{
  key ObjectClass.objek as ClfnObjectID,
  key ObjectClass.mafid as ClfnObjectType,
  key ObjectClass.klart as ClassType,
  key ObjectClass.clint as ClassInternalID,
  key ObjectClass.adzhl as TimeIntervalNumber,
      ObjectClass.statu as ClfnStatus,
      @Semantics.businessDate.from: true
      ObjectClass.datuv as ValidityStartDate,
      @Semantics.businessDate.to: true
      ObjectClass.datub as ValidityEndDate,
      ObjectClass.lkenz as IsDeleted,
      ObjectClass.aennr as ChangeNumber,
      ObjectClass.zaehl as ClassPositionNumber,
      ObjectClass.stdcl as ClassIsStandardClass,
      ObjectClass.rekri as BOMIsRecursive
}
