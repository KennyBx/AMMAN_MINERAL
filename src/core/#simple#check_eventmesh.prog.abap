*&---------------------------------------------------------------------*
*& Report /SIMPLE/CONFIG_EVENTMESH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT /simple/check_eventmesh.

SELECTION-SCREEN BEGIN OF BLOCK b1.

  PARAMETERS: pa_des   TYPE /simple/destination MATCHCODE OBJECT f4_rfcdestypeall MEMORY ID 1,
              pa_auth  TYPE /simple/auth_profile MATCHCODE OBJECT /simple/sh_oauth MEMORY ID 2,
              pc_uname TYPE sy-uname DEFAULT sy-uname.
SELECTION-SCREEN END OF BLOCK b1.

INCLUDE /simple/check_eventmesh_top.

INCLUDE /simple/check_eventmesh_cl.

INCLUDE /simple/check_eventmesh_i01.


START-OF-SELECTION.
  demo=>main( ).
