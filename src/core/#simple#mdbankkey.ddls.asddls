@AbapCatalog.sqlViewName: '/SIMPLE/MDBNKKEY'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Bank Key'
define view /SIMPLE/MDBANKKEY
  as select from bnka
{
  key banks as bankCountry,
  key bankl as bankKey,     //Kent - Ajust to key field 28/02/2022
      banka as bankName,
      ort01 as city,
      bnklz as bankNumber,
      swift as swifBIC,
      brnch as bankBranch,
      stras as streetHouse
}
