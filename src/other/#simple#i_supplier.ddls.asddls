@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: '/SIMPLE/ISUPPL'
@EndUserText.label: 'Supplier'
@VDM.viewType: #BASIC
@AccessControl.personalData.blocking: #REQUIRED
@AccessControl.personalData.blockingIndicator: 'IsBusinessPurposeCompleted'
@AccessControl.authorizationCheck: #CHECK
@Analytics.dataCategory: #DIMENSION
@ObjectModel.representativeKey: 'Supplier'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.dataClass: #MASTER
@Metadata.allowExtensions: true
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_Supplier
  as select from lfa1

  //private associations
//  association [1..1] to /SIMPLE/I_SuptoBP              as _cvi                      on $projection.Supplier = _cvi.Supplier
  association [0..1] to bp1020                         as _FiscalData               on lfa1.lifnr = _FiscalData.partnr // technically wrong for lifnr<>but000.partner, but usage of $projection.BusinessPartner is not allowed. H
  //public composition associations
//  association [0..*] to /SIMPLE/I_SupplierCompany      as _SupplierCompany          on $projection.Supplier = _SupplierCompany.Supplier
  association [0..*] to /SIMPLE/I_SupplierPurchOrg     as _SupplierPurchasingOrg    on $projection.Supplier = _SupplierPurchasingOrg.Supplier
  association [0..*] to /SIMPLE/I_SupplierBankDetails  as _SupplierBankDetails      on $projection.Supplier = _SupplierBankDetails.Supplier
  //public value helps
  association [0..1] to /SIMPLE/I_SupAccountGroup      as _SupplierAccountGroup     on $projection.SupplierAccountGroup = _SupplierAccountGroup.SupplierAccountGroup
  association [0..*] to /SIMPLE/I_Industries           as _Industry                 on $projection.Industry = _Industry.IndustrySector
  //public foreign key associations
  association [0..1] to /SIMPLE/I_Customer             as _CorrespondingCustomer    on $projection.Customer = _CorrespondingCustomer.Customer

  ////public texts
//  association [0..*] to /SIMPLE/I_SupAccountGroupT     as _SupplierAccountGroupText on $projection.SupplierAccountGroup = _SupplierAccountGroupText.SupplierAccountGroup
  association [0..*] to /SIMPLE/I_SupplierIndustryText as _SupplierIndustryText     on $projection.Industry = _SupplierIndustryText.SupplierIndustry
  ////public foreign key associations

  //quality management
  association [0..1] to /SIMPLE/I_ProcurementBlock    as _ProcurementBlock         on $projection.SupplierProcurementBlock = _ProcurementBlock.ProcurementBlock
//  association [0..1] to /SIMPLE/I_QualityMngmntSystem as _QualityManagementSystem  on $projection.SuplrQualityManagementSystem = _QualityManagementSystem.QualityManagementSystem
  association [1..1] to /SIMPLE/I_Address             as _StandardAddress          on $projection.AddressID = _StandardAddress.AddressID

  association [0..1] to E_Supplier                    as _SupplierExt               on $projection.Supplier = _SupplierExt.Supplier


