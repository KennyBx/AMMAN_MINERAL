@EndUserText.label: 'Search Value'
define custom entity /SIMPLE/I_SearchValue
{
  key dummyKey     : abap.char( 20 );
      fuzzySearch  : flag;
      name         : abap.string( 0 );
      value        : abap.string( 0 );
      isDisplay    : flag;
      type         : abap.string( 0 );
      _SearchField : association to parent /simple/i_searchfield on _SearchField.dummyKey = $projection.dummyKey;


}
