@AbapCatalog.sqlViewName: '/SIMPLE/IOCVALB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Clfn Obj Characteristic Valuation Basic'
@ClientHandling.algorithm: #SESSION_VARIABLE
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_REMOTE_API

@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
define view /SIMPLE/I_ClfnObjCharcValBasic
  as select from ausp as Valuation
    inner join   klah as Class on Valuation.objek = Class.clint
{
  key Valuation.objek                                           as ClfnObjectID,
  key cast ( Valuation.atinn as atinn_no_conv preserving type ) as CharcInternalID,
  key Valuation.atzhl                                           as CharcValuePositionNumber,
  key Valuation.mafid                                           as ClfnObjectType,
  key Valuation.klart                                           as ClassType,
  key Valuation.adzhl                                           as TimeIntervalNumber,
      Class.class,
      Valuation.atcod                                           as CharcValueIntervalType,
      Valuation.atwrt                                           as CharcValue,
      Valuation.atflv                                           as CharcFromNumericValue,
      Valuation.atawe                                           as CharcFromNumericValueUnit,
      Valuation.atflb                                           as CharcToNumericValue,
      Valuation.ataw1                                           as CharcToNumericValueUnit,
      Valuation.dec_value_from                                  as CharcFromDecimalValue,
      Valuation.dec_value_to                                    as CharcToDecimalValue,
      Valuation.curr_value_from                                 as CharcFromAmount,
      Valuation.curr_value_to                                   as CharcToAmount,
      Valuation.currency                                        as Currency,
      Valuation.date_from                                       as CharcFromDate,
      Valuation.date_to                                         as CharcToDate,
      Valuation.time_from                                       as CharcFromTime,
      Valuation.time_to                                         as CharcToTime,
      Valuation.ataut                                           as CharacteristicAuthor,
      Valuation.aennr                                           as ChangeNumber,
      @Semantics.businessDate.from: true
      Valuation.datuv                                           as ValidityStartDate,
      @Semantics.businessDate.to: true
      Valuation.datub                                           as ValidityEndDate,
      Valuation.lkenz                                           as IsDeleted
}
