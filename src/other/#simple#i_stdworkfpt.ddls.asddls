@AbapCatalog.sqlViewName: '/SIMPLE/ISTWFPT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.buffering: { status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001 }
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'StandardWorkFormulaParameter'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING }
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Standard Work Formula Parameter Text'

define view /SIMPLE/I_StdWorkFPT
  as select from tc20t

  association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language
{
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key spras                                     as Language,
      @ObjectModel.text.element: 'StandardWorkFormulaParamName'
  key cast(parid as pph_parid preserving type)  as StandardWorkFormulaParameter,
      @Semantics.text: true
      cast(txtlg as pph_partxt preserving type) as  StandardWorkFormulaParamName,

      _Language
};
