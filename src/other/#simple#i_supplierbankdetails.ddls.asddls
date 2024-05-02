@EndUserText.label: 'SupplierBankDetails' //same as DDL description
@Analytics.dataCategory: #DIMENSION //or #CUBE or #FACT
@VDM.viewType: #BASIC
@ClientHandling.algorithm : #SESSION_VARIABLE
@AccessControl.authorizationCheck: #CHECK
@AbapCatalog.sqlViewName: '/SIMPLE/ISUPBD' //must start with "I"
@ObjectModel.representativeKey: 'Bank'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.dataClass: #MASTER
@AccessControl.personalData.blocking: #REQUIRED
@Metadata.allowExtensions:true
define view /SIMPLE/I_SupplierBankDetails //must start with "I_"; same as DDL source name in upper-camelcase notation
  as select from lfbk
  //  //---> Decomment if you want to join further data sources
  //  //left outer to one join DatabaseTableOrBasicCdsView2 //recommendation: use addition "to one" or "to many"
  //  //   on LFBK.FieldName = DatabaseTableOrBasicCdsView2.FieldName2
  //  association [1..1] to /SIMPLE/I_Bank as _Bank on  $projection.BankCountry = _Bank.BankCountry
  //                                        and $projection.Bank        = _Bank.BankInternalID
  //
  //  association [1..1] to /SIMPLE/I_Supplier as _Supplier on $projection.Supplier = _Supplier.Supplier
  //
  //  association [1..1] to /SIMPLE/I_Country as _Country on $projection.BankCountry = _Country.Country
  //
  //  association [1..1] to /SIMPLE/I_BankAccount as _BankAccount on $projection.BankAccount = _BankAccount.BankAccountInternalID //Added to remove representative key ATC, DO NOT USE
  //
  //  association [0..1] to /SIMPLE/I_Iban as _IBAN on $projection.BankAccount = _IBAN.BankAccount
  //                                       and $projection.Bank = _IBAN.Bank
  //                                       and $projection.BankCountry = _IBAN.BankCountry
  //                                       and $projection.BankControlKey = _IBAN.BankControlKey

{
      //   key cast (lifnr as bu_partner) as Supplier,
      //--[ GENERATED:012:GlBfhyJl7kY4i6}7dD1KRG
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_Supplier_VH',
                     element: 'Supplier' }
        }]
      // ]--GENERATED
//      @ObjectModel.foreignKey.association: '_Supplier'
  key lifnr as Supplier,
//      @ObjectModel.foreignKey.association: '_Country'
  key banks as BankCountry,
      //  @ObjectModel.text.element: '_Bank.BankName'
  key bankl as Bank,
      //--[ GENERATED:012:GlBfhyJl7kY4i6}7dD1KRG
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BankAccountStdVH',
                     element: 'BankAccountInternalID' }
        }]
      // ]--GENERATED
//      @ObjectModel.foreignKey.association: '_BankAccount'
  key bankn as BankAccount,

      // deactivated  -  performance. Use _Bank associatoin and then the corresponding fields
      //      _Bank.CityName  as CityName,
      //      _Bank.BankName  as BankName,
      //      _Bank.SWIFTCode as SWIFTCode,

      //    bkont as BankControlKey,
      bvtyp as BPBankAccountInternalID,
      //xezer as ,
      //bkref,

      koinh as BankAccountHolderName,
      //ebpp_accname,
      //ebpp_bvstatus,

      bkont as BankControlKey,
      bkref as BankDetailReference
      //
      //
      //
      //      //_TargetPublicBasicViewNameWithoutPrefix //expose the association for use by consumers
      //      _Bank,
      //      _Country,
      //      _Supplier.AuthorizationGroup,
      //      _Supplier,
      //      _BankAccount,
      //      _IBAN
}
