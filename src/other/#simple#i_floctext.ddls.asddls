@AbapCatalog.sqlViewName: '/SIMPLE/IFLOCT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Functional Location Text'
define view /SIMPLE/I_FLOCTEXT
  as select from iflotx
{
  key cast( tplnr as /simple/tplnr preserving type ) as FunctionalLocation,
      //key spras as Language,
      //  key cast( '' as abap.char( 2 ) )   as Language,
      @AbapCatalog.textLanguage
  key spras                          as Language,
      pltxt                          as Description,
      kzltx                          as LongTextExist,
      cast( '' as abap.char( 132 ) ) as LongText
}
