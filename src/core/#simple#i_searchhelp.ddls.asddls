@EndUserText.label: '[MDG] F4 - Search Help'
define custom entity /SIMPLE/I_SearchHelp
{
  key MultipleKey    : abap.char( 20 );
  key RequestKey     : abap.char( 20 );
  key DummyKey       : abap.char( 20 );
      Top            : abap.string( 0 );
      Skip           : abap.string( 0 );
      FromJoin       : abap.string( 0 );
      WhereClause    : abap.string( 0 );
      SelectFields   : abap.string( 0 );
      SearchHelpType : abap.string( 0 );
      MDTableName    : abap.string( 0 );
      _SearchField   : composition [0..*] of /simple/i_searchhelpfield;
      _SearchRequest : association to parent /simple/i_searchhelprequest on  _SearchRequest.MultipleKey = $projection.MultipleKey
                                                                         and _SearchRequest.RequestKey  = $projection.RequestKey;

}
