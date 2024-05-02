@EndUserText.label: '[MDG] F4 - Search Help Request'
define custom entity /SIMPLE/I_SearchHelpRequest
{
  key MultipleKey     : abap.char( 20 );
  key RequestKey      : abap.char( 20 );
      MDTableName     : abap.string( 0 );
      Type            : abap.string( 0 );
      _SearchHelp     : composition [0..*] of /simple/i_searchhelp;
      _SearchResult   : composition [0..*] of /simple/i_searchhelpresult;
      _MultipleSearch : association to parent /simple/i_multiplesearchhelp on _MultipleSearch.MultipleKey = $projection.MultipleKey;

}
