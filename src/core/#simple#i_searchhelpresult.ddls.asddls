@EndUserText.label: '[MDG] F4 - Search Help Result'
define custom entity /SIMPLE/I_SearchHelpResult
{
  key MultipleKey    : abap.char( 20 );
  key RequestKey     : abap.char( 20 );
      Value          : abap.string( 0 );
      _SearchRequest : association to parent /simple/i_searchhelprequest on  _SearchRequest.MultipleKey = $projection.MultipleKey
                                                                         and _SearchRequest.RequestKey  = $projection.RequestKey;

}
