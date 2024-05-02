@Analytics.dataExtraction.enabled: false //Inserted by VDM CDS Suite Plugin
@ClientHandling.algorithm: #SESSION_VARIABLE //Inserted by VDM CDS Suite Plugin
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'LoadingGroup'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
//Commented by VDM CDS Suite Plugin:@ObjectModel.representativeKey: 'LoadingGroup'
//Commented by VDM CDS Suite Plugin:@ObjectModel.dataCategory: #TEXT
@EndUserText.label: 'Loading Group Text'
//Commented by VDM CDS Suite Plugin:@Analytics: { dataCategory: #TEXT, dataExtraction.enabled: true }
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck:#NOT_REQUIRED
@AbapCatalog.sqlViewName: '/SIMPLE/ILDGRPT'
@Metadata.ignorePropagatedAnnotations:true 

define view /SIMPLE/I_LoadingGroupText
as
select from tlgrt
//association [0..1] to /SIMPLE/I_LoadingGroup as _LoadingGroup on $projection.LoadingGroup = _LoadingGroup.LoadingGroup
association [0..1] to /SIMPLE/I_Language as _Language on $projection.Language = _Language.Language
{
    @ObjectModel.foreignKey.association: '_LoadingGroup'
    key ladgr as LoadingGroup,
    
    @Semantics.language
    @ObjectModel.foreignKey.association: '_Language'
    key spras as Language,

    @Semantics.text
    vtext as LoadingGroupName,
    
//    _LoadingGroup,
    _Language
};   
 