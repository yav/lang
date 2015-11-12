{
module Parser where

import Lexer
import ParserUtils
import AST


}


%monad     { ParseM     }
%tokentype { AnnotToken }

%token
  'case'    { Token { tokenType = T_Case                } }
  'data'    { Token { tokenType = T_Data                } }
  'if'      { Token { tokenType = T_If                  } }
  'of'      { Token { tokenType = T_Of                  } }
  'record'  { Token { tokenType = T_Record              } }
  'type'    { Token { tokenType = T_Type                } }
  'where'   { Token { tokenType = T_Where               } }
  '='       { Token { tokenType = T_Eq                  } }
  '\\'      { Token { tokenType = T_BackSlash           } }
  '|'       { Token { tokenType = T_Bar                 } }
  '('       { Token { tokenType = T_Paren_L             } }
  ')'       { Token { tokenType = T_Paren_R             } }
  '{'       { Token { tokenType = T_Brace_L             } }
  '}'       { Token { tokenType = T_Brace_R             } }
  OPEN      { Token { tokenType = T_Virt_L              } }
  SEP       { Token { tokenType = T_Virt_Sep            } }
  CLOSE     { Token { tokenType = T_Virt_R              } }
  ','       { Token { tokenType = T_Comma               } }
  '..'      { Token { tokenType = T_DotDot              } }
  '_'       { Token { tokenType = T_Under               } }
  '->'      { Token { tokenType = T_Arrow_R             } }
  '<-'      { Token { tokenType = T_Arrow_L             } }
  '=>'      { Token { tokenType = T_FatArrow_R          } }
  '::'      { Token { tokenType = T_ColCol              } }
  CON       { Token { tokenType = T_Con, tokenText = $$ } }
  IDENT     { Token { tokenType = T_Id,  tokenText = $$ } }



%name parseModule  module
%name parseLD      localDecl

%nonassoc PSIG
%right    '=>'
%right    '->'
%right    'where'

%%


module :: { Name -> Module }
  : OPEN topDecls CLOSE                 { $2 . blankModule }

topDecls :: { Module -> Module }
  : topDecls SEP topDecl                { $1 . $3                           }
  | topDecl                             { $1                                }


topDecl :: { Module -> Module }
  : expr '=' texpr                      {% fmap addDecl (mkTopBind $1 $3)   }
  | tdecl                               { addTDecl $1                       }



localDecl :: { LocalBind }
  : texpr '=' texpr                     {% mkLocalBind $1 $3                }

localDecls :: { RList LocalBind }
  : localDecls SEP localDecl            { rCons $1 $3                       }
  | localDecl                           { rOne $1                           }




{- Type Declarations -}

tdecl :: { TDecl }
  : 'data'   CON idents                 { mkTData $2 $3 (TSum [])           }
  | 'data'   CON idents '=' con_decls   { mkTData $2 $3 (TSum (list $5))    }
  | 'type'   CON idents '=' type        { mkTData $2 $3 (TSyn $5)           }
  | 'record' CON idents                 { mkTData $2 $3 (TProd [])          }
  | 'record' CON idents '=' field_decls { mkTData $2 $3 (TProd (list $5))   }

idents :: { RList Name }
  : idents IDENT                        { rCons $1 (VarName $2)             }
  | {- empty -}                         { rNil                              }

con_decl :: { (Name, [Type]) }
  : CON atypes                          { (ConName $1, list $2)             }

con_decls :: { RList (Name, [Type]) }
  : con_decls '|' con_decl              { rCons $1 $3                       }
  | con_decl                            { rOne $1                           }

field_decl :: { (Name, Type) }
  : IDENT '::' type                     { (VarName $1, $3)                  }

field_decls :: { RList (Name, Type) }
  : field_decls '|' field_decl          { rCons $1 $3                       }
  | field_decl                          { rOne $1                           }



{- Types -}

atypes :: { RList Type }
  : atypes atype                        { rCons $1 $2                       }
  | {- empty -}                         { rNil                              }

