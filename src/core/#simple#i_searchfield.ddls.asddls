@EndUserText.label: 'Search Field'
define custom entity /SIMPLE/I_SearchField
{
  key dummyKey       : abap.char( 20 );
      navPath        : abap.string( 0 );
      _SearchSetting : association to parent /simple/i_searchsetting on _SearchSetting.dummyKey = $projection.dummyKey;
      _SearchValues  : composition [0..*] of /simple/i_searchvalue;
}
