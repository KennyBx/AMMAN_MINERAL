@AbapCatalog.sqlViewName: '/SIMPLE/ISLI'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Source List Item Basic View'
@VDM.viewType: #BASIC
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #MASTER
@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API

define view /SIMPLE/I_SourceListItem
  as select from eord
  association [0..1] to I_Supplier                 as _Supplier                 on  $projection.Supplier = _Supplier.Supplier
{
  key matnr                           as Material,
  key werks                           as Plant,
  key zeord                           as SourceListRecord,
      erdat                           as CreationDate,
      ernam                           as CreatedByUserName,
      vdatu                           as ValidityStartDate,
      bdatu                           as ValidityEndDate,
      lifnr                           as Supplier,
      flifn                           as SupplierIsFixed,
      ebeln                           as PurchaseOutlineAgreement,
      ebelp                           as PurchaseOutlineAgreementItem,
      febel                           as PurOutlineAgreementIsFixed,
      reswk                           as SupplyingPlant,

      fresw                           as IssgPlantIsFixed,

      ematn                           as ManufacturerMaterial,

      notkz                           as SourceOfSupplyIsBlocked,
      cast( case
      when  ( fresw = 'X' or
               febel  = 'X' or
               flifn  = 'X' )
            then 'X'
            else ' '
       end as feskz preserving type ) as SourceOfSupplyIsFixed,
            cast( '' as sl_status )    as SourceListStatus,
      ekorg                           as PurchasingOrganization,
      vrtyp                           as PurchasingDocumentCategory,
      eortp                           as SourceListRecordCategory,
      autet                           as MRPSourcingControl,
      cast('' as abap.char(10) )      as MRPArea,
      meins                           as OrderQuantityUnit,
      logsy                           as OriginSystem,
      sobkz                           as InventorySpecialStockType,
      lastchangedatetime              as LastChangeDateTime

}
//where
//     _Supplier.IsBusinessPurposeCompleted = ''
//  or _Supplier.IsBusinessPurposeCompleted is null
