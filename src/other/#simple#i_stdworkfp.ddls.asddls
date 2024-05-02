@AbapCatalog.sqlViewName: '/SIMPLE/ISTWFP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.buffering: { status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001 }
@AbapCatalog.preserveKey: true
@Analytics.dataCategory: #DIMENSION
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'StandardWorkFormulaParameter'
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING }
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Standard Work Formula Parameter'

define view /SIMPLE/I_StdWorkFP
  as select from tc20

  association [0..*] to /SIMPLE/I_StdWorkFPT as _Text on $projection.StandardWorkFormulaParameter = _Text.StandardWorkFormulaParameter
  association [0..1] to /SIMPLE/I_StdWorkFPT as _TextSysLanguage on $projection.StandardWorkFormulaParameter = _TextSysLanguage.StandardWorkFormulaParameter
                                                                and _TextSysLanguage.Language = $session.system_language
  association [0..1] to /SIMPLE/I_StdWorkFPT as _TextEnLanguage on $projection.StandardWorkFormulaParameter = _TextEnLanguage.StandardWorkFormulaParameter
                                                               and _TextEnLanguage.Language = 'E'
{
      @ObjectModel.text.association: '_Text'
  key cast(parid as pph_parid preserving type) as StandardWorkFormulaParameter,

      _Text,
      _TextSysLanguage,
      _TextEnLanguage
};
