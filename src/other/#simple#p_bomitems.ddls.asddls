@AbapCatalog.sqlViewName: '/SIMPLE/PITEMS'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #AUTOMATED
@VDM.private: true
@VDM.viewType: #BASIC
@AbapCatalog.compiler.compareFilter: true
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.lifecycle.contract.type: #NONE
--@EndUserText.label: 'Get Valid BOM items for BOM header'
define view /SIMPLE/P_BOMItems
  as select distinct from stpo           as stpo

    inner join            stas           as stas              on  stpo.stlty = stas.stlty
                                                              and stpo.stlnr = stas.stlnr
                                                              and stpo.stlkn = stas.stlkn
  //LD-0102 added Begin
    left outer join       stpo           as stpo_pre          on  stpo.stlty = stpo_pre.stlty
                                                              and stpo.stlnr = stpo_pre.stlnr
                                                              and stpo.stlkn = stpo_pre.vgknt
                                                              and stpo.stpoz = stpo_pre.vgpzl
    left outer join       I_ChangeMaster as changeMasterToPre on changeMasterToPre.ChangeNumber = stpo_pre.aennr
  //LD-0102 added End

    left outer join       I_ChangeMaster as changeMasterTo    on changeMasterTo.ChangeNumber = stpo.ecn_to
  //                                                             and stas.lkenz = ' '
  //  //Andy - Start new logic - M001 - 19102020
  //    left outer join       stas           as stas_del         on  stpo.stlty     = stas_del.stlty
  //                                                             and stpo.stlnr     = stas_del.stlnr
  //                                                             and stpo.stlkn     = stas_del.stlkn
  //                                                             and stas_del.lkenz = 'X'
  //  //Andy - End new logic - M001 - 19102020

    left outer join       /SIMPLE/I_Dost as ChildDocumentBOM  on  ChildDocumentBOM.DocNumber       = stpo.doknr
                                                              and ChildDocumentBOM.DocumentType    = stpo.dokar
                                                              and ChildDocumentBOM.DocumentVersion = stpo.dokvr
                                                              and ChildDocumentBOM.DocumentPart    = stpo.doktl

    left outer join       /SIMPLE/I_Mast as MaterialBOM       on  MaterialBOM.BillOfMaterial         = stpo.stlnr
                                                              and MaterialBOM.BillOfMaterialVariant  = stas.stlal
                                                              and MaterialBOM.BillOfMaterialCategory = stpo.stlty

    left outer join       /SIMPLE/I_Mast as ChildMaterialBOM  on  ChildMaterialBOM.Material               = stpo.idnrk
                                                              and ChildMaterialBOM.BillOfMaterialCategory = stpo.stlty
                                                              and ChildMaterialBOM.Plant                  = MaterialBOM.Plant

    left outer join       t460a          as t460a             on  t460a.werks = MaterialBOM.Plant
                                                              and t460a.sobsl = stpo.itsob
    left outer join       t414           as t414              on stpo.dspst = t414.dispo

    inner join            tcs03          as tcs03             on tcs03.agb29 = '29'
  --   association [1..1] to     P_Valid_Bomitems        as valid_items    on stpo.guidx = valid_items.BillOfMaterialItemUUID

