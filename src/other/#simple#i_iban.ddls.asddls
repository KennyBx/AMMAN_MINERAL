@AbapCatalog.sqlViewName: '/SIMPLE/IIBAN'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'IBAN'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE


define view /SIMPLE/I_Iban
  as select from tiban
{
  key banks      as BankCountry,
  key bankl      as Bank,
  key bankn      as BankAccount,
  key bkont      as BankControlKey,
      iban       as IBAN,
      valid_from as IBANValidityStartDate

}
