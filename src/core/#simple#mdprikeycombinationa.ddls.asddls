@AbapCatalog.sqlViewName: '/SIMPLE/MDKEA'
@AbapCatalog.compiler.compareFilter: true 
@AccessControl.authorizationCheck: #CHECK 
@EndUserText.label: 'MDPRIKEYCOMBINATIONA'
define view /SIMPLE/MDPRIKEYCOMBINATIONA 
    as select from /SIMPLE/MDPRIKEYCOMBINATION  as KEYC
        left outer join /simple/prispeci as spec on  spec.kschl     = KEYC.conditionType 
                                                 and spec.kotabnr   = KEYC.conditionTableNumber
                                                 and spec.dzifna    = KEYC.techField
{
      
    key conditionType,  
    key conditionTableNumber,    
    key locale,   
    key counter,
    key techField,  
        case  
            when spec.type is null and techField <> 'MATNR' then cast( 'H' as /simple/epri_fieldtype ) 
            when spec.type is null and techField = 'MATNR' then cast( 'I' as /simple/epri_fieldtype )    
            else spec.type
            end as type,  
        //spec.type as type,
        fieldDescription,  
        tableDescription
} //where conditionTableNumber = '509' and conditionType = 'ZSIP' and locale = 'E'
where locale = 'E'

