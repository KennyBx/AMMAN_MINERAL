@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: '/SIMPLE/ICLFNDES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Description of Classification Class'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_REMOTE_API
//@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'ClassInternalID'
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER
define view /SIMPLE/I_ClfnClassDesc
  as select from swor as ClassDescription
    inner join   klah as Class on ClassDescription.clint = Class.clint
  association [0..1] to /SIMPLE/I_Language  as _Language on $projection.Language = _Language.Language
  association [1..1] to /SIMPLE/I_ClfnClass as _Class    on $projection.ClassInternalID = _Class.ClassInternalID
{
  key ClassDescription.clint                                   as ClassInternalID,
//      @ObjectModel.foreignKey.association: '_Language'
//      @Semantics.language: true
  key ClassDescription.spras                                   as Language,
  key Class.class,
//      @Semantics.text: true
      cast( ClassDescription.kschl as klsbez preserving type ) as ClassDescription,

      _Language,
      _Class
}
where
  ClassDescription.klpos = '01'
