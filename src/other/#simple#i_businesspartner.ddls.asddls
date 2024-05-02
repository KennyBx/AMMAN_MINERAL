@AbapCatalog.sqlViewName: '/SIMPLE/IBUPA'
@EndUserText.label: 'Business Partner'
@VDM.viewType: #BASIC
@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.representativeKey: 'BusinessPartner'
@ClientHandling.algorithm : #SESSION_VARIABLE
@AccessControl.authorizationCheck:#CHECK
@Analytics : {dataCategory: #DIMENSION, dataExtraction.enabled : true}
@Metadata.allowExtensions: true
@AbapCatalog.preserveKey:true
@Metadata.ignorePropagatedAnnotations: true 
define view /SIMPLE/I_BusinessPartner
  as select from but000
//  association [0..1] to /SIMPLE/I_User               as _CreatedByUser            on $projection.CreatedByUser = _CreatedByUser.UserID
//  association [0..1] to /SIMPLE/I_User               as _LastChangedByUser        on $projection.LastChangedByUser = _LastChangedByUser.UserID
//  association [0..*] to /SIMPLE/I_BPDefaultAddr      as _DefaultAddress           on $projection.BusinessPartner = _DefaultAddress.BusinessPartner //to be used
//  association [0..1] to /SIMPLE/I_BPCurDefltAddress  as _CurrentDefaultAddress    on $projection.BusinessPartner = _CurrentDefaultAddress.BusinessPartner
//  association [0..*] to /SIMPLE/I_BP_to_BP_Role      as _BusinessPartnerRole      on $projection.BusinessPartner = _BusinessPartnerRole.BusinessPartner
//  association [0..*] to /SIMPLE/I_Addressindemail    as _AddressIndependentEmail  on $projection.IndependentAddressID = _AddressIndependentEmail.AddressID
//  association [0..*] to /SIMPLE/I_Addressindfax      as _AddressIndependentFax    on $projection.IndependentAddressID = _AddressIndependentFax.AddressID
//  association [0..*] to /SIMPLE/I_Addressindphone    as _AddressIndependentPhone  on $projection.IndependentAddressID = _AddressIndependentPhone.AddressID
//  association [0..*] to /SIMPLE/I_Addressindmobile   as _AddressIndependentMobile on $projection.IndependentAddressID = _AddressIndependentMobile.AddressID
//  association [0..*] to /SIMPLE/I_Industries         as _Industries               on $projection.Industry = _Industries.IndustrySector
////  association [0..*] to /SIMPLE/I_BPIndustry         as _BusinessPartnerIndustry  on $projection.BusinessPartner = _BusinessPartnerIndustry.BusinessPartner
//
//  association [0..1] to E_BP_D                       as _BusinessPartnerExt       on $projection.BusinessPartner = _BusinessPartnerExt.BusinessPartner
//
//  association [0..*] to /SIMPLE/I_AcademicTitleText  as _AcademicTitleText        on $projection.AcademicTitle = _AcademicTitleText.AcademicTitle
//
//  association [0..1] to /SIMPLE/I_AcademicTitle      as _AcademicTitleValueHelp   on $projection.AcademicTitle = _AcademicTitleValueHelp.AcademicTitle

{
        // Fields valid for all types of business partner
        @ObjectModel.text.element: [ 'BusinessPartnerName' ]
  key   but000.partner                                                       as  BusinessPartner,
        but000.type                                                          as  BusinessPartnerCategory,
        but000.augrp                                                         as  AuthorizationGroup,
        but000.partner_guid                                                  as  BusinessPartnerUUID,
        but000.persnumber                                                    as  PersonNumber,


        // Fields for ETag calculation
        case when but000.chusr <> '' then CONCAT(but000.chusr, CONCAT( but000.chdat, but000.chtim ) )
              else CONCAT(but000.crusr, CONCAT( but000.crdat, but000.crtim ) )
           end                                                               as  ETag,


        @Semantics.text: true
        @EndUserText.label: 'Business Partner Name'
        @EndUserText.quickInfo:'BUSINESS PARTNER NAME'
        case   when type = '1'
                 then concat_with_space( name_first, name_last, 1)
               when type = '2'
        //workaround to add the space: name_org1+' '+name_org2
                 then   concat_with_space( name_org1, name_org2, 1)
               when type = '3'
        //workaround to add the space: name_grp1+' '+name_grp2
                 then  concat_with_space( name_grp1, name_grp2, 1)
 //          else '' //add this to avoid the warning    For performance , this is commented - GOPAL GUPTA
             end                                                             as  BusinessPartnerName,
        @Semantics.text: true
        case
          when type = '1'
              then concat_with_space( name_first, name_last,1)
          when type = '2'
               then concat_with_space( name_org1, name_org2,1)  //KF: diffierent with S4
          when type = '3'
               then concat_with_space( name_grp1, name_grp2,1)  //KF: diffierent with S4
     //     else '' //add this to avoid the warning
        end                                                                  as  BusinessPartnerFullName,
        but000.crusr                                                         as  CreatedByUser,
        but000.crdat                                                         as  CreationDate,
        but000.crtim                                                         as  CreationTime,
        but000.chusr                                                         as  LastChangedByUser,
        but000.chdat                                                         as  LastChangeDate,
        but000.chtim                                                         as  LastChangeTime,
        but000.xblck                                                         as  BusinessPartnerIsBlocked

        // Fields valid only for but000.type = '1' -- Person
  ,
        but000.xpcpt                                                         as  IsBusinessPurposeCompleted,
        but000.name_first                                                    as  FirstName,
        but000.name_last                                                     as  LastName,
        
        @Semantics.text:true 

        // Has to check for other BP types
        but000.name1_text                                                    as  PersonFullName,

        // Fields valid only for but000.type = '2' -- Organization

        but000.name_org1                                                     as  OrganizationBPName1 // was renamed from OrganisationName1
  ,
        but000.name_org2                                                     as  OrganizationBPName2 //was renamed from OrganisationName2
  ,
        but000.name_org3                                                     as  OrganizationBPName3,
        but000.name_org4                                                     as  OrganizationBPName4


  ,
        but000.location_1                                                    as  InternationalLocationNumber1,
        but000.location_2                                                    as  InternationalLocationNumber2,
        but000.location_3                                                    as  InternationalLocationNumber3,

        //Fields Needed in BP Customer-Supplier Apps
        but000.legal_enty                                                    as  LegalForm,
        but000.found_dat                                                     as  OrganizationFoundationDate,
        but000.liquid_dat                                                    as  OrganizationLiquidationDate,
        but000.ind_sector                                                    as  Industry,
        but000.natpers                                                       as  IsNaturalPerson,

        but000.xsexf                                                         as  IsFemale,
        but000.xsexm                                                         as  IsMale,
        but000.xsexu                                                         as  IsSexUnknown, //GFN not available
        but000.title                                                         as  FormOfAddress,
//        @ObjectModel: {
//                 foreignKey.association: '_AcademicTitleValueHelp'
//               }
//        @ObjectModel.text.association: '_AcademicTitleText'
        but000.title_aca1                                                    as  AcademicTitle, //GFN not available
        but000.title_aca2                                                    as  AcademicTitle2,
        but000.nameformat                                                    as  NameFormat,    //GFN not available
        but000.namcountry                                                    as  NameCountry,   //GFN not available

        but000.bu_group                                                      as  BusinessPartnerGrouping,

        but000.bpkind                                                        as  BusinessPartnerType,
        but000.namemiddle                                                    as  MiddleName,
        but000.name_lst2                                                     as  AdditionalLastName,
        but000.name_grp1                                                     as  GroupBusinessPartnerName1,
        but000.name_grp2                                                     as  GroupBusinessPartnerName2,
        but000.langu_corr                                                    as  CorrespondenceLanguage,
        but000.bu_langu                                                      as  Language,
        but000.bu_sort1                                                      as  SearchTerm1,
        //Search term 2 field needed in Customer and Suppplier apps
        but000.bu_sort2                                                      as  SearchTerm2,
        but000.mc_name1                                                      as  BPLastNameSearchHelp,
        but000.mc_name2                                                      as  BPFirstNameSearchHelp,
        but000.nickname                                                      as  BusinessPartnerNicknameLabel,
        

        //Added 19/05/2016 for correct association to address independent communication fields
        but000.addrcomm                                                      as  IndependentAddressID,

        //for extensibility
        cast( 'X' as sdraft_is_active preserving type )                      as  IsActiveEntity,


        but000.birthdt                                                       as  BirthDate, //newly added
        but000.xdele                                                         as  IsMarkedForArchiving,
        but000.contact                                                       as  ContactPermission,
        but000.bpext                                                         as  BusinessPartnerIDByExtSystem,
        but000.legal_org                                                     as  LegalEntityOfOrganization,

        //Added 13/09/2017 - CDS enhancements for Business Partner app
        but000.milve                                                         as  TrdCmplncLicenseIsMilitarySctr,
        but000.nuc_sec                                                       as  TrdCmplncLicenseIsNuclearSctr,
        but000.print_mode                                                    as  BusinessPartnerPrintFormat,
        but000.source                                                        as  BusinessPartnerDataOriginType,
        but000.not_released                                                  as  BusinessPartnerIsNotReleased,

        // Added 10/01/2017 - Requested in internal incident 1880004533
        but000.not_lg_competent                                              as  IsNotContractuallyCapable,
        
        but000.jobgr                                    as BusinessPartnerOccupation,
        but000.marst                                    as BusPartMaritalStatus,
        but000.natio                                    as BusPartNationality,
        
        // Fields valid for all types of business partner

        //       @VDM.deprecated:true
        //       //Please use from association as _CurrentDefaultAddress.AddressID as this field will be removed soon from the view
        //       _CurrentDefaultAddress.AddressID  //actually CurrentAddressID, shortened for compatibility reasons
        // add missing field 04082020
        but000.birthpl                                 as BirthPlace,
        but000.deathdt                                 as DeathDate,
        but000.emplo                                   as Employer,
        but000.cndsc                                   as CountryOfOrigin
//        but000.zz1_custom2_bus                         as ZZ1_Custom2_bus,
//        but000.zz1_custom1_bus                         as ZZ1_Custom1_bus,
        
 
//        
//        _DefaultAddress // all default addresses over time (to-n) to be used instead of _DefaultAddresses
//  ,
//        _CurrentDefaultAddress //single current default address (to-1) exposed for use in customer object page
//
////                , @VDM.deprecated:true //Please use from association as _CurrentDefaultAddress._StandardAddress as this field will be removed soon from the view
////                _StandardAddress // removed. use _CurrentDefaultAddress
//
//  ,
//        _BusinessPartnerRole,
//        _CreatedByUser,
//        _LastChangedByUser
//
//  ,
//        _AddressIndependentEmail,
//        _AddressIndependentFax,
//        _AddressIndependentPhone,
//        _AddressIndependentMobile,
//        _Industries,
//        _AcademicTitleValueHelp,
//        _AcademicTitleText
////        _BusinessPartnerIndustry
}