atype :: { Type }
  : IDENT                               { TVar (TV $1)                      }
  | CON                                 { TCon (ConName $1)                 }
  | '(' ')'                             { TCon (tTupName 0)                 }
  | '(' type ')'                        { $2                                }
  | '(' type ',' types ')'              { mkTTuple $2 $4                    }

btype :: { Type }
  : btype atype                         { TApp $1 $2                        }
  | atype                               { $1                                }

type :: { Type }
  : type '->' type                      { TApp (TApp (TCon tFunName) $1) $3 }
  | type '=>' type                      { TQual $1 $3                       }
  | btype                               { $1                                }

types :: { RList Type }
  : types ',' type                      { rCons $1 $3                       }
  | type                                { rOne $1                           }





{- Expressions -}


aexpr :: { Expr }
  : IDENT                         { EVar (VarName $1)                         }
  | '_'                           { EWild                                     }
  | CON                           { EVar (ConName $1)                         }

  | CON '{' '}'                   { ERec (ConName $1) [] PRecNoDotDot         }
  | CON '{' '..' '}'              { ERec (ConName $1) [] PRecDotDot           }
  | CON '{' fields ',' '..' '}'   { ERec (ConName $1) (list $3) PRecDotDot    }
  | CON '{' fields '}'            { ERec (ConName $1) (list $3) PRecNoDotDot  }
  | CON '{' expr '|' fields '}'   { EUpd (ConName $1) $3 (list $5)            }

  | '(' ')'                       { ETuple []                                 }
  | '(' texpr ',' texprs ')'      { ETuple ($2 : list $4)                     }

  | '(' texpr ')'                 { $2                                        }

elam :: { Expr }
  : '\\' aexprs '->' expr         {% mkLam $2 $4                              }

expr :: { Expr }
  : elam                          { $1                                        }
  | expr 'where'
      OPEN localDecls CLOSE       { EWhere $1 (list $4)                       }
  | 'case' texpr 'of'
      OPEN case_alts CLOSE        { ECase $2 (list $5)                        }
  | match_group                   { EIf $1                                    }
  | aexprs                        { mkApp $1                                  }
  | aexprs elam                   { mkApp (rCons $1 $2)                       }

texpr :: { Expr }
  : expr '::' type %prec PSIG     { EHasType $1 $3                            }
  | expr                          { $1                                        }

field :: { (Name, Maybe Expr) }
  : IDENT '=' expr                { (VarName $1, Just $3)                     }
  | IDENT                         { (VarName $1, Nothing)                     }



texprs :: { RList Expr }
  : texprs ',' texpr              { rCons $1 $3                               }
  | texpr                         { rOne $1                                   }

aexprs :: { RList Expr }
  : aexprs aexpr                  { rCons $1 $2                               }
  | aexpr                         { rOne $1                                   }

fields :: { RList (Name, Maybe Expr) }
  : fields ',' field              { rCons $1 $3                               }
  | field                         { rOne $1                                   }



{- Case Alternatives and Guards -}


case_alt :: { Alt }
  : texpr '->' expr               {% mkCaseAlt $1 (MDone $3)                  }
  | texpr match_group             {% mkCaseAlt $1 $2                          }

case_alts :: { RList Alt }
  : case_alts SEP case_alt        { rCons $1 $3                               }
  | case_alt                      { rOne $1                                   }



match :: { Match }
  : guard SEP match               { MMatch $1 $3                              }
  | guard match_group             { MMatch $1 $2                              }
  | guard '->' expr               { MMatch $1 (MDone $3)                      }

guard :: { PGuard }
  : expr '<-' expr                {% mkGuard $1 $3                            }
  | expr                          {  mkBoolGuard $1                           }

match_group :: { Match }
  : 'if' OPEN matches CLOSE       { $3                                        }
  | 'if' OPEN CLOSE               { MFail                                     }

matches :: { Match }
  : matches SEP match             { MOr $1 $3                                 }
  | match                         { $1                                        }



