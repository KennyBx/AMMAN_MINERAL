@EndUserText.label: 'Convert PPA ReqID/Bus.Key for PPN tables'
define table function /SIMPLE/TF_DocInfRcdObjectLink
  with parameters
    @Environment.systemField: #CLIENT
    clnt : abap.clnt
returns
{
  CLIENT               : mandt;
  LinkedSAPObject      : dokob;
  LinkedSAPObjectKey   : objky;
  DocObjectLinkCounter : obzae;
  GUID                 : cs_guidb;
}
implemented by method
  /simple/cl_convertion_amdp=>convert_raw_to_char;
