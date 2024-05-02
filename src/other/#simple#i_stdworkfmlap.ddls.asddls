@AbapCatalog.sqlViewName: '/SIMPLE/ISTWFAG'
@AbapCatalog.buffering: { status: #ACTIVE, type: #GENERIC, numberOfKeyFields: 001 }
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics: { dataCategory: #DIMENSION }
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'StandardWorkFormulaParamGroup'
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #S, dataClass: #CUSTOMIZING }
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #BASIC
@EndUserText.label: 'Standard Work Formula Parameter Group'

define view /SIMPLE/I_StdWorkFmlaPG
  as select from tc21

//  association [0..*] to /SIMPLE/I_StdWorkFmlaPGT as _Text                          on $projection.StandardWorkFormulaParamGroup = _Text.StandardWorkFormulaParamGroup
  association [0..1] to /SIMPLE/I_StdWorkFP as _StandardWorkFormulaParameter1 on $projection.StandardWorkFormulaParam1 = _StandardWorkFormulaParameter1.StandardWorkFormulaParameter
  association [0..1] to /SIMPLE/I_StdWorkFP as _StandardWorkFormulaParameter2 on $projection.StandardWorkFormulaParam2 = _StandardWorkFormulaParameter2.StandardWorkFormulaParameter
  association [0..1] to /SIMPLE/I_StdWorkFP as _StandardWorkFormulaParameter3 on $projection.StandardWorkFormulaParam3 = _StandardWorkFormulaParameter3.StandardWorkFormulaParameter
  association [0..1] to /SIMPLE/I_StdWorkFP as _StandardWorkFormulaParameter4 on $projection.StandardWorkFormulaParam4 = _StandardWorkFormulaParameter4.StandardWorkFormulaParameter
  association [0..1] to /SIMPLE/I_StdWorkFP as _StandardWorkFormulaParameter5 on $projection.StandardWorkFormulaParam5 = _StandardWorkFormulaParameter5.StandardWorkFormulaParameter
  association [0..1] to /SIMPLE/I_StdWorkFP as _StandardWorkFormulaParameter6 on $projection.StandardWorkFormulaParam6 = _StandardWorkFormulaParameter6.StandardWorkFormulaParameter

{
      @ObjectModel.text.association: '_Text'
  key vgwts as  StandardWorkFormulaParamGroup,

      @ObjectModel.foreignKey.association: '_StandardWorkFormulaParameter1'
      par01 as  StandardWorkFormulaParam1,
      @ObjectModel.foreignKey.association: '_StandardWorkFormulaParameter2'
      par02 as  StandardWorkFormulaParam2,
      @ObjectModel.foreignKey.association: '_StandardWorkFormulaParameter3'
      par03 as  StandardWorkFormulaParam3,
      @ObjectModel.foreignKey.association: '_StandardWorkFormulaParameter4'
      par04 as  StandardWorkFormulaParam4,
      @ObjectModel.foreignKey.association: '_StandardWorkFormulaParameter5'
      par05 as  StandardWorkFormulaParam5,
      @ObjectModel.foreignKey.association: '_StandardWorkFormulaParameter6'
      par06 as  StandardWorkFormulaParam6,

      // Associations
      _StandardWorkFormulaParameter1,
      _StandardWorkFormulaParameter2,
      _StandardWorkFormulaParameter3,
      _StandardWorkFormulaParameter4,
      _StandardWorkFormulaParameter5,
      _StandardWorkFormulaParameter6
//      _Text
};
