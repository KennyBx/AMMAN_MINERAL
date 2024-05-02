@AbapCatalog.sqlViewName: '/SIMPLE/IFLOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Functional Location'
define view /SIMPLE/I_FUNCTIONALLOCATION
  as select distinct from iflo
    left outer join       t001w on t001w.werks = iflo.swerk
    left outer join       t001k on t001k.bwkey = t001w.bwkey
    left outer join       tka02 on tka02.bukrs = t001k.bukrs
    left outer join       crhd  on crhd.objid = iflo.lgwid
{
      //General data
  key cast( iflo.tplnr as /simple/tplnr preserving type ) as FunctionalLocation,
      iflo.tplkz                                          as StructureIndicator,
      iflo.fltyp                                          as FunctionalLocationCategory,
      cast( '' as abap.char( 1 ) )                        as LabelingSystem,
      //      cast( '' as abap.char( 2 ) ) as Language,
      //      cast( '' as abap.char( 1 ) ) as DeletionFlag,
      cast( iflo.tplma as /simple/tplnr preserving type ) as SupLoc,
      iflo.trpnr                                          as RefLoc,
      iflo.objnr                                          as ObjectNumber,
      iflo.adrnr                                          as AddressNumber,
      iflo.iloan                                          as LocAcctAssignment,
      //      equnr as Equipment,
      //      datbi as ValidTo,
      //      eqlfn as ConsecNumber,
      //      shtxt as Description,
      iflo.pltxt                                          as Description,
      iflo.eqart                                          as ObjectType,
      iflo.invnr                                          as InventoryNumber,

      @Semantics.quantity.unitOfMeasure: 'UnitOfWeight'
      iflo.brgew                                          as WeightOfObject,
      @Semantics.unitOfMeasure: true
      iflo.gewei                                          as UnitOfWeight,
      //Weight Unit ( ISO format )
      iflo.groes                                          as SizeAndDimension,
      //      inbdt as StartUpDate,
      iflo.datab                                          as StartUpDate,
      iflo.begru                                          as AuthorizationGroup,
      iflo.ansdt                                          as AcquisitionDate,

      @Semantics.amount.currencyCode: 'CurrencyKey'
      cast( iflo.answt as abap.curr(16,2) )               as AcquisitionValue,
      @Semantics.currencyCode: true
      iflo.waers                                          as CurrencyKey,
      //Manufacturer Data
      iflo.herst                                          as ManufacturerOfAsset,
      iflo.herld                                          as CountryOfManufacture,
      iflo.typbz                                          as ManufacturerModelNumber,
      cast( iflo.baujj as abap.char( 4 ) )                as ConstructionYear,
      iflo.baumm                                          as ConstructionMonth,
      iflo.mapar                                          as ManufPartNumber,
      iflo.serge                                          as ManufSerialNumber,
      //Location
      iflo.swerk                                          as MaintenancePlant,
      iflo.stort                                          as MaintenanceLocation,
      iflo.msgrp                                          as Room,
      iflo.beber                                          as PlantSection,
      iflo.ppsid                                          as WorkCenter,
      iflo.abckz                                          as ABCIndicator,
      iflo.eqfnr                                          as SortField,
      tka02.kokrs                                         as ControllingArea,
      //Organizational Data
      iflo.bukrs                                          as CompanyCode,
      iflo.gsber                                          as BusinessArea,
      iflo.iwerk                                          as PlanningPlan,
      cast( crhd.werks as wergw preserving type )         as Plant,
      cast( '        ' as gewrk preserving type )         as PpWorkCenter,
      cast( '        ' as gewrk preserving type )         as MainWorkCenter,
      cast( '    ' as wergw preserving type )             as MainWorkCenterPlant,
      //      cast( '' as abap.numc( 8 )) as WoCenter,
      iflo.lgwid                                          as WoCenter,
      iflo.anlnr                                          as MainAsset,
      iflo.anlun                                          as SubAsset,
      iflo.kostl                                          as CostCenter,
      iflo.proid                                          as WBSElement,
      iflo.daufn                                          as StandingOrder,
      iflo.aufnr                                          as SettlementOrder,
      iflo.ingrp                                          as PlannerGroup,
      iflo.rbnr                                           as CatalogProfile,
      //Structure
      iflo.posnr                                          as PositionObject,
      iflo.iequi                                          as InstallationAllowed,
      iflo.einzl                                          as SingleInstallation,
      iflo.submt                                          as ConstructionType
}
