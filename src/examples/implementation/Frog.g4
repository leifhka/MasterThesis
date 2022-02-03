grammar Frog;

import stOTTR;

frogDoc
    : ( directive
    | function
    | functionCall )* EOF ;

function
    : functionHead '::' functionBody '.'
    ;

functionHead
    : definition genericParameters* parameters returnType
    ;

definition
    : 'def' name
    ;

name
    : iri
    ;

genericParameters
    : '<<' (genericParameter ',')* genericParameter* '>>'
    ;

genericParameter
    : Variable 'subtypeOf' type
    ;

parameters
    : '(' (parameter (',' parameter)*)? ')'
    ;

parameter
    : type Variable
    ;

returnType
    : '->' type
    ;

functionBody
    : functionCall
    ;

 /*** change what is a valid type ***/
type
 : basicType
 | lubType
 | listType
 | neListType
 | functionType
 | genericType
 ;

 lubType
  : 'LUB<' (genericType | basicType) '>'
  ;

 genericType
 : Variable
 ;