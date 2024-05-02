@AbapCatalog.sqlViewName: '/SIMPLE/IBANK'
@EndUserText.label: 'Bank Master Details'
@Analytics: {dataCategory: #DIMENSION, dataExtraction.enabled: true}
@VDM.viewType: #BASIC
@ObjectModel.representativeKey: 'BankInternalID'
@AccessControl.authorizationCheck: #CHECK //#NOT_REQUIRED
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.serviceQuality: #B
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions:true
@Search.searchable: true
@AbapCatalog.preserveKey:true
define view /SIMPLE/I_Bank
  as select from bnka
//  //    left outer join adr6 as address_mail on  bnka.adrnr = address_mail.addrnumber
//  //and bnka.adrnr <> ''
//  association [0..1] to /SIMPLE/I_Address              as _Address              on  $projection.AddressID = _Address.AddressID
//  association [0..1] to /SIMPLE/I_Region               as _Region               on  $projection.Region      = _Region.Region
//                                                                        and $projection.BankCountry = _Region.Country
//  association [0..*] to /SIMPLE/I_Housebank            as _HouseBank            on  $projection.Bank        = _HouseBank.HouseBank
//                                                                        and $projection.BankCountry = _HouseBank.BankCountry
//  association [0..1] to /SIMPLE/I_Country              as _Country              on  $projection.BankCountry = _Country.Country
//  association [0..1] to /SIMPLE/I_BankAdditionalFields as _BankAdditionalFields on  $projection.BankCountry    = _BankAdditionalFields.BankCountry
//                                                                        and $projection.BankInternalID = _BankAdditionalFields.BankInternalID
//  association [0..1] to /SIMPLE/I_BankIntraStaRule     as _IntradayRule         on  $projection.BankCountry    = _IntradayRule.BankCountry
//                                                                        and $projection.BankInternalID = _IntradayRule.BankInternalID

{
      @ObjectModel.foreignKey.association: '_Country'
  key banks as BankCountry,
      @ObjectModel.text.element: 'BankName'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key bankl as BankInternalID,
      erdat as CreationDate,
      ernam as CreatedByUser,
      @Semantics.text: true
      banka as BankName,
      provz as Region,
      stras as StreetName,
      ort01 as CityName,
      swift as SWIFTCode,
      bgrup as BankGroup,
      xpgro as IsPostBankAccount,
      loevm as IsMarkedForDeletion,
      bnklz as Bank,
      pskto as PostOfficeBankAccount,
      brnch as Branch,
      chkme as CheckDigitCalculationMethod,
      vers  as BankDataFileFormat,
      adrnr as AddressID
      //      address_mail.smtp_addr as RoleOwnerEmailAddress,
//      _Address,
//      _Region,
//      _HouseBank,
//      _Country,
//      _BankAdditionalFields,
//      _IntradayRule
}
//where
//     loevm = ''
//  or loevm = ' ';