{
  key stpo.stlty                                           as BillOfMaterialCategory,
  key cast( stpo.stlnr  as /simple/stnum preserving type ) as BillOfMaterial,
  key stas.stlal                                           as BillOfMaterialVariant,
  key stpo.stlkn                                           as BillOfMaterialItemNodeNumber,
      stpo.guidx                                           as BillOfMaterialItemUUID,
      stpo.stpoz                                           as BOMItemInternalChangeCount,
      stas.stvkn                                           as InheritedNodeNumberForBOMItem,
      stpo.stvkn_versn                                     as InheritedNodeNumberVersionBOM,
      stas.bom_versn                                       as BillOfMaterialVersion,
      --MNGUYEN03 change ValidityStartDate to STAS 29/09/2022
      //      @Semantics.businessDate.from: true
      //      stpo.datuv       as ValidityStartDate,
      @Semantics.businessDate.from: true
      stas.datuv                                           as ValidityStartDate,
      --MNGUYEN03 change ValidityStartDate to STAS 29/09/2022
      --      @ObjectModel.virtualElement : true
      --      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_CS_BOM_ATTR_DETERMINATION'

      --    case when ( stpo.valid_to = '00000000' and stpo.datuv <> '00000000' )
      --       then      valid_items.ValidityEndDate
      -- else                 -- end
      //      @Semantics.businessDate.to: true
      //      //Start change logic - M001 - 25012021
      //      case when stpo.valid_to != '00000000'
      //        then stpo.valid_to
      //        else cast( stas_del.datuv as datub preserving type )
      //        end            as ValidityEndDate,

      //LD-0102 added Begin
      @Semantics.businessDate.to: true
      case when changeMasterToPre.ChangeNumberValidFromDate != '00000000'
        then changeMasterToPre.ChangeNumberValidFromDate
        else cast( '99991231' as datub )
        end                                                as ValidityEndDate,
      //LD-0102 added End

      //      stpo.valid_to    as ValidityEndDate,
      //End change logic - M001 - 25012021
      stas.aennr                                           as ChangeNumberFrom,

      //LD-0102 added Begin
      //stas.aennr       as ChangeNumberTo,
      stpo_pre.aennr                                       as ChangeNumberTo,
      //LD-0102 added End

      //End change logic - M001 - 19102020
      //      @ObjectModel.readOnly: true
      stpo.andat                                           as BOMItemRecordCreationDate,
      //      @ObjectModel.readOnly: true
      stpo.annam                                           as BOMItemCreatedByUser,
      //      @ObjectModel.readOnly: true
      stpo.aedat                                           as BOMItemLastChangeDate,
      //      @ObjectModel.readOnly: true
      stpo.aenam                                           as BOMItemLastChangedByUser,
      stpo.idnrk                                           as BillOfMaterialComponent,
      stpo.postp                                           as BillOfMaterialItemCategory,
      cast( stpo.posnr as /simple/sposn )                  as BillOfMaterialItemNumber,
      @Semantics.unitOfMeasure: true
      stpo.meins                                           as BillOfMaterialItemUnit,
      @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
      stpo.menge                                           as BillOfMaterialItemQuantity,
      stpo.upskz                                           as IsSubItem,
      stpo.sortf                                           as SortString,
      stpo.sortf                                           as BOMItemSorter,
      stpo.fmeng                                           as FixedQuantity,
      stpo.ekgrp                                           as PurchasingGroup,
      @Semantics.currencyCode: true
      stpo.waers                                           as Currency,
      @Semantics.amount.currencyCode : 'Currency'
      stpo.preis                                           as MaterialComponentPrice,
      stpo.itmid                                           as IdentifierBOMItem,
      stpo.peinh                                           as MaterialPriceUnitQty,
      stpo.ausch                                           as ComponentScrapInPercent,
      stpo.avoau                                           as OperationScrapInPercent,
      stpo.netau                                           as IsNetScrap,
      stpo.roanz                                           as NumberOfVariableSizeItem,
      stpo.romen                                           as QuantityVariableSizeItem,
      stpo.rform                                           as FormulaKey,
      stpo.potx1                                           as BOMItemDescription,
      stpo.potx2                                           as BOMItemText2,
      stpo.matkl                                           as MaterialGroup,
      stpo.dokar                                           as DocumentType,
      stpo.doknr                                           as DocNumber,
      stpo.dokvr                                           as DocumentVersion,
      stpo.doktl                                           as DocumentPart,
      stpo.class                                           as ClassNumber,
      stpo.klart                                           as ClassType,
      stpo.potpr                                           as ResultingItemCategory,
      stpo.knobj                                           as DependencyObjectNumber,
      stpo.objty                                           as ObjectType,
      stpo.kzclb                                           as IsClassificationRelevant,
      stpo.schgt                                           as IsBulkMaterial,
      stpo.erskz                                           as BOMItemIsSparePart,
      stpo.rvrel                                           as BOMItemIsSalesRelevant,
      stpo.sanfe                                           as IsProductionRelevant,
      stpo.sanin                                           as BOMItemIsPlantMaintRelevant,
      stpo.sanka                                           as BOMItemIsCostingRelevant,
      stpo.sanko                                           as IsEngineeringRelevant,
      stpo.itsob                                           as SpecialProcurementType,
      stpo.rekrs                                           as IsBOMRecursiveAllowed,
      stpo.nlfzv                                           as OperationLeadTimeOffset,
      stpo.nlfmv                                           as OpsLeadTimeOffsetUnit,
      stpo.aedat                                           as BOMItemChangeDate,
      stpo.beikz                                           as IsMaterialProvision,
      stpo.rekri                                           as BOMIsRecursive,
      stpo.cadpo                                           as DocumentIsCreatedByCAD,
      stpo.verti                                           as DistrKeyCompConsumption,
      stpo.lifzt                                           as DeliveryDurationInDays,
      stpo.lifnr                                           as Creditor,
      stpo.sakto                                           as CostElement,
      stpo.roms1                                           as Size1,
      stpo.roms2                                           as Size2,
      stpo.roms3                                           as Size3,
      stpo.romei                                           as UnitOfMeasureForSize1To3,
      stpo.webaz                                           as GoodsReceiptDuration,
      stpo.ekorg                                           as PurchasingOrganization,
      stpo.clobk                                           as RequiredComponent,
      stpo.clmul                                           as MultipleSelectionAllowed,
      stpo.lgort                                           as ProdOrderIssueLocation,
      stpo.kzkup                                           as MaterialIsCoProduct,
      stpo.dspst                                           as ExplosionType,
      stpo.nfgrp                                           as FollowUpGroup,
      stpo.nfeag                                           as DiscontinuationGroup,
      stpo.cview                                           as ReinsurContrOrgUnit,
      stpo.awakz                                           as IsConfigurableBOM,
      stpo.rfpnt                                           as ReferencePoint,
      stpo.nlfzt                                           as LeadTimeOffset,
      stpo.sfwind                                          as IsSoftwareComponent,
      stpo.prvbe                                           as ProductionSupplyArea,
      //stpo.lkenz       as IsDeleted,
      stas.lkenz                                           as IsDeleted,
      stpo.alekz                                           as IsALE,
      tcs03.bmein                                          as UnitOfMeasureForPiece,
      tcs03.roame                                          as UnitOfMeasureForVarSizeItem,
      //Alternative Item Fields
      stpo.alpgr                                           as AlternativeItemGroup,
      stpo.alprf                                           as AlternativeItemPriority,
      stpo.alpst                                           as AlternativeItemStrategy,
      stpo.ewahr                                           as UsageProbabilityPercent,
      stpo.stkkz                                           as IsPMAssemblyRelevant, // Note - 2812027
      stpo.ltxsp                                           as LongItemTextLanguage,
      case when stpo.postp = 'D'
      then
        case when ( ChildDocumentBOM.DocNumber is not null or ChildDocumentBOM.DocNumber <> '' )
           then
           cast('X' as xfeld preserving type )
           else
           cast(' ' as xfeld preserving type)
           end

      else case when ( ChildMaterialBOM.Material is not null or ChildMaterialBOM.Material != '' )-- and
      -- and       ( ChildMaterialBOM.Plant = MaterialBOM.Plant )
           then
           cast('X' as xfeld preserving type)
           else
           cast(' ' as xfeld preserving type)
           end
      end                                                  as IsAssembly,

      case
       when t460a.dumps = 'X'
      then cast('X' as xfeld preserving type)
      else
      cast('' as xfeld preserving type)
      end                                                  as IsPhantomItem,
      case
        when stpo.lastchangedatetime = 0.0000000  then
          case when stpo.aenam <> '' then cast(dats_tims_to_tstmp(stpo.aedat, cast('120000' as uzeit), 'UTC', $session.client, 'NULL') as timestampl )
            else cast(dats_tims_to_tstmp(stpo.andat, cast('120000' as uzeit), 'UTC', $session.client, 'NULL') as timestampl )
          end
        else
          stpo.lastchangedatetime
      end                                                  as LastChangeDateTime
}
--where
--stpo.valid_to != '00000000'
