@AbapCatalog.sqlViewName: '/SIMPLE/ICHRB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey:true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Classification Characteristic Basic'
@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API

@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.dataClass: #MASTER
define view /SIMPLE/I_ClfnCharcBasic
  as select from cabn as Characteristic       
{
    key cast ( Characteristic.atinn as ngc_core_atinn preserving type ) as CharcInternalID,
    key Characteristic.adzhl      as TimeIntervalNumber,        
        Characteristic.atnam      as Characteristic,
        Characteristic.atidn      as CharcIdentificationCode,
        Characteristic.atmst      as CharcStatus,
        Characteristic.atfor      as CharcDataType,
        Characteristic.anzst      as CharcLength,
        Characteristic.anzdz      as CharcDecimals,
        Characteristic.atsch      as CharcTemplate,
        Characteristic.atkle      as ValueIsCaseSensitive,
        Characteristic.atkon      as CharcConversionRoutine,
        Characteristic.atkla      as CharcGroup,
        Characteristic.aterf      as EntryIsRequired,
        case Characteristic.atein
          when '*' then '*'
          when ''  then 'X' 
          else ''
        end as MultipleValuesAreAllowed,      
        Characteristic.unit       as CharcValueUnit,          
        Characteristic.currency   as Currency,    
        Characteristic.atdex      as CharcExponentFormat,
        Characteristic.atdim      as CharcExponentValue,
        Characteristic.atint      as ValueIntervalIsAllowed,
        Characteristic.atson      as AdditionalValueIsAllowed,
        Characteristic.atvor      as NegativeValueIsAllowed,
        @Semantics.businessDate.from: true
        Characteristic.datuv      as ValidityStartDate,
        @Semantics.businessDate.to: true
        Characteristic.datub      as ValidityEndDate,         
        Characteristic.aennr      as ChangeNumber,
        Characteristic.lkenz      as IsDeleted,
        Characteristic.dokar      as DocumentInfoRecordDocType,
        Characteristic.doknr      as DocumentInfoRecordDocNumber,
        Characteristic.dokvr      as DocumentInfoRecordDocVersion,
        Characteristic.doktl      as DocumentInfoRecordDocPart,
        Characteristic.atauth     as CharcMaintAuthGrp,
        Characteristic.atinp      as CharcIsReadOnly,
        Characteristic.atvie      as CharcIsHidden,
        Characteristic.attab      as CharcReferenceTable,
        Characteristic.atfel      as CharcReferenceTableField,
        Characteristic.atprt      as CharcCheckTable,
        Characteristic.atprf      as CharcCheckFunctionModule,
        Characteristic.atfod      as CharcEntryIsNotFormatCtrld,
        Characteristic.atvsc      as CharcTemplateIsDisplayed,
        Characteristic.auswahlmge as CharcSelectedSet,
        Characteristic.werks      as Plant,
        Characteristic.katalogart as CharcCatalogType,
        Characteristic.aname      as CreatedByUser,
        Characteristic.adatu      as CreationDate,
        Characteristic.vname      as LastChangedByUser,
        Characteristic.vdatu      as LastChangeDate,
        Characteristic.lastchangeddatetime as CharcLastChangedDateTime
}
