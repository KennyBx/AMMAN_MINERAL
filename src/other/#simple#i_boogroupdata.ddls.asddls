@AbapCatalog.sqlViewName: '/SIMPLE/IBOGRPDA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@AccessControl.personalData.blocking: #NOT_REQUIRED
//@Analytics.dataCategory: #DIMENSION
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: { serviceQuality: #A, sizeCategory: #M, dataClass: #MASTER }
@ObjectModel.representativeKey: 'BillOfOperationsGroup'
@ObjectModel.semanticKey: ['BillOfOperationsType', 'BillOfOperationsGroup']
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@EndUserText.label: 'Bill of Operations Group'

define view /SIMPLE/I_BOOGroupData
  as select distinct from plzu

//  association [1..1] to /SIMPLE/I_BillOfOperationType as _BillOfOperationsType on $projection.BillOfOperationsType = _BillOfOperationsType.BillOfOperationsType

{
      @ObjectModel.foreignKey.association: '_BillOfOperationsType'
  key cast(plnty as billofoperationstype preserving type)  as BillOfOperationsType,
  key cast(plnnr as billofoperationsgroup preserving type) as BillOfOperationsGroup,
      zkriz_mapl                                           as CounterMaterial,
      zkriz_eapl                                           as CounterEquipment,
      zkriz_tapl                                           as CounterFunctionalLoc,
      plnkn_plpo                                           as CounterOperation,
      pzlfh_plfh                                           as CounterPRT,
      zuonr_plmz                                           as CounterMaterialAllo,
      mlst_zaehl_mlst                                      as CounterMilestone,
      plnph_plph                                           as CounterSubCalculation,
      plnft_plft                                           as CounterProcessInstruction,
      mkmzl_plfv                                           as CounterPICharacteristic,
      zuonr_plmb                                           as CounterMaterialVersion,
      cast('            ' as aennr )                       as EngineeringChangeDocForEdit,
      cast( $session.system_date as datub )                as KeyDate
      
      // Associations
//      _BillOfOperationsType
};
