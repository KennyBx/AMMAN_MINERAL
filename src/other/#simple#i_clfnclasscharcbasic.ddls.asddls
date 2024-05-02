@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: '/SIMPLE/ICLCHB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Clfn Class Characteristic Basic'
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER
define view /SIMPLE/I_ClfnClassCharcBasic
  as select from ksml as ClassCharc

{
  key ClassCharc.clint                                                    as ClassInternalID,
  key ClassCharc.posnr                                                    as CharcPositionNumber,
  key ClassCharc.adzhl                                                    as TimeIntervalNumber,
      cast ( ClassCharc.imerk as atinn_no_conv preserving type )          as CharcInternalID,
      cast ( ClassCharc.omerk as atinn_no_conv preserving type )          as OverwrittenCharcInternalID,
      cast ( ClassCharc.abtei as clfnorganizationalarea preserving type ) as ClfnOrganizationalArea,
      ClassCharc.klart                                                    as ClassType,
      ClassCharc.aennr                                                    as ChangeNumber,
      @Semantics.businessDate.from: true
      ClassCharc.datuv                                                    as ValidityStartDate,
      @Semantics.businessDate.to: true
      ClassCharc.datub                                                    as ValidityEndDate,
      ClassCharc.lkenz                                                    as IsDeleted,
      //      ClassCharc.dinkb  as CharcCodeLetter,
      ClassCharc.herku                                                    as CharcOriginText,
      ClassCharc.prop_rel                                                 as CharcIsProposalRelevant,
      ClassCharc.pprel                                                    as CharcIsPrptnOrProdUnitRelevant,
      //      ClassCharc.mkenn  as CharcStandardCodeLetter,
      ClassCharc.relev                                                    as RelevancyIndicator,
      case ClassCharc.amerk
      when '1000000000' then 'X'
      when '1200000000' then 'X'
      when '1300000000' then 'X'
      when '1400000000' then 'X'
      when '1230000000' then 'X'
      when '1240000000' then 'X'
      when '1340000000' then 'X'
      when '1234000000' then 'X'
      else ''
      end                                                                 as CharcIsPrintRelevant,

      case ClassCharc.amerk
      when '2000000000' then 'X'
      when '1200000000' then 'X'
      when '2300000000' then 'X'
      when '2400000000' then 'X'
      when '1230000000' then 'X'
      when '1240000000' then 'X'
      when '2340000000' then 'X'
      when '1234000000' then 'X'
      else ''
      end                                                                 as CharcIsSearchRelevant,

      case ClassCharc.amerk
      when '3000000000' then 'X'
      when '1300000000' then 'X'
      when '2300000000' then 'X'
      when '3400000000' then 'X'
      when '1230000000' then 'X'
      when '1340000000' then 'X'
      when '2340000000' then 'X'
      when '1234000000' then 'X'
      else ''
      end                                                                 as CharcIsDisplayRelevant
}
