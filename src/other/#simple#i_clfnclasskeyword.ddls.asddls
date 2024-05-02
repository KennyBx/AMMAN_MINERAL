@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: '/SIMPLE/ICLFNKW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Keyword of Classification Class'
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
//@ObjectModel.dataCategory: #TEXT
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.representativeKey: 'ClassKeywordPositionNumber'
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER
define view /SIMPLE/I_ClfnClassKeyword
  as select from swor as ClassKeyword
    inner join   klah as Class on ClassKeyword.clint = Class.clint
  association [0..1] to /SIMPLE/I_Language  as _Language on $projection.Language = _Language.Language
  association [0..1] to /SIMPLE/I_ClfnClass as _Class    on $projection.ClassInternalID = _Class.ClassInternalID
{
      @ObjectModel.foreignKey.association: '_Class'
  key ClassKeyword.clint as ClassInternalID,
      @ObjectModel.foreignKey.association: '_Language'
//      @Semantics.language: true
  key ClassKeyword.spras as Language,
      @ObjectModel.foreignKey.association: null
  key ClassKeyword.klpos as ClassKeywordPositionNumber,
  key Class.class,
//      @Semantics.text: true
      ClassKeyword.kschl as ClassKeywordText,

      _Language,
      _Class
}
where
  ClassKeyword.klpos <> '01'
