{
module Parser where

import Lexer
import ParserUtils
import AST


}


%monad     { ParseM     }
%tokentype { AnnotToken }

%token
  'data'    { Token { tokenType = T_Data                } }
  'record'  { Token { tokenType = T_Record              } }
  'type'    { Token { tokenType = T_Type                } }
  'if'      { Token { tokenType = T_If                  } }
  'of'      { Token { tokenType = T_Of                  } }
  'case'    { Token { tokenType = T_Case                } }
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
  '->'      { Token { tokenType = T_Arrow_R             } }
  '<-'      { Token { tokenType = T_Arrow_L             } }
  '::'      { Token { tokenType = T_ColCol              } }
  CON       { Token { tokenType = T_Con, tokenText = $$ } }
  IDENT     { Token { tokenType = T_Id,  tokenText = $$ } }



%name parseType  type
%name parseExpr  expr
%name parseTDecl tdecl
%name parseMatch match
%name parseLd    localDecls

%nonassoc PSIG
%right    '->'

%%




{- Type Declarations -}

tdecl :: { TDecl }
  : 'data'   CON idents                 { mkTData $2 $3 (TSum [])           }
  | 'data'   CON idents '=' con_decls   { mkTData $2 $3 (TSum (list $5))    }
  | 'record' CON idents                 { mkTData $2 $3 (TProd [])          }
  | 'record' CON idents '=' field_decls { mkTData $2 $3 (TProd (list $5))   }
  | 'type'   CON idents '=' type        { mkTData $2 $3 (TSyn $5)           }

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
  | '(' type ')'                        { $2                                }

btype :: { Type }
  : btype atype                         { TApp $1 $2                        }
  | atype                               { $1                                }

type :: { Type }
  : type '->' type                      { TApp (TApp (TCon tFunName) $1) $3 }
  | btype                               { $1                                }



localDecl
  : texpr '=' texpr                     { undefined }

localDecls
  : localDecls SEP localDecl            { rCons $1 $3                         }
  | localDecl                           { rOne $1                             }




{- Expressions -}

aexpr :: { Expr }
  : IDENT                         { EVar (VarName $1)                         }
  | CON                           { EVar (ConName $1)                         }
  | CON '{' fields '}'            { ERec (ConName $1) (list $3) PRecNoDotDot  }
  | CON '{' fields ',' '..' '}'   { ERec (ConName $1) (list $3) PRecDotDot    }
  | CON '{' expr '|' fields '}'   { EUpd (ConName $1) $3 (list $5)            }
  | '(' ')'                       { ETuple []                                 }
  | '(' texpr ',' texprs ')'      { ETuple ($2 : list $4)                     }
  | '(' texpr ')'                 { $2                                        }

bexpr :: { Expr }
  : bexpr aexpr                   { EApp $1 $2                                }
  | aexpr                         { $1                                        }

expr :: { Expr }
  : match_group                   { EIf $1                                    }
  | 'case' texprs alt_group       { ECase (list $2) $3                        }
  | bexpr                         { $1                                        }


texpr :: { Expr }
  : expr '::' type %prec PSIG     { EHasType $1 $3                            }
  | expr                          { $1                                        }

texprs :: { RList Expr }
  : texprs ',' texpr              { rCons $1 $3                               }
  | texpr                         { rOne $1                                   }

fields :: { RList (Name, Maybe Expr) }
  : fields ',' field                    { rCons $1 $3                       }
  | field                               { rOne $1                           }

field :: { (Name, Maybe Expr) }
  : IDENT '=' expr                      { (VarName $1, Just $3)             }
  | IDENT                               { (VarName $1, Nothing)             }



match :: { Match }
  : guard SEP match                     { MMatch $1 $3                      }
  | guard match_group                   { MMatch $1 $2                      }
  | guard '->' expr                     { MMatch $1 (MDone $3)              }

guard :: { PGuard }
  : expr '<-' expr                      {% mkGuard $1 $3                    }
  | expr                                { GBool $1                          }

match_group :: { Match }
  : 'if' OPEN matches CLOSE             { $3                                }
  | 'if' OPEN CLOSE                     { MFail                             }

matches :: { Match }
  : matches SEP match                   { MOr $1 $3                         }
  | match                               { $1                                }

alt_group :: { [Alt] }
  : 'of' OPEN case_alts CLOSE           { list $3                           }

case_alt :: { Alt }
  : texprs '->' expr                    {% mkCaseAlt $1 (MDone $3)          }
  | texprs match_group                  {% mkCaseAlt $1 $2                  }

case_alts :: { RList Alt }
  : case_alts SEP case_alt              { rCons $1 $3                       }
  | case_alt                            { rOne $1                           }


