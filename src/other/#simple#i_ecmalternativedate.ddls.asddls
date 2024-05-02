@AbapCatalog.sqlViewName: '/SIMPLE/IECMAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK

@ClientHandling.algorithm: #SESSION_VARIABLE

@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.semanticKey: ['ChangeNumber', 'ChgNmbrAlternativeDateCounter']

@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET ]

@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER

@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type:#PUBLIC_LOCAL_API
@EndUserText.label: 'ECM Alternative Date'
define view /SIMPLE/I_ECMAlternativeDate 
  as select from aedt
  association [0..1] to /SIMPLE/I_ChangeMaster as _ChangeMaster on $projection.ChangeNumber = _ChangeMaster.ChangeNumber
{
      @ObjectModel.foreignKey.association: '_ChangeMaster'
  key aennr                                         as ChangeNumber,
  key aedtz                                         as ChgNmbrAlternativeDateCounter,
      aedtn                                         as ChgNmbrAlternativeDateID,
      datuv                                         as ChgNmbrAlternativeDate,
      aedtn                                         as ChgNmbrAlternativeDateText,
      cast ( aedto as /plmb/aedto preserving type ) as ChgNmbrAltvDateIsAssignedToObj,

      _ChangeMaster
}
