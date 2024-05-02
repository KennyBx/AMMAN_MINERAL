@AbapCatalog.sqlViewName: '/SIMPLE/MDSDR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG]F4 - SpecificationDeterminationRule'
define view /SIMPLE/MDSPECDETERRULE as select from qasdri_specdet 
                                  left outer join  qasdri_specdet_t on qasdri_specdet.spec_det_rule =  qasdri_specdet_t.spec_det_rule
{
    key qasdri_specdet.spec_det_rule as specificationDeterminationRule ,
    qasdri_specdet_t.langu           as locale ,
    qasdri_specdet_t.text            as description
}
