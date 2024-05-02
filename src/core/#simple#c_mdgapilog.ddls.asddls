@AbapCatalog.sqlViewName: '/SIMPLE/CMDGAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '/SIMPLE/C_MDGAPILOG'

define view /SIMPLE/C_MDGAPILOG
  as select from /simple/api_log
{
  key mdglogid           as mdgLogID,
      cr_number          as reqID,
      cr_item            as itemID,
      activate_id        as activateID,
      activate_item_id   as activateItemID,
      obj_type           as objectType,
      mdg_key            as mdgKey,
      status             as status,
      cast( step as abap.char( 2 ) ) as step,
      message_log        as messageLog,
      additional_message as additionalMessage,
      changedat          as changeDat,
      changetim          as changeTime
}
where
  mdglogid <> ''
