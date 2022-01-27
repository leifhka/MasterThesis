grammar stOTTR;

import Turtle;


stOTTRDoc
 : ( directive // Turtle prefixes and base
   | statement )* EOF
 ;

statement
 : ( signature
     | template
     | baseTemplate
     | instance
   )
 '.'
 ;


/*** Comments ***/

Comment
 : '#' ~('\r' | '\n')* -> skip
 ;

CommentBlock
 : '/***' .*? '***/' -> skip
 ;


/*** Signature ***/

signature
 : templateName parameterList annotationList?
 ;

templateName
 : iri
 ;

parameterList
 : '[' (parameter (',' parameter)*)? ']'
 ;

parameter
 : ParameterMode* type? Variable defaultValue?
 ;

ParameterMode
 : '?'  /* optional */
 | '!'  /* non blank */
 ;

defaultValue
 : '=' constant
 ;

annotationList
 : annotation (',' annotation)*
 ;

annotation
 : '@@' instance
 ;


/*** Templates ***/

baseTemplate
 : signature '::' 'BASE'
 ;

template
 : signature '::' patternList
 ;

patternList
 : '{' (instance (',' instance)*)? '}'
 ;


/*** Instance ***/

instance
 : (ListExpander '|')? templateName argumentList
 ;

ListExpander
 : 'cross'
 | 'zipMin'
 | 'zipMax'
 ;

argumentList
 : '(' (argument (',' argument)*)? ')'
 ;

argument
 : ListExpand? term
 ;

ListExpand
 : '++'
 ;


/*** Types ***/

type
 : basicType
 | lubType
 | listType
 | neListType
 | functionType
 ;

 functionType
 : 'Function<'(type ',')* type '>'
 ;

listType
 : 'List<' type '>'
 ;

neListType
 : 'NEList<' type '>'
 ;

lubType
 : 'LUB<' basicType '>'
 ;

basicType
 : prefixedName
 ;


/*** Terms ***/

term
 : Variable
 | constant
 | list
 | functionCall
 ;

functionCall
    : '(' functionCallDef? functionCallName genericArguments?  term* ')'
    ;

functionCallName
    : iri
    | Variable ;

functionCallDef : iri ;

genericArguments
    : '<<' genericArgument+ '>>'
    ;

genericArgument
    : Variable
    | type
    ;

Variable
 : '?' BNodeLabel
 ;

/* Turtle blank node labels without trailing '_:' */
fragment BNodeLabel
 : (PN_CHARS_U) ((PN_CHARS | '.')* PN_CHARS)?
 ;

constant
 : iri
 | blankNode
 | literal
 | none
 ;

none
 : 'none'
 ;

list
 : '(' (term (',' term)*)? ')'
 ;
