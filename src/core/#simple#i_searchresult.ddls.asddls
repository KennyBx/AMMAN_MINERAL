@EndUserText.label: 'Search Result'
define custom entity /SIMPLE/I_SearchResult
{
  key dummyKey       : abap.char( 20 );
      value          : abap.string( 0 );
      _SearchSetting : association to parent /simple/i_searchsetting on _SearchSetting.dummyKey = $projection.dummyKey;
}