{

      @ObjectModel.text.element: 'SupplierName'
      @Consumption.labelElement: 'SupplierName'
  key cast(lfa1.lifnr as lifnr preserving type)                                                                   as Supplier,
      ktokk                                                                                                       as SupplierAccountGroup,
      @Semantics.text: true
      cast(substring(rtrim(replace(concat(name1, concat(' &@', name2)), '&@', ''),' '),1,80) as md_supplier_name) as SupplierName,
      cast(concat( concat( concat( concat( concat( concat_with_space( anred, name1, 1 ), name2 ), name3 ), name4 ), '/' ),
          concat_with_space( pstlz, ort01 , 1 ) )  as md_supplier_full_name)                                      as SupplierFullName,

      lfa1.cvp_xblck                                                                                              as IsBusinessPurposeCompleted,
      ernam                                                                                                       as CreatedByUser,
      erdat                                                                                                       as CreationDate,
      xcpdk                                                                                                       as IsOneTimeAccount,
      begru                                                                                                       as AuthorizationGroup,
      stceg                                                                                                       as VATRegistration,
      sperr                                                                                                       as AccountIsBlockedForPosting,
      txjcd                                                                                                       as TaxJurisdiction,
      konzs                                                                                                       as SupplierCorporateGroup, //to be used
      kunnr                                                                                                       as Customer,
      brsch                                                                                                       as Industry,   // siehe Anmerkung
      stcd1                                                                                                       as TaxNumber1, // tax number 1&2: siehe Anmerkung
      stcd2                                                                                                       as TaxNumber2,
      stcd3                                                                                                       as TaxNumber3,
      stcd4                                                                                                       as TaxNumber4,
      stcd5                                                                                                       as TaxNumber5,
      sperr                                                                                                       as PostingIsBlocked,
      sperm                                                                                                       as PurchasingIsBlocked,
      bbbnr                                                                                                       as InternationalLocationNumber1,
      bbsnr                                                                                                       as InternationalLocationNumber2,
      bubkz                                                                                                       as InternationalLocationNumber3,
      adrnr                                                                                                       as AddressID,
      lfa1.regio                                                                                                  as Region,
      lfa1.name1                                                                                                  as OrganizationBPName1,
      lfa1.name2                                                                                                  as OrganizationBPName2,
      lfa1.ort01                                                                                                  as CityName,
      lfa1.pstlz                                                                                                  as PostalCode,
      lfa1.stras                                                                                                  as StreetName,
      lfa1.land1                                                                                                  as Country,

      cast((concat(concat(bbbnr,concat(' & ', bbsnr)),concat(' & ',bubkz)))  as md_international_loc )            as ConcatenatedInternationalLocNo,

      //quality management
      sperq                                                                                                       as SupplierProcurementBlock,
      qssys                                                                                                       as SuplrQualityManagementSystem,
      qssysdat                                                                                                    as SuplrQltyInProcmtCertfnValidTo,
      //globalization
      lfa1.spras                                                                                                  as SupplierLanguage,
      lfa1.lnrza                                                                                                  as AlternativePayeeAccountNumber,
      lfa1.telf1                                                                                                  as PhoneNumber1,
      lfa1.telfx                                                                                                  as FaxNumber,
      lfa1.stkzn                                                                                                  as IsNaturalPerson,
      lfa1.stenr                                                                                                  as TaxNumberResponsible,
      lfa1.categ                                                                                                  as UK_ContractorBusinessType,
      lfa1.partner_name                                                                                           as UK_PartnerTradingName,
      lfa1.partner_utr                                                                                            as UK_PartnerTaxReference,
      lfa1.status                                                                                                 as UK_VerificationStatus,
      lfa1.vfnum                                                                                                  as UK_VerificationNumber,
      lfa1.crn                                                                                                    as UK_CompanyRegistrationNumber,
      lfa1.vfnid                                                                                                  as UK_VerifiedTaxStatus,

      lfa1.anred                                                                                                  as  FormOfAddress,
      lfa1.ktock                                                                                                  as  ReferenceAccountGroup,
      lfa1.stkzu                                                                                                  as  VATLiability,

      //GS
      lfa1.fityp                                                                                                  as ResponsibleType,
      lfa1.stcdt                                                                                                  as TaxNumberType,
      lfa1.fiskn                                                                                                  as FiscalAddress,
      lfa1.j_1kftbus                                                                                              as BusinessType,

      lfa1.gbdat                                                                                                  as BirthDate,

      lfa1.sperz                                                                                                  as PaymentIsBlockedForSupplier,
      lfa1.sortl                                                                                                  as SortField,
      lfa1.telf2                                                                                                  as PhoneNumber2,
      lfa1.loevm                                                                                                  as DeletionIndicator,
      lfa1.vbund                                                                                                  as TradingPartner,

      //GS FIN
      j_1kfrepre                                                                                                  as TaxInvoiceRepresentativeName,
      j_1kftind                                                                                                   as IndustryType,
      lfa1.ven_class                                                                                              as IN_GSTSupplierClassification,

      //Add Missing Fields 200805
      
      revdb                                                                                                       as LastExternalReview,             
      fisku                                                                                                       as AccNoOfMasterRecOfTaxOfficeRes,        
      term_li                                                                                                     as TermsOfLiability,               
      min_comp                                                                                                    as MicroCompanyIndicator,          
      comsize                                                                                                     as CompanySize,                    
      decregpc                                                                                                    as DeclarationRegimenForPisCofins, 
      crc_num                                                                                                     as CrcNumber,                      
      rg                                                                                                          as RgNumber,                       
      exp                                                                                                         as IssuedBy,                       
      uf                                                                                                          as State,                          
      rgdate                                                                                                      as RgIssuingDate,                  
      ric                                                                                                         as RicNumber,                      
      rne                                                                                                         as ForeignNationalRegistration,    
      rnedate                                                                                                     as RneIssuingDate,                 
      cnae                                                                                                        as Cnae,                           
      legalnat                                                                                                    as LegalNature,                    
      crtn                                                                                                        as CrtNumber,                      
      icmstaxpay                                                                                                  as IcmsTaxpayer,                   
      indtyp                                                                                                      as IndustryMainType,               
      tdt                                                                                                         as TaxDeclarationType,           
      ltsna                                                                                                       as SupplierSubRangeRelevantInd,
      werkr                                                                                                       as IndicatorPlantLevelRelevant,
      plkal                                                                                                       as FactoryCalendarKey,
      borgr_yeaun                                                                                                 as AnnualRepetitionOfDateLimit,
      borgr_datun                                                                                                 as DateLimitForExternalDocID,
      bahns                                                                                                       as TrainStation,
      dtams                                                                                                       as ReportKeyForDataMediumExchange,
      dtaws                                                                                                       as InstructionKeyForDataMedEx,
      xzemp                                                                                                       as AlternativePayeeInDocAllowed,
      esrnr                                                                                                       as IsrSubscriberNumber,
      regss                                                                                                       as RegisteredForSocialInsurance,
      actss                                                                                                       as ActivityCodeForSocialInsurance,
      scacd                                                                                                       as StandardCarrierAccessCode,
      dlgrp                                                                                                       as ServiceAgentProcedureGroup,
      sfrgr                                                                                                       as ForwardingAgentFreightGroup,
      profs                                                                                                       as Profession,
      stgdl                                                                                                       as ShipmentStatsGrpTransSrvAgent,
      emnfr                                                                                                       as ExtManufacturerCodeNameOrNum,
      podkzb                                                                                                      as SupIndRelevantForProofOfDlv,
      carrier_conf                                                                                                as CarrierConfirmationIsExpected,
      nodel                                                                                                       as CentralDelBlockForMasterRecord,
      xlfza                                                                                                       as AlternativePayeeUsingAccNum,
      taxbs                                                                                                       as TaxBaseInPercentage,
      ipisp                                                                                                       as TaxSplit,
      stkza                                                                                                       as BPSubjectToEqualizationTax,
      kraus                                                                                                       as CreditInformationNumber,
      lfa1.werks                                                                                                  as Plant,     // additional Plant field - 2021.11.12
//      _SupplierCompany,
      _SupplierPurchasingOrg,
      _SupplierBankDetails,
      _SupplierAccountGroup,
//      _SupplierAccountGroupText, // OBSOLETE to be deleted
      _SupplierIndustryText, // OBSOLETE to be deleted

      _Industry,
      _StandardAddress,
   // _Address removed, use _StandardAddress instead
      _CorrespondingCustomer,
//      _cvi                                                                                                        as _SupplierToBusinessPartner,
      //quality management
      _ProcurementBlock
//      _QualityManagementSystem
}
























