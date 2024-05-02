@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: '/SIMPLE/ICLHCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Clfn Cl Hier Characteristic For Key Date'
@VDM.viewType: #COMPOSITE
@VDM.lifecycle.contract.type: #PUBLIC_REMOTE_API

@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.dataClass: #MASTER
define view /SIMPLE/I_ClfnClassHierCharc
  as select from /SIMPLE/I_CLFNCLASSSUPERIOR   as ClassSuperior
    inner join   /SIMPLE/I_ClfnClassCharcBasic as ClassCharcBasic on ClassCharcBasic.ClassInternalID = ClassSuperior.AncestorClassInternalID
    inner join   /SIMPLE/I_ClfnCharcBasic      as Characteristic  on Characteristic.CharcInternalID = ClassCharcBasic.CharcInternalID

  association [0..1] to /SIMPLE/I_ClfnClass as _Class on $projection.ClassInternalID = _Class.ClassInternalID
{
  key ClassSuperior.ClassInternalID,
  key ClassSuperior.AncestorClassInternalID,
  key ClassCharcBasic.CharcInternalID,
      ClassCharcBasic.CharcPositionNumber,
      ClassSuperior.ClassType,
      ClassSuperior.Class,
      ClassSuperior.AncestorClass,
      ClassSuperior.ClassClassfctnAuthGrp,
      Characteristic.Characteristic,
      ClassCharcBasic.OverwrittenCharcInternalID,
      ClassCharcBasic.ClfnOrganizationalArea,
      ClassCharcBasic.ChangeNumber,
      //      ClassCharcBasic.CharcCodeLetter,
      ClassCharcBasic.CharcOriginText,
      //      ClassCharcBasic.CharcStandardCodeLetter,
      cast( ClassCharcBasic.CharcIsPrintRelevant as drurel )   as CharcIsPrintRelevant,
      cast( ClassCharcBasic.CharcIsSearchRelevant as selrel )  as CharcIsSearchRelevant,
      cast( ClassCharcBasic.CharcIsDisplayRelevant as anzrel ) as CharcIsDisplayRelevant,
      ClassCharcBasic.CharcIsProposalRelevant,
      ClassCharcBasic.CharcIsPrptnOrProdUnitRelevant,
      ClassCharcBasic.ValidityStartDate,
      ClassCharcBasic.ValidityEndDate,
      ClassCharcBasic.RelevancyIndicator,
      case when ClassSuperior.ClassInternalID = ClassCharcBasic.ClassInternalID
        then cast( '' as mmerb ) else cast( 'X' as mmerb )
      end                                                      as CharcIsInherited,
      _Class
}
where
      ClassCharcBasic.IsDeleted = ''
  and Characteristic.IsDeleted  = ''
