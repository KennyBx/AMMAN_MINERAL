@AbapCatalog.sqlViewName: '/SIMPLE/CFLOCT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'FLOCText'
define view /SIMPLE/C_FLOCText
  as select from /SIMPLE/I_FLOCTEXT
  association to parent /SIMPLE/C_FunctionalLocation as _FunctionalLocation
  on  $projection.functionalLocation = _FunctionalLocation.functionalLocation
{
  key FunctionalLocation             as functionalLocation,
      //key spras as Language,
  key Language                       as language,
      Description                    as description,
      LongTextExist                  as longTextExist,
      LongText                       as longText,

      /* SimpleMDG specific fields for integration */
      cast( '' as abap.char( 10 ) )  as action,
      cast( '' as abap.char( 999 ) ) as mdgMarkForChange,
      cast( '' as abap.char( 10 ) )  as actionMode,
      cast( '' as abap.char( 20 ) )  as activateID,
      cast( '' as abap.char( 20 ) )  as activateItemID,
      _FunctionalLocation
}
