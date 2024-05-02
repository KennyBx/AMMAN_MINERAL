@AbapCatalog.sqlViewName: '/SIMPLE/MDKEI'
@AbapCatalog.compiler.compareFilter: true 
@AccessControl.authorizationCheck: #CHECK 
@EndUserText.label: 'MDPRIKEYCOMBINATIONI'
define view /SIMPLE/MDPRIKEYCOMBINATIONI   
    as select from /SIMPLE/MDPRIKEYCOMBINATIONA  as KEYC  
{
    
    key conditionType,  
    key conditionTableNumber,    
    key locale,   
    key counter,
    key techField,  
        fieldDescription,  
        tableDescription
}where type ='I' 
    
