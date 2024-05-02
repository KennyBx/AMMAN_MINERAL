@AbapCatalog.preserveKey: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@AbapCatalog.sqlViewName: '/SIMPLE/ICCDESC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Classification Characteristic Description'
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API

@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'CharcInternalID'
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER
define view /SIMPLE/I_ClfnCharcDesc
  as select from cabnt as CharcDesc
  
      association [0..1] to /SIMPLE/I_Language as _Language 
        on $projection.Language = _Language.Language
{
  key cast ( CharcDesc.atinn as ngc_core_atinn preserving type ) as CharcInternalID,
      @ObjectModel.foreignKey.association: '_Language'
      @Semantics.language: true
  key CharcDesc.spras as Language,
      @ObjectModel.foreignKey.association: null
  key CharcDesc.adzhl as TimeIntervalNumber,
      @Semantics.text: true
      CharcDesc.atbez as CharcDescription,
      CharcDesc.aennr as ChangeNumber,
      @Semantics.businessDate.from: true
      CharcDesc.datuv as ValidityStartDate,
      @Semantics.businessDate.to: true
      CharcDesc.datub as ValidityEndDate,
      CharcDesc.lkenz as IsDeleted,
      
      _Language
}

