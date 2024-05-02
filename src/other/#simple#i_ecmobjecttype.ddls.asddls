@AbapCatalog.sqlViewName: '/SIMPLE/IECMOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #CHECK

@ClientHandling.algorithm: #SESSION_VARIABLE

@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.representativeKey: ['ChangeNumber', 'ChangeNumberObjectType']
@ObjectModel.semanticKey: ['ChangeNumber', 'ChangeNumberObjectType']

@ObjectModel.supportedCapabilities: [ #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET,
                                      #SQL_DATA_SOURCE ]

@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER

@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type:#PUBLIC_LOCAL_API

@EndUserText.label: 'ECM Object Type'
define view /SIMPLE/I_ECMObjectType
  as select from aenv
  association [1..1] to /SIMPLE/I_ChangeMaster         as _ChangeMaster                 on $projection.ChangeNumber = _ChangeMaster.ChangeNumber
  association [0..1] to I_ChangeMasterObjectType       as _ChangeNumberObjectType       on $projection.ChangeNumberObjectType = _ChangeNumberObjectType.ChangeNumberObjectType
  association [0..*] to I_ChangeMstrObjTypeRevisionLvl as _ChangeMstrObjTypeRevisionLvl on $projection.ChangeNumberObjectType = _ChangeMstrObjTypeRevisionLvl.ChangeNumberObjectType
{
        @ObjectModel.foreignKey.association: '_ChangeMaster'
  key   aennr                            as ChangeNumber,
        @ObjectModel.foreignKey.association: '_ChangeNumberObjectType'
  key   cast( aetyp as char2 )                            as ChangeNumberObjectType,

        cast ( aeerl as /plmb/aeerl )    as IsActiveForChangeNumber,
        
        //aensp                            as IsLockedForChanges,
        cast ( aensp as boole_d )        as IsLockedForChanges,
        
        cast ( tobja  as boole_d )       as IsPartiallyDisplayed,
        cast ( indfl as boole_d ) as ObjMgmtRecdIsRequired,
        cast ( oigen as boole_d )    as ObjMgmtRecdIsGenerated,
        
        //genan                            as ObjMgmtRecdIsAutomlyCrted,
        cast ( genan as boole_d )        as ObjMgmtRecdIsAutomlyCrted,
        
        //gendi                            as ObjMgmtRecdIsAutomlyCrtedByDlg,
        cast ( gendi as boole_d )        as ObjMgmtRecdIsAutomlyCrtedByDlg,

        @Semantics.businessDate.at: true
        andat                            as ObjectTypeCreationDate,
        annam                            as ObjectTypeCreatedByUser,
        @Semantics.businessDate.at: true
        aedat                            as ObjectTypeLastChangedDate,
        aenam                            as ObjectTypeLastChangedByUser,

        _ChangeNumberObjectType,
        _ChangeMaster,
        _ChangeMstrObjTypeRevisionLvl
} where tobja <> 'X'
