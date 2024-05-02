@AbapCatalog.sqlViewName: '/SIMPLE/PBOMHDET'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #AUTOMATED
@AbapCatalog.compiler.compareFilter: true
@VDM.private: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.lifecycle.contract.type: #NONE
--@EndUserText.label: 'Bom header determination'

define view /SIMPLE/P_BomHeaderDeter
  as select from stko  as stko
    inner join   stzu  as stzu  on  stko.stlty = stzu.stlty
                                and stko.stlnr = stzu.stlnr
  -- 2: data to filter by TCS03 (parameters for BOM)
    inner join   tcs03 as tcs03 on stko.mandt = $session.client
    inner join   /SIMPLE/P_BOMHeaderValid as head_valid on stko.stlty = head_valid.BillOfMaterialCategory
                                                       and stko.stlnr = head_valid.BillOfMaterial
                                                       and stko.stlal = head_valid.BillOfMaterialVariant
                                                       and stko.stkoz = head_valid.BOMHeaderInternalChangeCount
  -- 1: data to filter by T415S (BOM header status)
  /* inner join   t415s as t415s on
   //stko.mandt  = t415s.mandt and
   stko.stlst = t415s.stlst
   inner join   tcs41 as tcs41 on tcs41.stlan = stzu.stlan
   inner join   tc04  as tc04  on  tc04.mandt = $session.client //stko.mandt
                               and tc04.cslid = tcs41.cslid */
{
 key stko.stlty                               as BillOfMaterialCategory,
 key stko.stlnr                               as BillOfMaterial,
 key  stko.stlal                              as BillOfMaterialVariant,
 key  stzu.stlan                              as BillOfMaterialVariantUsage,
 key  stko.stkoz                               as BOMHeaderInternalChangeCount,
 key  stko.bom_versn                           as BillOfMaterialVersion,
      stko.guidx,
  stko.cadkz                               as DocumentIsCreatedByCAD,
  stko.labor                               as LaboratoryOrDesignOffice,

  cast('' as cslid )                       as BOMPrioritizedVersion,
  cast('PP01' as capid)                    as BOMExplosionApplication,
  cast('' as x415a)                        as IsMultipleBOMAlt,
  cast('' as cslpr)                        as BOMUsagePriority,
  stzu.stlbe                               as BillOfMaterialAuthsnGrp,
  stzu.kbaus                               as BOMIsConfigurable,
  stzu.kbaus                               as IsConfiguredMaterial,
  stzu.versnind                            as IsVersionBillOfMaterial,
  case
    when stzu.altst = 'X' then 'M'
    when stzu.varst = 'X' then 'V'
    else ' '
    end                                    as BOMTechnicalType,
  stzu.ztext                               as BOMHeaderText,
  stzu.exstl                               as BOMGroup,
  stko.stktx                               as BOMAlternativeText,
  stko.stlst                               as BillOfMaterialStatus,
  head_valid.HeaderValidityStartDate,
  case
  when head_valid.HeaderValidityEndDate != ''
  then head_valid.HeaderValidityEndDate
  when head_valid.HeaderValidityStartDate = '00000000'
  then head_valid.HeaderValidityEndDate
  else cast('99991231' as datub )
  end                                      as HeaderValidityEndDate,
  stko.aennr                               as HeaderEngineeringChgNmbrDoc,
  stko.ecn_to                              as ChangeNumberTo,
  stko.lkenz                               as DeletionIndicator,
  stko.loekz                               as BOMIsArchivedForDeletion,
  --stko.loekz         as DeletionIndicatorBom,
  stko.alekz                               as IsALE,
  @Semantics.unitOfMeasure: true
  stko.bmein                               as BOMHeaderBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'BOMHeaderBaseUnit'
  stko.bmeng                               as BOMHeaderQuantityInBaseUnit,
  stko.andat                               as RecordCreationDate,
  stko.aedat                               as LastChangeDate,
  stko.annam                               as CreatedByUser,
  stko.aenam                               as LastChangedByUser,
  tcs03.dlhnd                              as BOMIsToBeDeleted,
  stko.bom_prev_versn                      as BOMPredecessorVersion,
  stko.versnst                             as BOMVersionStatus,
  stko.versnlastind                        as IsLatestBOMVersion,
  case
    when stko.lastchangedatetime = 0.0000000  then
      case when stko.aenam <> '' then cast(dats_tims_to_tstmp(stko.aedat, cast('120000' as uzeit), 'UTC', $session.client, 'NULL') as timestampl )
        else cast(dats_tims_to_tstmp(stko.andat, cast('120000' as uzeit), 'UTC', $session.client, 'NULL') as timestampl )
      end
    else
  stko.lastchangedatetime
  end as LastChangeDateTime,
  stko.bom_ain_ind                          as BOMAssetNtwkHndovrIsRelevant,
  stko.ltxsp                                as LongAlterTextLanguage
}
where
          stko.lkenz  =  ''
  and

  -- 1: filter by T415S (BOM header status)

  -- 2: filter by TCS03 (parameters for BOM)
  -- functionality described in note 552974 AND 582821
  -- in CASE field STKO-LOEKZ is set, use the BOM in CASE:
  --
  -- TCS03-DLHND | = '' | = '1' | = '2'
  -- ----------------------------------
  -- ALEKZ = ''  |  1   |       |  X
  -- ALEKZ = 'X' |  X   |       |  x
  -- -> 1 is the standard CASE AND has a different behaviour: we first of all consider all alternatives (even the the ones which are
  -- marked for deletion) AND check at the END (after we selected a BOM alternative) if that is marked for deletion OR not
  -- -> so the check for 1 is implemented at the END
  (
         tcs03.agb29 is null
    or -- either we do not have an entry in TCS03
    (
          tcs03.agb29 =  '29'
 --     and stko.loekz  =  'X'
      and tcs03.dlhnd =  '2'
    )
    or(
          tcs03.agb29 =  '29'
    --  and stko.loekz  <> 'X'
    )
  )
