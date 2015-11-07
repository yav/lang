{
module Parser where

import Lexer
import AST



}


%monad     { Either ParseError }
%tokentype { AnnotToken        }

%token
  'data'    { Token { tokenType = T_Data                } }
  'record'  { Token { tokenType = T_Record              } }
  'type'    { Token { tokenType = T_Type                } }
  'if'      { Token { tokenType = T_If                  } }
  'case'    { Token { tokenType = T_Case                } }
  '='       { Token { tokenType = T_Eq                  } }
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

%%



{- Type Declarations -}

tdecl :: { TDecl }
  : 'data' CON idents                   { tData $2 $3 (TSum [])             }
  | 'data' CON idents '=' con_decls     { tData $2 $3 (TSum (list $5))      }
  | 'record' CON idents                 { tData $2 $3 (TProd [])            }
  | 'record' CON idents '=' field_decls { tData $2 $3 (TProd (list $5))     }
  | 'type' CON idents '=' type          { tData $2 $3 (TSyn $5)             }

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
  : btype '->' type                     { TApp (TApp (TCon tFunName) $1) $3 }
  | btype                               { $1                                }



{- Expressions -}

aexpr :: { Expr }
  : IDENT                         { EVar (VarName $1)                        }
  | CON                           { EVar (ConName $1)                        }
  | CON '{' fields '}'            { ERec (ConName $1) (list $3) PRecNoDotDot }
  | CON '{' fields ',' '..' '}'   { ERec (ConName $1) (list $3) PRecDotDot   }
  | CON '{' expr '|' fields '}'   { EUpd (ConName $1) $3 (list $5)           }
  | '(' texpr ')'                 { $2                                       }

bexpr :: { Expr }
  : bexpr aexpr                         { EApp $1 $2                        }
  | aexpr                               { $1                                }

expr :: { Expr }
  : match_group                    { EIf $1                            }
  | 'case' exprs 'if'
      OPEN case_alts CLOSE              {}
  | bexpr                               { $1                                }


exprs
  : exprs ',' expr                      {}
  | expr                                {}


texpr :: { Expr }
  : expr '::' type                      { EHasType $1 $3                    }
  | expr                                { $1                                }

fields :: { RList (Name, Maybe Expr) }
  : fields ',' field                    { rCons $1 $3                       }
  | field                               { rOne $1                           }

field :: { (Name, Maybe Expr) }
  : IDENT '=' expr                      { (VarName $1, Just $3)             }
  | IDENT                               { (VarName $1, Nothing)             }



match :: { Alt }
  : guard ',' match                     { PMatch $1 $3                      }
  | guard match_group                   { PMatch $1 $2                      }
  | guard '->' expr                     { PMatch $1 (PDone $3)              }

guard :: { PGuard }
  : expr '<-' expr                      {% (`GPat` $3) `fmap` exprToPat $1  }
  | expr                                { GBool $1                          }

matches :: { Alt }
  : matches SEP match                   { POr $1 $3                         }
  | match                               { $1                                }

match_group :: { Alt }
  : 'if' OPEN matches CLOSE             { $2                                }

case_alt
  : expr '->' expr                      {}
  | expr match_group                    {}

case_alts
  : case_alts SEP case_alt              {}
  | case_alt                            {}


{
type ParseError = String
type ParseM     = Either ParseError

newtype RList a = RList [a]

rCons :: RList a -> a -> RList a
rCons (RList xs) x = RList (x : xs)

rOne :: a -> RList a
rOne x = RList [x]

rNil :: RList a
rNil = RList []

list :: RList a -> [a]
list (RList a) = reverse a


happyError :: [AnnotToken] -> ParseM a
happyError _ = Left "parse error"


tData :: String -> RList Name -> TDef -> TDecl
tData x xs d = TDData (ConName x) (list xs) d

exprToPat :: Expr -> ParseM Pat
exprToPat expr =
  case expr of
    EVar (VarName x)  -> return (if x == "_" then PWild else PVar (VarName x))
    EVar (ConName x)  -> return (PCon (ConName x) [])
    ELit l            -> return (PLit l)
    EHasType e t      -> (`PHasType` t) <$> exprToPat e
    ERec x fs pr      -> (\xs -> PRec x xs pr) `fmap` traverse field fs
      where field (y,mb) = ((,) y) <$> traverse exprToPat mb

    EApp e1 e2        -> case splitApp [e2] e1 of
                           (EVar (ConName x), es) ->
                              PCon (ConName x) `fmap` traverse exprToPat es
                           _ -> Left "Invalid pattern"

    ELam {}           -> Left "Invalid pattern"
    ELet {}           -> Left "Invalid pattern"
    EIf {}            -> Left "Invalid pattern"
    EUpd {}           -> Left "Invalid pattern"


  where
  splitApp xs (EApp e1 e2) = splitApp (e2 : xs) e1
  splitApp xs x           = (x, reverse xs)


}
