@AbapCatalog.sqlViewName: '/SIMPLE/MDBK2'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Bank Key'
define view /SIMPLE/MDBANKKEY2
  as select from /SIMPLE/MDBANKKEY
{
  key BankCountry as bankCountry,
  key BankKey     as bankKey,   //Kent - Ajust to key field 28/02/2022
      BankName    as bankName,
      City        as city,
      BankNumber  as bankNumber,
      SWIFBIC     as swifBIC,
      BankBranch  as bankBranch,
      StreetHouse as streetHouse
}
