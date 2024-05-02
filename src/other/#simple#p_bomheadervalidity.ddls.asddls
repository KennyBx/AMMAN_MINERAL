@AbapCatalog.sqlViewName: '/SIMPLE/PBOMHVL'
@AbapCatalog.preserveKey:true
@ClientHandling.type : #INHERITED
@ClientHandling.algorithm : #AUTOMATED
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@VDM.viewType: #BASIC
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #XL, dataClass: #TRANSACTIONAL}
@VDM.private: true
@VDM.lifecycle.contract.type: #NONE
define view /SIMPLE/P_BOMHeaderValid as select from stko as a left outer join stko as b on 
                                        a.stlty     =  b.stlty
                                    and a.stlnr     =  b.stlnr
                                    and a.bom_versn =  b.bom_versn
                                    and a.stlal     =  b.stlal
                                    and a.datuv     <  b.datuv
                                    {
  key a.stlty   as BillOfMaterialCategory,
  key a.stlnr   as BillOfMaterial,
  key a.stlal   as BillOfMaterialVariant,
      a.stkoz   as BOMHeaderInternalChangeCount,
      a.datuv                                           as HeaderValidityStartDate,
      cast ( min ( b.datuv ) as datub preserving type ) as HeaderValidityEndDate,
      a.aennr                                           as HeaderEngineeringChgNmbrDoc,
      a.bom_versn                                       as BillOfMaterialVersion
     }where
      a.lkenz = ''
  group by
  a.stlty,
  a.stlnr,
  a.stlal,
  a.stkoz,
  a.datuv,
  a.aennr,
  a.bom_versn ;
