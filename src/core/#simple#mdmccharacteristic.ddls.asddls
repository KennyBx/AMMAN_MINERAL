@AbapCatalog.sqlViewName: '/SIMPLE/MDMCCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'MDMCCharacteristic'
define view /SIMPLE/MDMCCharacteristic
  as select from cabn  as Characteristic
    inner join   cabnt as Text on  Characteristic.atinn = Text.atinn
                               and Characteristic.adzhl = Text.adzhl
{
      //  key cast ( Characteristic.atinn as atinn_no_conv preserving type ) as charcInternalID,
      //  key Characteristic.adzhl                                           as timeIntervalNumber,
  key Characteristic.atnam    as characteristic,
  key Text.spras              as locale,
      Characteristic.atmst    as status,
      Characteristic.atfor    as dataType,
      Characteristic.anzst    as length,
      Characteristic.anzdz    as decimals,
      Characteristic.unit     as valueUnit,
      Characteristic.currency as currency,
      Characteristic.aterf    as entryIsRequired,
      Text.atbez              as description
}
where
      Characteristic.atidn =  ''
  and Characteristic.atnam <> ''
