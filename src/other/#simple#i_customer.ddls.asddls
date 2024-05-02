@ObjectModel.representativeKey: 'Customer'
@EndUserText.label: 'Customer'
@Analytics : {dataCategory: #DIMENSION, dataExtraction.enabled : true}
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@AccessControl.personalData.blockingIndicator: 'IsBusinessPurposeCompleted'
@AbapCatalog.sqlViewName: '/SIMPLE/ICUST'
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.privilegedAssociations:  [ '_StandardAddress' ]
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.dataClass: #MASTER
@Metadata.allowExtensions: true
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_Customer
  as select from kna1
//  association [1..1] to /SIMPLE/I_CusToBP           as _cvi                    on $projection.Customer = _cvi.Customer
  association [0..1] to /SIMPLE/I_Supplier          as _CorrespondingSupplier  on _CorrespondingSupplier.Supplier = $projection.Supplier
  //  association [0..*] to /SIMPLE/I_CusAccountGroupText    as _CustomerAccountGroupText on $projection.CustomerAccountGroup = _CustomerAccountGroupText.CustomerAccountGroup
//  association [0..1] to /SIMPLE/I_CusClassification as _CustomerClassification on $projection.CustomerClassification = _CustomerClassification.CustomerClassification
  association [1..*] to /SIMPLE/I_CustomerCompany   as _CustomerCompany        on $projection.Customer = _CustomerCompany.Customer
  association [1..*] to /SIMPLE/I_CustomerSalesArea as _CustomerSalesArea      on $projection.Customer = _CustomerSalesArea.Customer
  association [1..1] to /SIMPLE/I_User              as _CreatedByUser          on $projection.CreatedByUser = _CreatedByUser.UserID
  association [1..1] to /SIMPLE/I_Address           as _StandardAddress        on $projection.AddressID = _StandardAddress.AddressID

  //Requirement from GS FIN
//  association [1..*] to /SIMPLE/I_CustSalesAreaTax  as _CustomerSalesAreaTax   on $projection.Customer = _CustomerSalesAreaTax.Customer

  association [0..1] to E_Customer                  as _CustomerExt            on $projection.Customer = _CustomerExt.Customer

{
      //Key
      @ObjectModel.text.element: ['CustomerName']
  key cast(kna1.kunnr as kunnr preserving type)                                                                   as Customer,
      //@VDM.deprecated:true
      //Please use from association as _CustomerToBusinessPartner._BusinessPartner.BusinessPartner instead
      //_cvi._BusinessPartner.BusinessPartner,
      //@VDM.deprecated:true
      //Please use from association as _CustomerToBusinessPartner.BusinessPartnerUUID instead
      //_cvi.BusinessPartnerUUID, //intended to remain private, but required for association _cvi._BusinessPartner
      @Semantics.text:true
      cast(substring(rtrim(replace(concat(name1, concat(' &@', name2)), '&@', ''),' '),1,80) as md_customer_name) as CustomerName,



      cast(concat( concat( concat( concat( concat( concat_with_space( anred, name1, 1 ), name2 ), name3 ), name4 ), '/' ),
              concat_with_space(pstlz, ort01, 1 ) ) as md_customer_full_name)                                     as CustomerFullName, //KF: different with S4

      //admin
      kna1.ernam                                                                                                  as CreatedByUser,
      kna1.erdat                                                                                                  as CreationDate,
      kna1.adrnr                                                                                                  as AddressID,

      @ObjectModel.foreignKey.association:'_CustomerClassification'
      kna1.kukla                                                                                                  as CustomerClassification,
      kna1.stceg                                                                                                  as VATRegistration,
      kna1.ktokd                                                                                                  as CustomerAccountGroup,
      kna1.begru                                                                                                  as AuthorizationGroup,
      kna1.lifsd                                                                                                  as DeliveryIsBlocked,
      kna1.sperr                                                                                                  as PostingIsBlocked,
      kna1.faksd                                                                                                  as BillingIsBlockedForCustomer, // Used in CDS based Customer Object Page
      kna1.aufsd                                                                                                  as OrderIsBlockedForCustomer, //Used in CDS based Customer Object Page
      kna1.bbbnr                                                                                                  as InternationalLocationNumber1, //Used in CDS based Customer Object Page
      kna1.xcpdk                                                                                                  as IsOneTimeAccount,
      kna1.txjcd                                                                                                  as TaxJurisdiction,
      kna1.brsch                                                                                                  as Industry,
      kna1.stcdt                                                                                                  as TaxNumberType,
      kna1.stcd1                                                                                                  as TaxNumber1, // same as kna1.stcd1 ?
      kna1.stcd2                                                                                                  as TaxNumber2, // same as kna1.stcd2 ?
      kna1.stcd3                                                                                                  as TaxNumber3,
      kna1.stcd4                                                                                                  as TaxNumber4,
      kna1.stcd5                                                                                                  as TaxNumber5,
      kna1.konzs                                                                                                  as CustomerCorporateGroup,
      kna1.lifnr                                                                                                  as Supplier,

      kna1.niels                                                                                                  as NielsenRegion,
      kna1.bran1                                                                                                  as IndustryCode1,
      kna1.bran2                                                                                                  as IndustryCode2,
      kna1.bran3                                                                                                  as IndustryCode3,
      kna1.bran4                                                                                                  as IndustryCode4,
      kna1.bran5                                                                                                  as IndustryCode5,

      kna1.land1                                                                                                  as Country,
      kna1.name1                                                                                                  as OrganizationBPName1,
      kna1.name2                                                                                                  as OrganizationBPName2,
      kna1.ort01                                                                                                  as CityName,
      kna1.pstlz                                                                                                  as PostalCode,
      kna1.stras                                                                                                  as StreetName,
      kna1.sortl                                                                                                  as SortField,
      kna1.telfx                                                                                                  as FaxNumber,
      kna1.suframa                                                                                                as BR_SUFRAMACode,
      kna1.regio                                                                                                  as Region,

      kna1.telf1                                                                                                  as TelephoneNumber1,
      kna1.telf2                                                                                                  as TelephoneNumber2,
      kna1.knrza                                                                                                  as AlternativePayerAccount,
      kna1.dtams                                                                                                  as DataMediumExchangeIndicator,
      kna1.stkzu                                                                                                  as VATLiability,

      //for Fiori app (F1993) Customer Summary Report as a part of  DPP (Data Protection & Privacy)
      kna1.cvp_xblck                                                                                              as IsBusinessPurposeCompleted,

      //gs
      kna1.fityp                                                                                                  as ResponsibleType,
      kna1.fiskn                                                                                                  as FiscalAddress,
      kna1.stkzn                                                                                                  as NFPartnerIsNaturalPerson,
      kna1.loevm                                                                                                  as DeletionIndicator,
      kna1.spras                                                                                                  as Language,
      kna1.vbund                                                                                                  as TradingPartner,

      //Add missing fields 200804
      kna1.bahne                                                                                                  as ExpressTrainStation,
      kna1.bahns                                                                                                  as TrainStation,
      kna1.locco                                                                                                  as CityCoordinates,
      kna1.umsa1                                                                                                  as AnnualSales,
      kna1.uwaer                                                                                                  as CurrencyOfSalesFigure,
      kna1.umjah                                                                                                  as YearForWhichSalesAreGiven,
      kna1.werks                                                                                                  as Plant,
      kna1.xzemp                                                                                                  as IsAnAltPayerAllowedInDoc,
      kna1.periv                                                                                                  as FiscalYearVariant,
      kna1.dear1                                                                                                  as IndicatorCompetitor,
      kna1.dear2                                                                                                  as IndicatorSalesPartner,
      kna1.dear3                                                                                                  as IndicatorSalesProspect,
      kna1.dear5                                                                                                  as IDForDefaultSoldToParty,
      kna1.dear6                                                                                                  as IndicatorConsumer,
      kna1.nodel                                                                                                  as DeletionBlockForMasterRecord,
      kna1.stkza                                                                                                  as BPSubjectToEqualizationTax,
      kna1.counc                                                                                                  as CountyCode,
      kna1.cityc                                                                                                  as CityCode,
      kna1.rg                                                                                                     as RGNumber,
      kna1.exp                                                                                                    as IssuedBy,
      kna1.uf                                                                                                     as State,
      kna1.rgdate                                                                                                 as RGIssuingDate,
      kna1.ric                                                                                                    as RICNumbeEF42,
      kna1.rne                                                                                                    as ForeignNationalRegistration,
      kna1.rnedate                                                                                                as RNEIssuingDate,
      kna1.cnae                                                                                                   as CNAE,
      kna1.legalnat                                                                                               as LegalNature,
      kna1.crtn                                                                                                   as CRTNumber,
      kna1.icmstaxpay                                                                                             as ICMSTaxpayer,
      kna1.indtyp                                                                                                 as IndustryMainType,
      kna1.tdt                                                                                                    as TaxDeclarationType,
      kna1.comsize                                                                                                as CompanySize,
      kna1.decregpc                                                                                               as DeclarationRegimen,
      kna1.katr1                                                                                                  as Attribute1,
      kna1.katr2                                                                                                  as Attribute2,
      kna1.katr3                                                                                                  as Attribute3,
      kna1.katr4                                                                                                  as Attribute4,
      kna1.katr5                                                                                                  as Attribute5,
      kna1.katr6                                                                                                  as Attribute6,
      kna1.katr7                                                                                                  as Attribute7,
      kna1.katr8                                                                                                  as Attribute8,
      kna1.katr9                                                                                                  as Attribute9,
      kna1.katr10                                                                                                 as Attribute10,
      kna1.kdkg1                                                                                                  as CustomerConditionGroup1,
      kna1.kdkg2                                                                                                  as CustomerConditionGroup2,
      kna1.kdkg3                                                                                                  as CustomerConditionGroup3,
      kna1.kdkg4                                                                                                  as CustomerConditionGroup4,
      kna1.kdkg5                                                                                                  as CustomerConditionGroup5,
      kna1.cassd                                                                                                  as BlockSalesSupport,
      kna1.rpmkr                                                                                                  as RegionalMarket,
      //GS FIN
      j_1kfrepre                                                                                                  as TaxInvoiceRepresentativeName,
      j_1kftbus                                                                                                   as BusinessType,
      j_1kftind                                                                                                   as IndustryType,
      //associations
//      _cvi                                                                                                        as _CustomerToBusinessPartner,
      _StandardAddress,
      _CreatedByUser,
      _CorrespondingSupplier,
//      _CustomerClassification,
      //      _CustomerAccountGroupText,
      _CustomerCompany,
      _CustomerSalesArea
//      _CustomerSalesAreaTax
}
