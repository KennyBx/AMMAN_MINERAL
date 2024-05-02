@AbapCatalog.sqlViewName: '/SIMPLE/IINDTRY'
@EndUserText.label: 'I_Industries'
@VDM.viewType: #BASIC
@ClientHandling.algorithm: #SESSION_VARIABLE

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #MASTER
@AccessControl.authorizationCheck: #NOT_REQUIRED

define view /SIMPLE/I_Industries
  as select from tb038a

//  association [0..*] to /SIMPLE/I_Industrykeytexts       as _IndustryKeyText       on  tb038a.istype = _IndustryKeyText.IndustrySystemType

//  association [0..*] to /SIMPLE/I_Indkeysystemtexts as _IndustryKeySystemText on  tb038a.istype     = _IndustryKeySystemText.IndustrySystemType
//                                                                           and tb038a.ind_sector = _IndustryKeySystemText.IndustrySector


{

      @ObjectModel.text.association: '_IndustryKeyText'

  key tb038a.istype                        as IndustrySystemType,

//      @ObjectModel.text.association: '_IndustryKeySystemText'

  key tb038a.ind_sector                    as IndustrySector

//  , both text fields blow up cardinality. use associated text
//      _IndustryKeyText.IndustryName        as IndustryName
      //, _IndustryKeySystemText.text  as IndustrySystemName

      //Make association public
//  ,
//      _IndustryKeySystemText,
//      _IndustryKeyText
}   
  
  
  
 