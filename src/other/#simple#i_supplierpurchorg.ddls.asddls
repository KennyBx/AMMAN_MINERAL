@EndUserText.label: 'SupplierPurchasingOrganization' //same as DDL description
@Analytics.dataCategory: #FACT //or #CUBE or #FACT
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@AbapCatalog.sqlViewName: '/SIMPLE/ISUPPO' //must start with "I"
@ClientHandling.algorithm : #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER
@AccessControl.personalData.blocking: #REQUIRED
@ObjectModel.representativeKey: 'PurchasingOrganization'
@Metadata.ignorePropagatedAnnotations: true
define view /SIMPLE/I_SupplierPurchOrg //must start with "I_"; same as DDL source name in upper-camelcase notation
  as select from lfm1
  //Directly Selecting fields from Table instead of V_MD_SUPPLIER_PURCHASING view
  //---> Decomment if you want to join further data sources
  //left outer to one join DatabaseTableOrBasicCdsView2 //recommendation: use addition "to one" or "to many"
  //   on V_MD_SUPPLIER_PURCHASING.FieldName = DatabaseTableOrBasicCdsView2.FieldName2
  //---> Decomment if you want to introduce an association
  //association [0..1] to I_TargetPublicBasicViewNameWithoutPrefix as _TargetPublicBasicViewNameWithoutPrefix
  //   on $projection.SourceFieldName = _TargetPublicBasicViewNameWithoutPrefix.TargetFieldName
  //  association [0..1] to /SIMPLE/I_IncotermsClassif as _IncotermsClassification on $projection.IncotermsClassification = _IncotermsClassification.IncotermsClassification

  association [1..1] to /SIMPLE/I_Supplier as _Supplier on $projection.Supplier = _Supplier.Supplier
{
      //key cast (DatabaseFieldName as DataElementWithProperLabel) as GlobalFieldName,
      //      //--[ GENERATED:012:GlBfhyJl7kY4i6}7dD1KRG
      //      @Consumption.valueHelpDefinition: [
      //        { entity:  { name:    'I_Supplier_VH',
      //                     element: 'Supplier' }
      //        }]
      //      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_Supplier'
  key lifnr          as Supplier,
      // @ObjectModel.text.element: 'PurchasingOrganizationName'
  key ekorg          as PurchasingOrganization,
      //    SupplierName1,
      //    SupplierName2,
      //    PurchasingGroupName,
      // PurchasingOrganizationName, Commented as a part of whitelisting development
      //    PurchasingBlock,
      //    SupplierRespSalesPersonName,
      //    SupplierPhoneNumber,
      ekgrp          as PurchasingGroup,
      plifz          as MaterialPlannedDeliveryDurn,
      sperm          as PurchasingIsBlockedForSupplier,
      verkf          as SupplierRespSalesPersonName,
      telf1          as SupplierPhoneNumber,
      waers          as PurchaseOrderCurrency,
      @Semantics.amount.currencyCode: 'PurchaseOrderCurrency'
      minbw          as MinimumOrderAmount,
      kalsk          as CalculationSchemaGroupCode,
      zterm          as PaymentTerms,
      meprf          as PricingDateControl,
      lfabc          as SupplierABCClassificationCode,
      vsbed          as ShippingCondition,
      kzaut          as PurOrdAutoGenerationIsAllowed,
      webre          as InvoiceIsGoodsReceiptBased,


      inco1          as IncotermsClassification,
      inco2          as IncotermsTransferLocation,
      incov          as IncotermsVersion,
      inco2_l        as IncotermsLocation1,
      inco3_l        as IncotermsLocation2,



      loevm          as DeletionIndicator,
      plifz          as PlannedDeliveryDurationInDays,
      telf1          as ContactPersonPhoneNumber,

      // Add Missing Fields 200805
      eikto          as OurAccountNumWithTheSupplier,
      nrgew          as WhetherDiscountInKindGranted,
      paprf          as ProfileTransMatDataViaIdoc,
      lebre          as ForSrvBasedInvoiceVerification,
      bolre          as SupplierSubjectToSubseq,
      umsae          as ComparisonAgreementOfBizVolume,
      xnbwy          as RevaluationAllowed,
      vendor_rma_req as SupplierRmaNumberRequired,
      prfre          as RelevToPriceDetermination,
      boind          as IndexCompilationForSubseq,
      blind          as DocIndexCompilationActiveForPO,
      xersr          as AutoEvaluatedRcptForRetItems,
      kzabs          as OrderAcknowledgmentRequirement,
      expvz          as ModeOfTransportAtTheBorder,
      megru          as UnitOfMeasureGroup,
      rdprf          as RoundingProfile,
      agrel          as RelevantForSettlementManagemnt,
      skrit          as SupSortCriterionForMaterials,
      bstae          as ConfirmationControlKey,
      kzret          as IndicateWhetherSupIsReturnsSup,
      xersy          as EvaluatedReceiptSettlement,
      mrppp          as PlanningCalendar,
      lfrhy          as PlanningCycle,
      bopnr          as RestrictionPoBasedLoadBuilding,
      zolla          as OfficeOfExitEntry4ForeignTrade,
      libes          as OrderEntryBySupplier,
      lipre          as PriceMarkingSupplier,
      liser          as RackJobbingSupplier,
      vensl          as SupplierServiceLevel,
      //    InvoiceIsGoodsReceiptBased,
      //    CalculationSchemaGroupCode,
      //    POAutomaticGenerationIsAllowed,
      //    PricingDateControl,
      //    MaterialPlannedDeliveryDurn,
      //    ShippingCondition,
      //    ETag,
      //
      //    /* Associations */
      //    CalcSchemaGroupText,
      //    CurrencyText,
      //    ShippingConditionText,

      //Begin of Ins by Danh Tran 20230809 - LD-0050
      telf1          as SupplierTelephoneNumber,
      //End of Ins by Danh Tran 20230809 - LD-0050
      //No usage hence commenting and adding
      //    V_MD_SUPPLIER_PURCHASING.IncotermsText as _IncotermsText,
      //  _PaymentTermsText,       Removed as a Part of Whitelisting
      //      _IncotermsClassification,
      _Supplier.AuthorizationGroup,
      _Supplier.SupplierAccountGroup,
      _Supplier

      //_TargetPublicBasicViewNameWithoutPrefix //expose the association for use by consumers

}
