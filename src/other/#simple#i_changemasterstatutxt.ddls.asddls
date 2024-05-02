@AbapCatalog.sqlViewName: '/SIMPLE/IECNSTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK

@ClientHandling.algorithm: #SESSION_VARIABLE

@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.representativeKey: 'ChangeNumberStatus'
@ObjectModel.dataCategory: #TEXT
//@ObjectModel.semanticKey:  'ChangeNumberStatus'
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #CUSTOMIZING

@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type:#PUBLIC_LOCAL_API

@EndUserText.label: 'Change Number Status Text'
define view /SIMPLE/I_ChangeMasterStatuTxt
  as select from t419t
  association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language
{
  key cast ( aenst as /plmb/ecn_status ) as ChangeNumberStatus,

      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language
  key spras                              as Language,

      @Semantics.text
      aestx                              as ChangeNumberStatusText,

      _Language
}
