@AbapCatalog.sqlViewName: '/SIMPLE/PBOPEDET'
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

define view /SIMPLE/P_BOMPermanentDeter
  as select from stzu
    inner join   tcs03 as tcs03 on stzu.mandt = $session.client
{
  key  stlty                          as BillOfMaterialCategory,
  key  stlnr                          as BillOfMaterial,
       stlan                          as BillOfMaterialVariantUsage,
       stzu.stlbe                     as BillOfMaterialAuthsnGrp,
       stzu.kbaus                     as BOMIsConfigurable,
       stzu.kbaus                     as IsConfiguredMaterial,
       stzu.versnind                  as IsVersionBillOfMaterial,
       case
         when stzu.altst = 'X' then 'M'
         when stzu.varst = 'X' then 'V'
         else ' '
         end                          as BOMTechnicalType,
       stzu.ztext                     as BOMHeaderText,
       stzu.exstl                     as BOMGroup,
       cast( tcs03.dlhnd as boole_d ) as BOMIsToBeDeleted,
       //       tcs03.dlhnd   as BOMIsToBeDeleted,
       ltxsp                          as LongTextLanguage,
       stldt                          as HeaderValidityStartDate //PESI-84 - Add by Doris Dang - 20243101
}
where
        tcs03.agb29 is null
  or -- either we do not have an entry in TCS03
  (
        tcs03.agb29 = '29'
    --     and stko.loekz  =  'X'
    and tcs03.dlhnd = '2'
  )
  or(
        tcs03.agb29 = '29'
    --  and stko.loekz  <> 'X'
  )
