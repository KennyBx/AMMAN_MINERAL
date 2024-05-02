@AbapCatalog.sqlViewName: '/SIMPLE/CBM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'BankMaster'
define root view /SIMPLE/C_BankMaster
  as select from bnka
  composition[0..*] of /SIMPLE/C_Address as _Address
{
  key banks                          as bankCountry,
  key bankl                          as bankInternalID,
      banka                          as bankName,
      provz                          as region,
      stras                          as streetName,
      ort01                          as cityName,
      swift                          as swiftCode,
      bgrup                          as bankGroup,
      xpgro                          as isPostBankAccount,
      loevm                          as isMarkedForDeletion,
      bnklz                          as bank,
      pskto                          as postOfficeBankAccount,
      brnch                          as branch,
      adrnr                          as addressID,
      chkme                          as checkDigitCalculationMethod,
      vers                           as bankDataFileFormat,

 
      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 50 ) )  as action,
      cast( '' as abap.char( 1333 ) ) as mdgMarkForChange,
      cast( '' as abap.char( 36 ) )  as mdgLogID,
      cast( '' as abap.char( 50 ) )  as actionMode,
      cast( '' as abap.char( 20 ) )  as activateID,
      cast( '' as abap.char( 20 ) )  as activateItemID,
      cast( '' as abap.char( 100 ) ) as crNumber,
      cast( '' as abap.char( 100 ) ) as crItem,
      
      /* Associations */
      _Address
}




