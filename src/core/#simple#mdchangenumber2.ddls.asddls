@AbapCatalog.sqlViewName: '/SIMPLE/MDAENR2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Change master2'
define view /SIMPLE/MDCHANGENUMBER2
  as select from /SIMPLE/MDCHANGENUMBER
{
  key changeNumber             as changeNumber,
      
      description              as description,
      createdBy                as createdBy,
      validFrom                as validFrom,
      changeType               as changeType,
      changeNoStatus           as changeNoStatus,
      authorizationGroup       as authorizationGroup,
      isActivate               as isActivate
//      IsActivateBOM            as isActivateBOM,
//      IsActivateMaterial       as isActivateMaterial,
//      IsActivateTaskList       as isActivateTaskList,
//      IsActivateCharacteristic as isActivateCharacteristic,
//      IsActivateClassChars     as isActivateClassChars 
}
