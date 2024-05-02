@EndUserText.label: 'Supplier Company'
@Analytics.dataCategory: #FACT //or #CUBE or #FACT
@VDM.viewType: #BASIC
//@Search.searchable: true
@ClientHandling.algorithm : #SESSION_VARIABLE
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #REQUIRED
@AbapCatalog.sqlViewName: '/SIMPLE/ISUPCPN'
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.representativeKey:'CompanyCode'
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_SupplierCompany
  as select from lfb1

  association [1..1] to /SIMPLE/I_Supplier    as _Supplier    on $projection.Supplier = _Supplier.Supplier

  association [0..1] to /SIMPLE/I_CompanyCode as _CompanyCode on $projection.CompanyCode = _CompanyCode.CompanyCode

  //  association [0..1] to /SIMPLE/I_PmntBlockingReason   as _PaymentBlockingReason     on  $projection.PaymentBlockingReason = _PaymentBlockingReason.PaymentBlockingReason

  //  association [0..1] to /SIMPLE/I_ToleranceGroupText   as _APARToleranceGroupName    on  $projection.CompanyCode          = _APARToleranceGroupName.CompanyCode
  //                                                                                     and _APARToleranceGroupName.Language = $session.system_language
  //                                                                                     and $projection.APARToleranceGroup   = _APARToleranceGroupName.APARToleranceGroup

  //  association [0..*] to /SIMPLE/I_PaymentTermsText     as _PaymentTermsText          on  $projection.PaymentTerms = _PaymentTermsText.PaymentTerms

  //  association [0..*] to /SIMPLE/I_PmntBlckngReasonText as _PaymentBlockingReasonText on  $projection.PaymentTerms = _PaymentBlockingReasonText.PaymentBlockingReason

  //  association [0..*] to /SIMPLE/I_Bpwhldgtax           as _WithholdingTax            on  $projection.Supplier    = _WithholdingTax.Supplier
  //                                                                                     and $projection.CompanyCode = _WithholdingTax.CompanyCode
{

      //      //--[ GENERATED:012:GlBfhyJl7kY4i6}7dD1KRG
      //      @Consumption.valueHelpDefinition: [
      //        { entity:  { name:    'I_Supplier_VH',
      //                     element: 'Supplier' }
      //        }]
      //      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_Supplier'
  key lifnr                        as Supplier,
      //      //--[ GENERATED:012:GlBfhyJl7kY4i6}7dD1KRG
      //      @Consumption.valueHelpDefinition: [
      //        { entity:  { name:    'I_CompanyCodeStdVH',
      //                     element: 'CompanyCode' }
      //        }]
      //      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_CompanyCode'
  key bukrs                        as CompanyCode,
      begru                        as AuthorizationGroup,
      //V_MD_SUPPLIER_COMPANY.SupplierName1,
      //V_MD_SUPPLIER_COMPANY.SupplierName2,
      @VDM.deprecated: true    //Use _Companycode to expose the feild
      @Consumption.hidden: true
      _CompanyCode.CompanyCodeName as CompanyCodeName,
      //  V_MD_SUPPLIER_COMPANY.CompanyCodeName             as CompanyCodeName,
      zahls                        as PaymentBlockingReason,
      sperr                        as SupplierIsBlockedForPosting,
      cvp_xblck_b                  as IsBusinessPurposeCompleted,
      //V_MD_SUPPLIER_COMPANY.PeriodicAccountStatement,
      busab                        as AccountingClerk,
      //V_MD_SUPPLIER_COMPANY.AccountingClerkName         as AccountingClerkName,  //To be removed as a Part of Whitelisting
      tlfxs                        as AccountingClerkFaxNumber,
      tlfns                        as AccountingClerkPhoneNumber,
      intad                        as AccountingClerkInternetAddress,
      zsabe                        as SupplierClerk,
      intad                        as SupplierClerkURL,
      zwels                        as PaymentMethodsList,
      //V_MD_SUPPLIER_COMPANY.PaymentMethodName,
      zterm                        as PaymentTerms,
      xverr                        as ClearCustomerSupplier,
      //V_MD_SUPPLIER_COMPANY.IsToBeCheckedForDuplicates,
      xdezv                        as IsToBeLocallyProcessed,
      xpore                        as ItemIsToBePaidSeparately,
      xedip                        as PaymentIsToBeSentByEDI,
      //V_MD_SUPPLIER_COMPANY.MinorityGroup,
      hbkid                        as HouseBank,
      //V_MD_SUPPLIER_COMPANY.HouseBankName,  //To be removed as a Part of Whitelisting
      kultg                        as CheckPaidDurationInDays,
      webtr                        as BillOfExchLmtAmtInCoCodeCrcy,
      //V_MD_SUPPLIER_COMPANY.CompanyCodeCurrency,
      eikto                        as SupplierClerkIDBySupplier,
      reprf                        as IsDoubleInvoice,
      xverr                        as CustomerSupplierClearingIsUsed,
      akont                        as ReconciliationAccount,
      vzskz                        as InterestCalculationCode,
      zindt                        as InterestCalculationDate,
      zinrt                        as IntrstCalcFrequencyInMonths,

      //V_MD_SUPPLIER_COMPANY.Dummy,
      //V_MD_SUPPLIER_COMPANY.HeadOfficeAccount           as HeadOfficeAccount,  //to be removed
      lnrze                        as SupplierHeadOffice,
      //V_MD_SUPPLIER_COMPANY.HeadOfficeAccountName       as HeadOfficeName,  // To be removed as a Part of Whitelisting
      lnrzb                        as AlternativePayee,
      //V_MD_SUPPLIER_COMPANY.AlternativePayeeName        as AlternativePayeeName, // To be removed as a Part of Whitelisting
      zuawa                        as LayoutSortingRule,
      //V_MD_SUPPLIER_COMPANY.PlanningGroupOfCashMangement,
      //V_MD_SUPPLIER_COMPANY.ToleranceGroup              as ToleranceGroup,     //to be removed
      togru                        as APARToleranceGroup, //to be used
      cerdt                        as SupplierCertificationDate,
      //V_MD_SUPPLIER_COMPANY.AccountMemo as AccountMemo,               //to be removed
      kverm                        as SupplierAccountNote, //to be used
      qland                        as WithholdingTaxCountry,

      loevm                        as DeletionIndicator, // loevm
      fdgrv                        as CashPlanningGroup, //fdgrv
      reprf                        as IsToBeCheckedForDuplicates, //reprf

      pernr                        as PersonnelNumber,
      altkn                        as PreviousAccountNumber,

      // Add Missing Fields 200805
      frgrp                        as ReleaseApprovalGroup,
      mindk                        as MinorityIndicator,
      datlz                        as DateOfLastInterestCalRun,
      qsskz                        as WithholdingTaxCode,
      qsrec                        as SupplierRecipientType,
      qsznr                        as CertNumOfTheWHTaxExemption,
      qszdt                        as ValidityDateForWHTaxExemptCert,
      qsbgr                        as AuthorityForExemptionFromWHTax,
      avsnd                        as IndicatorSendPmntAdviceByXml,
      togrr                        as TolGrpInInvoiceVerification,
      prepay_relevant              as PrepaymentRelevance,
      nodel                        as DeletionBlock,
      mgrup                        as KeyforDunningNoticeGrouping,

      //Insert - Kent: Add necessary field 16/03/2022
      zgrup                        as KeyForPaymentGrouping,
      //Insert - Danh Tran: Accts for Alt. Payee 14/07/2022
      xlfzb                        as AltPayeeDoc,

      //Begin of Ins by Danh Tran 20230809 - LD-0050 
      us_rec_country               as RecipientCountryRegion,
      us_giin                      as RecipientGIIN,
      us_ftid                      as RecipientForeignTaxID,
      us_w8_recvdate               as W8FormReceivedDate,
      us_w9_recvdate               as W9FormReceivedDate,
      us_tin_notice                as SecondTINNotice, 
      //End of Ins by Danh Tran 20230809 - LD-0050
      //V_MD_SUPPLIER_COMPANY.ETag,
      /* Associations */
      //V_MD_SUPPLIER_COMPANY._LayoutSortingRuleName,
      //V_MD_SUPPLIER_COMPANY._MinorityGroupText,
      //      _PaymentBlockingReason,
      //      _PaymentBlockingReasonText,
      //V_MD_SUPPLIER_COMPANY._PaymentMethod,
      //V_MD_SUPPLIER_COMPANY._PaymentTermsText as PaymentTermsText,    //to be removed
      //      _PaymentTermsText, //to be used
      //V_MD_SUPPLIER_COMPANY._PeriodicAccountStatementText,
      //V_MD_SUPPLIER_COMPANY._PlanningGroupOfCashMgntName,
      //V_MD_SUPPLIER_COMPANY._ReconciliationAccountName,
      //V_MD_SUPPLIER_COMPANY._ToleranceGroupName,                                    //to be removed
      //      _APARToleranceGroupName, //to be used
      //      _WithholdingTax,
      //key cast (DatabaseFieldName as DataElementWithProperLabel) as GlobalFieldName,
      //_TargetPublicBasicViewNameWithoutPrefix //expose the association for use by consumers
      _CompanyCode,
      _Supplier
}
