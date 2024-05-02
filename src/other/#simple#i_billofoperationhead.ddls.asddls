@AbapCatalog.sqlViewName: '/SIMPLE/IBOOPHDR'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #BASIC
@Analytics: {dataCategory: #DIMENSION}
@ClientHandling.algorithm: #SESSION_VARIABLE
// @ObjectModel.representativeKey: 'BOOInternalVersionCounter'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Bill of Operations Header'
// @ObjectModel.usageType: { serviceQuality: #B, sizeCategory: #M, dataClass: #MASTER }
@Metadata.allowExtensions: true
@AbapCatalog.preserveKey:true

define view /SIMPLE/I_BillOfOperationHead
  as select from plko

//  association [1..1] to /SIMPLE/I_BOOTypeText          as _BillOfOperationsType       on  $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType
//  association [1..1] to /SIMPLE/I_BillOfOperationGroup as _BillOfOperationsGroup      on  $projection.BillOfOperationsType  = _BillOfOperationsGroup.BillOfOperationsType
//                                                                                      and $projection.BillOfOperationsGroup = _BillOfOperationsGroup.BillOfOperationsGroup
//  -- to root, to parent
//  association [1..1] to I_BillOfOperations             as _BillOfOperations           on  $projection.BillOfOperationsType    = _BillOfOperations.BillOfOperationsType
//                                                                                      and $projection.BillOfOperationsGroup   = _BillOfOperations.BillOfOperationsGroup
//                                                                                      and $projection.BillOfOperationsVariant = _BillOfOperations.BillOfOperationsVariant
//
//  association [1..1] to /SIMPLE/I_User                 as _CreatedByUser              on  $projection.CreatedByUser = _CreatedByUser.UserID
//  association [0..1] to /SIMPLE/I_User                 as _LastChangedByUser          on  $projection.LastChangedByUser = _LastChangedByUser.UserID
//  association [1..1] to /SIMPLE/I_Plant                as _Plant                      on  $projection.Plant = _Plant.Plant
//
//  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
//  association [0..1] to /SIMPLE/I_WorkCenterType       as _WorkCenterType             on  $projection.WorkCenterTypeCode = _WorkCenterType.WorkCenterTypeCode
//  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
//  association [0..1] to /SIMPLE/I_WorkCenter           as _WorkCenter                 on  $projection.WorkCenterTypeCode   = _WorkCenter.WorkCenterTypeCode
//                                                                                      and $projection.WorkCenterInternalID = _WorkCenter.WorkCenterInternalID
//  association [1..1] to /SIMPLE/I_BillOfOperationUsage as _BillOfOperationsUsage      on  $projection.BillOfOperationsUsage = _BillOfOperationsUsage.BillOfOperationsUsage
//  association [1..1] to /SIMPLE/I_BOOStatus            as _BillOfOperationsStatus     on  $projection.BillOfOperationsStatus = _BillOfOperationsStatus.BillOfOperationsStatus
//  association [1..1] to I_ResponsiblePlannerGroup      as _ResponsiblePlannerGroup    on  $projection.ResponsiblePlannerGroup = _ResponsiblePlannerGroup.ResponsiblePlannerGroup
//                                                                                      and $projection.Plant                   = _ResponsiblePlannerGroup.Plant
//  association [1..1] to /SIMPLE/I_UnitOfMeasure        as _BillOfOperationsUnit       on  $projection.BillOfOperationsUnit = _BillOfOperationsUnit.UnitOfMeasure
//  association [0..1] to I_InspSubsetFieldCombination   as _InspSubsetFieldCombination on  $projection.InspSubsetFieldCombination = _InspSubsetFieldCombination.InspSubsetFieldCombination
//  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
//  association [0..1] to I_SampleDrawingProcedure       as _SampleDrawingProcedure     on  $projection.SmplDrawingProcedure = _SampleDrawingProcedure.SmplDrawingProcedure
//  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
//  association [0..1] to I_SmplDrwgProcedureVersion     as _SmplDrwgProcedureVersion   on  $projection.SmplDrawingProcedure        = _SmplDrwgProcedureVersion.SmplDrawingProcedure
//                                                                                      and $projection.SmplDrawingProcedureVersion = _SmplDrwgProcedureVersion.SmplDrawingProcedureVersion
//  association [0..1] to I_MaintenanceStrategy          as _MaintenanceStrategy        on  $projection.MaintenanceStrategy = _MaintenanceStrategy.MaintenanceStrategy
//  /*+[hideWarning] { "IDS" : [ "CALCULATED_FIELD_CHECK" ] } */
//  association [0..1] to I_InspPartialLotAssignment     as _InspPartialLotAssignment   on  $projection.InspectionPartialLot = _InspPartialLotAssignment.InspectionPartialLotAssignment
//  association [0..1] to I_InspectionLotDynamicLevel    as _InspectionLotDynamicLevel  on  $projection.InspectionLotDynamicLevel = _InspectionLotDynamicLevel.InspectionLotDynamicLevel
//  association [0..1] to I_InspLotDynamicRule           as _InspLotDynamicRule         on  $projection.InspLotDynamicRule = _InspLotDynamicRule.InspLotDynamicRule
//  association [0..1] to I_LineHierarchy                as _LineHierarchy              on  $projection.LineHierarchyInternalID = _LineHierarchy.LineHierarchyInternalID
//  association [0..1] to /SIMPLE/I_ChangeMaster         as _ChangeMaster               on  $projection.ChangeNumber = _ChangeMaster.ChangeNumber
//  association [0..1] to I_InspExtNumberingOfValues     as _InspExtNumbering           on  $projection.InspExternalNumberingOfValues = _InspExtNumbering.InspExternalNumberingOfValues
//
//  association [0..1] to /SIMPLE/I_Material             as _Assembly                   on  $projection.Assembly = _Assembly.Material
//  association [0..1] to /SIMPLE/I_Plant                as _MaintenancePlanningPlant   on  $projection.MaintenancePlanningPlant = _MaintenancePlanningPlant.Plant
//  association [0..1] to I_MaintOperationSystCondition  as _OperationSystemCondition   on  $projection.OperationSystemCondition = _OperationSystemCondition.OperationSystemCondition
//
//  association [0..1] to /SIMPLE/I_ControllingArea      as _ControllingArea            on  $projection.ControllingArea = _ControllingArea.ControllingArea
//  //  Association to I_WBSElementBasicData can't be used as this is the operational WBS.
//  //  Here we need the standard WBS, but there is no I_StandardWBSByInternalKey available, this no association ca be supplied
//  //  association [0..1] to I_WBSElementBasicData         as _WBSElementBasicData        on  $projection.WBSElementInternalID = _WBSElementBasicData.WBSElementInternalID
//  association [0..1] to /SIMPLE/I_Indicator            as _ConfigurableIndicator      on  $projection.BillOfOperationIsConfigurable = _ConfigurableIndicator.IndicatorValue
//  association [0..1] to /SIMPLE/I_Language             as _LongTextLanguage           on  $projection.LongTextLanguageCode = _LongTextLanguage.Language

{
      // @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key plko.plnty                                                  as BillOfOperationsType,

      // @ObjectModel.foreignKey.association: '_BillOfOperationsGroup'
  key plko.plnnr                                                  as BillOfOperationsGroup,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BillOfOperationsStdVH', element: 'BillOfOperationsVariant' } } ]
      // @ObjectModel.foreignKey.association: '_BillOfOperations'
  key plko.plnal                                                  as BillOfOperationsVariant,
      // @ObjectModel.text.element: 'BillOfOperationsDesc'
  key plko.zaehl                                                  as BOOInternalVersionCounter,

      // NOT a key field in THIS view !
      plko.versn                                                  as BillOfOperationsVersion,

      // ***************** Technical fields not on the CEWB-UI *****************

      plko.loekz                                                  as IsDeleted,
      plko.loekz_inherited                                        as IsImplicitlyDeleted,

      // @ObjectModel.foreignKey.association: '_WorkCenterType'
      case when plko.arbty = '  ' and plko.arbid <> '00000000' then 'A '
      else plko.arbty end                                         as WorkCenterTypeCode,
//      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_WorkCenterStdVH', element: 'WorkCenterInternalID' } } ]
//      // @ObjectModel.foreignKey.association: '_WorkCenter'
      plko.arbid                                                  as WorkCenterInternalID,

      // *************************** Header general ****************************

      -- General data
      @Semantics.text: true
      plko.ktext                                                  as BillOfOperationsDesc,

//      // @ObjectModel.foreignKey.association: '_LongTextLanguage'
      plko.txtsp                                                  as LongTextLanguageCode,

      // @ObjectModel.foreignKey.association: '_Plant'
      plko.werks                                                  as Plant,

      // @ObjectModel.foreignKey.association: '_BillOfOperationsUsage'
      plko.verwe                                                  as BillOfOperationsUsage,

      // @ObjectModel.foreignKey.association: '_BillOfOperationsStatus'
      plko.statu                                                  as BillOfOperationsStatus,

      // @ObjectModel.foreignKey.association: '_ResponsiblePlannerGroup'
      plko.vagrp                                                  as ResponsiblePlannerGroup,

      @Semantics.quantity.unitOfMeasure: 'BillOfOperationsUnit'
      @DefaultAggregation: #MIN
      plko.losvn                                                  as MinimumLotSizeQuantity,
      @Semantics.quantity.unitOfMeasure: 'BillOfOperationsUnit'
      @DefaultAggregation: #MAX
      plko.losbs                                                  as MaximumLotSizeQuantity,
      // @ObjectModel.foreignKey.association: '_BillOfOperationsUnit'
      @Semantics.unitOfMeasure: true
      plko.plnme                                                  as BillOfOperationsUnit,

      plko.plnnr_alt                                              as ReplacedBillOfOperations,

      plko.delkz                                                  as IsMarkedForDeletion,

      -- Production line
      // @ObjectModel.foreignKey.association: '_LineHierarchy'
      plko.st_arbid                                               as LineHierarchyInternalID,

      // ************************* Quality Management **************************

      -- Parameter for dynamic modification/inspection points
      // @ObjectModel.foreignKey.association: '_InspSubsetFieldCombination'
      cast (plko.slwbez as vdm_qslwbez preserving type )          as InspSubsetFieldCombination,

      // @ObjectModel.foreignKey.association: '_InspPartialLotAssignment'
      cast (plko.ppkztlzu as vdm_qppkztlzu preserving type )      as InspectionPartialLot,

      // @ObjectModel.foreignKey.association: '_SampleDrawingProcedure'
      cast (plko.qprziehver as vdm_qprziehver preserving type )   as SmplDrawingProcedure,
      // @ObjectModel.foreignKey.association: '_SmplDrwgProcedureVersion'
      plko.qversnprzv                                             as SmplDrawingProcedureVersion,

      // @ObjectModel.foreignKey.association: '_InspectionLotDynamicLevel'
      cast (plko.qdynhead as vdm_qdynhead preserving type )       as InspectionLotDynamicLevel,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_InspLotDynamicRuleStdVH', element: 'InspLotDynamicRule' } } ]
      // @ObjectModel.foreignKey.association: '_InspLotDynamicRule'
      plko.qdynregel                                              as InspLotDynamicRule,

      // @ObjectModel.foreignKey.association: '_MaintenanceStrategy'
      plko.strat                                                  as MaintenanceStrategy,

      -- Further QM data
      // @ObjectModel.foreignKey.association: '_InspExtNumbering'
      plko.extnum                                                 as InspExternalNumberingOfValues,

      // @ObjectModel.foreignKey.association: '_MaintenancePlanningPlant'
      plko.iwerk                                                  as MaintenancePlanningPlant,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_MaterialStdVH', element: 'Material' } } ]
      // @ObjectModel.foreignKey.association: '_Assembly'
      plko.istru                                                  as Assembly,
      // @ObjectModel.foreignKey.association: '_OperationSystemCondition'
      plko.anlzu                                                  as OperationSystemCondition,
      plko.adpsp                                                  as ReferenceElement,

      // @ObjectModel.foreignKey.association: '_ControllingArea'
      plko.kokrs                                                  as ControllingArea,
      //      // @ObjectModel.foreignKey.association: '_WBSElementBasicData'
      cast(plko.pspnr as ps_s4_pspnr preserving type)             as WBSElementInternalID,
      // @ObjectModel.foreignKey.association: '_ConfigurableIndicator'
      plko.kzkfg                                                  as BillOfOperationIsConfigurable,

      // The conversion from DEC16 to DEC15 is intended (needed for BW extraction). Entries of plko.tstmp_bw are always DEC15 anyways.
      cast(plko.tstmp_bw as tzntstmps)                            as BillOfOperationsDateTime,

      // *************************** Administration ****************************

      -- Administrative Data
      @Semantics.systemDate.createdAt: true
      plko.andat                                                  as CreationDate,
      @Semantics.user.createdBy: true
      cast(plko.annam as vdm_createdbyuserid preserving type)     as CreatedByUser,

      @Semantics.systemDate.lastChangedAt: true
      plko.aedat                                                  as LastChangeDate,
      @Semantics.user.lastChangedBy: true
      cast(plko.aenam as vdm_lastchangedbyuserid preserving type) as LastChangedByUser,
      case plko.changeddatetime
        when 0 then cast( '19000101010101' as tzntstmps )
        else plko.changeddatetime   end                           as ChangedDateTime,

      -- Validity
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ChangeMasterStdVH', element: 'ChangeNumber' } } ]
      // @ObjectModel.foreignKey.association: '_ChangeMaster'
      plko.aennr                                                  as ChangeNumber,
      @Semantics.businessDate.from: true
      cast(plko.datuv as pph_begda preserving type)               as ValidityStartDate,
      @Semantics.businessDate.to: true
      cast(plko.valid_to as pph_endda preserving type)            as ValidityEndDate,

      -- Additional Data
      plko.reodat                                                 as LastReorganizationDate,
      plko.abdat                                                  as LastUsageDate,
      plko.abanz                                                  as NumberOfUsages,

      --Effectivity Type in Planning Routing
      plko.efftyp                                                 as EffectivityType,

      -- Industry fields
      // A&D: Task list has an operation which is referenced in another task list, which maybe again has referenced operations.
      //      It has no other "own" operation, only referenced.
      xhiertl                                                     as TaskListIsHierarchical,

      --Start add missing field
      plko.aeszn                                                  as DocumentChangeNumber,
      plko.arbty                                                  as ObjectType,
      plko.bmsch                                                  as BaseQuantity,
      plko.ccoaa                                                  as ChangeType,
      plko.chrule                                                 as ChangeRule,
      plko.clndr                                                  as CleanoutRecipe,
      plko.flg_capo                                               as RecalcuateStdValueCAPPOrder,
      plko.flg_chk                                                as ConsistencyCheckIndicator,
      plko.meinh                                                  as UnitOfMeasureOperation,
      plko.mes_routingid                                          as MESRoutingID,
      plko.ms_flag                                                as MultipleSpecIndicator,
      plko.netid                                                  as ResourceObjectID,
      plko.parkz                                                  as InactiveChangesIndicator,
      plko.ppkztlzu                                               as InspPartialLotAssignment,
      plko.ppool                                                  as MaintenancePackagePool,
      plko.profidnetz                                             as Profile,
      plko.prtyp                                                  as ProcessType,
      plko.qdynstring                                             as InspLotDynamicCriteria,
      plko.qkzraster                                              as InspectionPoint,
      plko.qvecode                                                as AutoUsageDecisionCode,
      plko.qvedatum                                               as AUDCreationDate,
      plko.qvegruppe                                              as AUDCodeGroup,
      plko.qvemenge                                               as AUDSelectedSet,
      plko.qveversion                                             as AutoUsageDecisionVersion,
      plko.qvewerks                                               as AUDPlantOfSelectedSet,
      plko.stlal                                                  as BillOfMaterialVariant,
      plko.stlnr                                                  as BillOfMaterial,
      plko.stlty                                                  as BillOfMaterialCategory,
      plko.stupr                                                  as SetupRecipe,
      plko.techv                                                  as TechnicalStatusFrom,
      plko.ttras                                                  as InteralPeriodPattern,
      plko.umren                                                  as DenominatorForConvertingUOM,
      plko.umrez                                                  as NumeratorForConvertingUOM,
      substring(plko.qdynstring, 1, 1)                            as MaterialDynamicCriteria,
      substring(plko.qdynstring, 2, 1)                            as SupplierDynamicCriteria,
      substring(plko.qdynstring, 3, 1)                            as ManufacturerDynamicCriteria,
      substring(plko.qdynstring, 4, 1)                            as CustomerDynamicCriteria,
      substring(plko.qdynstring, 5, 1)                            as MachineDynamicCriteria,
      substring(plko.qdynstring, 6, 1)                            as ProjectDynamicCriteria
      --End add missing field


      // **************************** Associations *****************************

//      _Assembly,
//      _BillOfOperations,
//      _BillOfOperationsGroup,
//      _BillOfOperationsStatus,
//      _BillOfOperationsType,
//      _BillOfOperationsUnit,
//      _BillOfOperationsUsage,
//      _ChangeMaster,
//      _ControllingArea,
//      _CreatedByUser,
//      _ConfigurableIndicator,
//      _InspExtNumbering,
//      _InspLotDynamicRule,
//      _InspPartialLotAssignment,
//      _InspSubsetFieldCombination,
//      _InspectionLotDynamicLevel,
//      _LastChangedByUser,
//      _LineHierarchy,
//      _LongTextLanguage,
//      _MaintenancePlanningPlant,
//      _MaintenanceStrategy,
//      _OperationSystemCondition,
//      _Plant,
//      _ResponsiblePlannerGroup,
//      _SampleDrawingProcedure,
//      _SmplDrwgProcedureVersion,
//      //      _WBSElementBasicData,
//      _WorkCenter,
//      _WorkCenterType
}
