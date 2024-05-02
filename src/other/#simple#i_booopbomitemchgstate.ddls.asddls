@AbapCatalog.sqlViewName: '/SIMPLE/IBOBITCS'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
// ben @ObjectModel.representativeKey: 'BOOOpBOMItemIntVersCounter'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Bill of Operations Operation BOM Item Change State'
// ben @ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Search.searchable: true
@Metadata.allowExtensions:true
@AbapCatalog.preserveKey:true

define view /SIMPLE/I_BOOOpBOMItemChgState
  as select from plmz
  

    association [1..1] to /SIMPLE/I_BillOfOperationType  as _BillOfOperationsType      on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
    association [1..1] to /SIMPLE/I_BillOfOperationGroup as _BillOfOperationsGroup     on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
  
    association [1..1] to /SIMPLE/I_BillOfOperation      as _BillOfOperations          on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
                                                                                       and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant
  
    association [1..1] to /SIMPLE/I_BOOSequence          as _BillOfOperationsSequence  on  $projection.BillOfOperationsType     = _BillOfOperationsSequence.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup    = _BillOfOperationsSequence.BillOfOperationsGroup
                                                                                       and $projection.BillOfOperationsVariant  = _BillOfOperationsSequence.BillOfOperationsVariant
                                                                                       and $projection.BillOfOperationsSequence = _BillOfOperationsSequence.BillOfOperationsSequence
  
    association [1..1] to /SIMPLE/I_BOOOPERATION         as _BillOfOperationsOperation on  $projection.BillOfOperationsType     = _BillOfOperationsOperation.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup    = _BillOfOperationsOperation.BillOfOperationsGroup
                                                                                       and $projection.BillOfOperationsVariant  = _BillOfOperationsOperation.BillOfOperationsVariant
                                                                                       and $projection.BillOfOperationsSequence = _BillOfOperationsOperation.BillOfOperationsSequence
                                                                                       and $projection.BOOOperationInternalID   = _BillOfOperationsOperation.BOOOperationInternalID
  
    association [1..1] to /SIMPLE/I_BOOOpInternalID      as _BOOOperationInternalID    on  $projection.BillOfOperationsType   = _BOOOperationInternalID.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup  = _BOOOperationInternalID.BillOfOperationsGroup
                                                                                       and $projection.BOOOperationInternalID = _BOOOperationInternalID.BOOOperationInternalID
  
    association [1..1] to /SIMPLE/I_BOOOBOMItmInternalID as _BOOOpBOMItemInternalID    on  $projection.BillOfOperationsType     = _BOOOpBOMItemInternalID.BillOfOperationsType
                                                                                       and $projection.BillOfOperationsGroup    = _BOOOpBOMItemInternalID.BillOfOperationsGroup
                                                                                       and $projection.BillOfOperationsVariant  = _BOOOpBOMItemInternalID.BillOfOperationsVariant
                                                                                       and $projection.BillOfOperationsSequence = _BOOOpBOMItemInternalID.BillOfOperationsSequence
                                                                                       and $projection.BOOOperationInternalID   = _BOOOpBOMItemInternalID.BOOOperationInternalID
                                                                                       and $projection.BOOOpBOMItemInternalID   = _BOOOpBOMItemInternalID.BOOOpBOMItemInternalID
  
    association [0..*] to /SIMPLE/I_BillOfMaterialItem   as _BillOfMaterialItem        on  $projection.BillOfMaterialCategory       = _BillOfMaterialItem.BillOfMaterialCategory
                                                                                       and $projection.BillOfMaterial               = _BillOfMaterialItem.BillOfMaterial
                                                                                       and $projection.BillOfMaterialVariant        = _BillOfMaterialItem.BillOfMaterialVariant
                                                                                       and $projection.BillOfMaterialItemNodeNumber = _BillOfMaterialItem.BillOfMaterialItemNodeNumber
    association [0..1] to I_ChangeMaster         as _ChangeMaster              on  $projection.ChangeNumber = _ChangeMaster.ChangeNumber
{
      // ben @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key plnty                                                  as BillOfOperationsType,

      // ben @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
      @Search: {defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
  key plnnr                                                  as BillOfOperationsGroup,

      // ben @ObjectModel.foreignKey.association: '_BillOfOperations'
  key plnal                                                  as BillOfOperationsVariant,

      // ben @ObjectModel.foreignKey.association: '_BillOfOperationsSequence'
  key plnfl                                                  as BillOfOperationsSequence,

      // ben @ObjectModel.foreignKey.association: '_BOOOperationInternalID'
  key plnkn                                                  as BOOOperationInternalID,

      // ben @ObjectModel.foreignKey.association: '_BOOOpBOMItemInternalID'
  key zuonr                                                  as BOOOpBOMItemInternalID,

  key zaehl                                                  as BOOOpBOMItemIntVersCounter,

      versn                                                  as BillOfOperationsVersion,

      @Semantics.businessDate.from: true
      datuv                                                  as ValidityStartDate,
      @Semantics.businessDate.to: true
      valid_to                                               as ValidityEndDate,

      --- Administration Data ---
      @Semantics.systemDate.createdAt: true
      andat                                                  as CreationDate,
      cast(annam as vdm_createdbyuserid preserving type)     as CreatedByUser,
      @Semantics.systemDate.lastChangedAt: true
      aedat                                                  as LastChangeDate,
      cast(aenam as vdm_lastchangedbyuserid preserving type) as LastChangedByUser,

      loekz                                                  as IsDeleted,
      loekz_inherited                                        as IsImplicitlyDeleted,

      // ben @ObjectModel.foreignKey.association: '_ChangeMaster'
      aennr                                                  as ChangeNumber,

      --- Assigned Component ---
      stlty                                                  as BillOfMaterialCategory,
      stlnr                                                  as BillOfMaterial,
      stlal                                                  as BillOfMaterialVariant,
      stlkn                                                  as BillOfMaterialItemNodeNumber,

      stlty_w                                                as BillOfMaterialRootCategory,
      stlnr_w                                                as BillOfMaterialRoot,
      stlal_w                                                as BillOfMaterialRootVariant,
      kante                                                  as BillOfMaterialEdgeNumber,

      rgekz                                                  as MatlCompIsMarkedForBackflush,

      --- QM ---
      disp                                                   as ResvnIsMRPRlvtOrPurReqnIsCrted,
      // The fields IMENG and IMEIN in PLMZ are only maintained for a few task list types, e.g. 'A' and 'E'. They are NOT maintained in PLMZ for task list types 'N' and 'V'!
      imeng                                                  as BillOfMaterialItemQuantity,
      imein                                                  as BillOfMaterialItemUnit,

      //Missing field
      techv                                                  as TechnicalStatusFrom,
      parkz                                                  as IsInactiveChange,
      werk_stl                                               as Plant,
      zudiv                                                  as IntDivisorCuttingMeasure,
      zums1                                                  as CuttingMeasure1,
      zums2                                                  as CuttingMeasure2,
      zums3                                                  as CuttingMeasure3,
      zumei                                                  as UnitOfCuttingMeasure,
      stlst                                                  as OrderLevel,
      stlwg                                                  as OrderPath,
      refkn                                                  as NumberOfTaskListNode,
      aobar                                                  as TypeOfRelationship,
      beikz                                                  as MaterialProvisionIndicator,
      dauer                                                  as TimeIntervalBwRelationship,
      zeinh                                                  as UnitOfTimeIntrlBwRelationship,
      dmeng                                                  as AverageComponentQuantity,
      flgex                                                  as IsExternalProcurement,
      knttp                                                  as AccountAssignmentCategory,
      lgort                                                  as ResourceStorageLocation,
      prodflowid                                             as IndicatorProductFlow,
      strecke                                                as IsThirdPartyRequisition,
      vorab                                                  as IsPreliminaryOrder,
//            //      GP_FREET
//            //      GP_KRIT1
//            //      GP_MATNR
//            //      GP_UVORN
//            //      GP_WERKS
//      
            --- Associations
            _BillOfMaterialItem,
            _BillOfOperations,
            // !! DO NOT USE // ben @ObjectModel.association.type: [ #TO_COMPOSITION_PARENT ]
            _BillOfOperationsGroup,
            // !! DO NOT USE // ben @ObjectModel.association.type: [ #TO_COMPOSITION_ROOT ]
            _BillOfOperationsOperation,
            _BillOfOperationsSequence,
            _BillOfOperationsType,
            _BOOOpBOMItemInternalID,
            _BOOOperationInternalID,
            _ChangeMaster


}
