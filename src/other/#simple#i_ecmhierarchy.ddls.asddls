@AbapCatalog.sqlViewName: '/SIMPLE/ECMH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK

@ClientHandling.algorithm: #SESSION_VARIABLE

//@Metadata.ignorePropagatedAnnotations: true
//
//@ObjectModel.representativeKey: 'PackageChangeNumber'
//@ObjectModel.semanticKey: [ 'PackageChangeNumber' ]

//@ObjectModel.supportedCapabilities: [ #CDS_MODELING_DATA_SOURCE,
//                                      #CDS_MODELING_ASSOCIATION_TARGET,
//                                      #SQL_DATA_SOURCE ]

@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER

@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type:#PUBLIC_LOCAL_API

@EndUserText.label: 'Change Number Hierarchy'
define view /SIMPLE/I_ECMHierarchy

  as select from aehi
  association [0..1] to /SIMPLE/I_ChangeMaster as _LeadingChangeMaster on $projection.LeadingChangeNumber = _LeadingChangeMaster.ChangeNumber
  association [0..1] to /SIMPLE/I_ChangeMaster as _PackageChangeMaster on $projection.PackageChangeNumber = _PackageChangeMaster.ChangeNumber
{
      @ObjectModel.foreignKey.association: '_PackageChangeMaster'
  key aechi as PackageChangeNumber,

      @ObjectModel.foreignKey.association: '_LeadingChangeMaster'
      aepar as LeadingChangeNumber,

      andat as LeadChangeNumberCreationDate,
      annam as LeadChangeNumberCreatedByUser,

      _LeadingChangeMaster,
      _PackageChangeMaster
}
