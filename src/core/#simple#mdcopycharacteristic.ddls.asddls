@AbapCatalog.sqlViewName: '/SIMPLE/MDCOPMIC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] CopyModelReferenceCharacteristic'
define view /SIMPLE/MDCOPYCHARACTERISTIC as select from dd07v 
{
    key valpos     as valueKey,
    key ddlanguage as locale,
        domvalue_l as value ,
        ddtext     as description 
}where domname = 'QVOLLST'
