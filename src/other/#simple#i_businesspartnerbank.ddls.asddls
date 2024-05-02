@AbapCatalog.sqlViewName: '/SIMPLE/IBPBANK'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@VDM.viewType: #BASIC
@EndUserText.label: 'core view for Bank details'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER

define view /SIMPLE/I_BusinessPartnerBank
  as select from but0bk as BusinessPartnerBank

  association [1..1] to /SIMPLE/I_BusinessPartner as _BusinessPartner on  $projection.BusinessPartner = _BusinessPartner.BusinessPartner

  association [1..1] to /SIMPLE/I_Bank            as _Bank            on  $projection.BankNumber     = _Bank.BankInternalID
                                                              and $projection.BankCountryKey = _Bank.BankCountry

  //  association [1..1] to tiban  as _IBAN on  $projection.BankAccount    = _IBAN.bankn
  //                                        and $projection.BankNumber     = _IBAN.bankl
  //                                        and $projection.BankCountryKey = _IBAN.banks
  //                                        and $projection.BankControlKey = _IBAN.bkont


  association [1..1] to /SIMPLE/I_Iban            as _IBAN            on  $projection.BankAccount    = _IBAN.BankAccount
                                                              and $projection.BankNumber     = _IBAN.Bank
                                                              and $projection.BankCountryKey = _IBAN.BankCountry
                                                              and $projection.BankControlKey = _IBAN.BankControlKey

{
  key BusinessPartnerBank.partner                                            as  BusinessPartner,
  key BusinessPartnerBank.bkvid                                              as  BankIdentification,
      BusinessPartnerBank.banks                                              as  BankCountryKey,
      _Bank.BankName                                                         as  BankName,
      BusinessPartnerBank.bankl                                              as  BankNumber,
      _Bank.SWIFTCode                                                        as  SWIFTCode,
      BusinessPartnerBank.bkont                                              as  BankControlKey,
      BusinessPartnerBank.koinh                                              as  BankAccountHolderName,
      BusinessPartnerBank.accname                                            as  BankAccountName,
      BusinessPartnerBank.bk_valid_from                                      as  ValidityStartDate,
      BusinessPartnerBank.bk_valid_to                                        as  ValidityEndDate,
      //_IBAN.IBAN                                                             as  IBAN,
      case
      when BusinessPartnerBank.bankn <> ''
      then _IBAN.IBAN
      else
       BusinessPartnerBank.iban 
      end as IBAN,
      _IBAN.IBANValidityStartDate                                            as  IBANValidityStartDate,
      BusinessPartnerBank.bankn                                              as  BankAccount,
      BusinessPartnerBank.bkref                                              as  BankAccountReferenceText,
      BusinessPartnerBank.xezer                                              as  CollectionAuthInd,
      BusinessPartnerBank.bkext                                              as  BusinessPartnerExternalBankID,
      BusinessPartnerBank.bk_move_date                                       as  BPBankDetailsChangeDate,
      BusinessPartnerBank.move_bkvid                                         as  BPBankDetailsChangeTargetID,
      BusinessPartnerBank.protect                                            as  BPBankIsProtected,
      _Bank.CityName                                                         as  CityName,
      _Bank,
      _IBAN,
      _BusinessPartner,
      _BusinessPartner.AuthorizationGroup
}
