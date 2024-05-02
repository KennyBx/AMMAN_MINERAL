@AbapCatalog.sqlViewName: '/SIMPLE/IECMS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK

@ClientHandling.algorithm: #SESSION_VARIABLE

@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.representativeKey: 'ChangeNumberStatus'
@ObjectModel.semanticKey: 'ChangeNumberStatus'

@ObjectModel.supportedCapabilities: [ #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET,
                                      #SQL_DATA_SOURCE ]

@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #CUSTOMIZING

@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type:#PUBLIC_LOCAL_API

@EndUserText.label: 'ECM Status'
define view /SIMPLE/I_ECMStatus 
  as select from t419s
  association [0..*] to /SIMPLE/I_ECMStatusText as _Text on $projection.ChangeNumberStatus = _Text.ChangeNumberStatus
{
      @ObjectModel.text.association: '_Text'
  key cast ( aenst as /plmb/ecn_status ) as ChangeNumberStatus,
      cast ( aeflg as /plmb/cc_aeflg   ) as ChangeIsAllowed,
      cast ( dtflg as /plmb/cc_dtflg   ) as DateChangeIsAllowed,
      cast ( dlock as /plmb/cc_dlock   ) as DistributionIsLocked,

      _Text
}
