@EndUserText.label: 'Search Setting'
define root custom entity /SIMPLE/I_SearchSetting
{
  key dummyKey         : abap.char( 20 );
      maxHit           : /iwbep/sb_odata_ty_int2;
      isContainsSearch : flag;
      objectType       : abap.string( 0 );
      fuzzyValues      : abap.string( 0 );
      fuzzySearch      : flag;
      _SearchFields    : composition [0..*] of /simple/i_searchfield;
      _SearchResults   : composition [0..*] of /simple/i_searchresult;
}
