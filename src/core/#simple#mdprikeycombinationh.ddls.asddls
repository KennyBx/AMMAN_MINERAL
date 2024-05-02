@AbapCatalog.sqlViewName: '/SIMPLE/MDKEH'
@AbapCatalog.compiler.compareFilter: true 
@AccessControl.authorizationCheck: #CHECK 
@EndUserText.label: 'MDPRIKEYCOMBINATIONH'
define view /SIMPLE/MDPRIKEYCOMBINATIONH  
    as select from /SIMPLE/MDPRIKEYCOMBINATIONA  as KEYC  
{
    
    key conditionType,  
    key conditionTableNumber,    
    key locale,   
    key counter,
    key techField,  
        fieldDescription,  
        tableDescription
}where type ='H'
