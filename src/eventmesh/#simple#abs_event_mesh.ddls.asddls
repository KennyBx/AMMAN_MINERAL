@EndUserText.label: 'Abstract Product'                                                                                                                      
define abstract entity /SIMPLE/ABS_EVENT_MESH                                                                                                                  
{                                                                                                                                                           
//  mdglogid            : abap.char(36);                                                                                                                      
  crNumber            : abap.char(20);                                                                                                                      
  crItem              : abap.char(5);                                                                                                                       
  objType             : abap.char(100);                                                                                                                     
  mdgKey              : abap.char(255);                                                                                                                     
  status              : abap.char(1);                                                                                                                       
  step                : abap.char(2);                                                                                                                       
  messageLog          : abap.char(255);                                                                                                                     
  additionalMessage   : abap.char(255);                                                                                                                     
  activateId          : abap.char(20);                                                                                                                      
  activateItemId      : abap.char(5);                                                                                                                       
  changedat           : abap.char(8);                                                                                                                       
  changetim           : abap.char(4);                                                                                                                       
  statusLog           : abap.char(1);                                                                                                                       
  statusCode          : abap.char(3);                                                                                                                       
  timeRun             : abap.char(18);                                                                                                                      
  messagingCore       : abap.string;                                                                                                                        
  messagingObjectType : abap.string;                                                                                                                        
  resonLog            : abap.string;                                                                                                                        
}                                                                                                                                                           
                                                                                                                                                            
