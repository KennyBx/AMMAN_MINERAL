@AbapCatalog.sqlViewName: '/SIMPLE/CEMS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity for API Event Mesh AMQP'
define root view /SIMPLE/C_Event_Mesh as select from /simple/api_log
{
    key mdglogid as mdglogid
}
