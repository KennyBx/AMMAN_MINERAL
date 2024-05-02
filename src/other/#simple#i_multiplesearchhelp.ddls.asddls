@EndUserText.label: '[MDG] F4 - Multiple Search Help'
define root custom entity /SIMPLE/I_MultipleSearchHelp
{
  key MultipleKey    : abap.char( 20 );
      LanguageKey    : abap.string( 0 );
      _SearchRequest : composition [0..*] of /simple/i_searchhelprequest;
}
