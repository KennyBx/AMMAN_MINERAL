@AbapCatalog.sqlViewName: '/SIMPLE/MDUOMMA1'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '[MDG] F4 - Unit of measure Material'
define view /SIMPLE/MDUOMMATERIAL1
  as 
  //select distinct from mara as MARA 
//{
//  key mara.matnr    as Material,
//  key '    '        as PlantID,
//      mara.meins    as UnitOfMeasure,
//      'X'           as BaseUnit,
//      ''            as UnitOfIssue
//}
//union 
  select distinct from mara as MARA1 
  inner join marc as MARC1 on MARA1.matnr = MARC1.matnr
  inner join marm as MARM1 on MARA1.matnr = MARM1.matnr 
{
  key MARA1.matnr   as Material,
  key MARC1.werks   as PlantID,
  key MARM1.meinh as UnitOfMeasure,
      //case
      //when MARC1.ausme is not initial
      //then MARC1.ausme 
      //else MARA1.meins
      //end as UnitOfMeasure,
      
      case
      //when MARC1.ausme = MARM1.meinh 
      when MARA1.meins <> MARM1.meinh
      then '' 
      else 'X'
      end as BaseUnit,
      
      case
      when MARC1.ausme is not initial
      then 'X' 
      else ''
      end as UnitOfIssue
}
