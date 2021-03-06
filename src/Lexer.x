{
{-# OPTIONS_GHC -w #-}
module Lexer (lexer, AnnotToken(..), Token(..),LexPos(..)) where

import LexerUtils
}


%wrapper "posn"

-- XXX: Unicode support

$conFirst   = [A-Z]
$idFirst    = [a-z_]
$nameNext   = [a-zA-Z0-9_']

@con        = $conFirst $nameNext*
@id         = $idFirst $nameNext*
@op         = [\!\#\$\%\&\*\+\.\/\<\=\>\?\@\\\^\|\-\~]

@num2       = "0b" [0-1]+
@num8       = "0o" [0-7]+
@num10      = [0-9]+
@num16      = "0x" [0-9A-Fa-f]+


:-

$white+         ;
"--" .+         ;

"case"          { emit T_Case       }
"data"          { emit T_Data       }
"if"            { emit T_If         }
"of"            { emit T_Of         }
"record"        { emit T_Record     }
"type"          { emit T_Type       }
"where"         { emit T_Where      }

"="             { emit T_Eq         }
"|"             { emit T_Bar        }
"("             { emit T_Paren_L    }
")"             { emit T_Paren_R    }
"{"             { emit T_Brace_L    }
"}"             { emit T_Brace_R    }
","             { emit T_Comma      }
"->"            { emit T_Arrow_R    }
"<-"            { emit T_Arrow_L    }
"=>"            { emit T_FatArrow_R }
"::"            { emit T_ColCol     }
".."            { emit T_DotDot     }
"_"             { emit T_Under      }
"\"             { emit T_BackSlash  }

@num2           { emit T_Num2       }
@num8           { emit T_Num8       }
@num10          { emit T_Num10      }
@num16          { emit T_Num16      }

@con            { emit T_Con        }
@id             { emit T_Id         }
@op             { emit T_Op         }

.               { emit T_Err        }


{

lexer :: Bool -> String -> [AnnotToken]
lexer inL txt = layout inL
          $ case break isErr (alexScanTokens txt) of
              (as,bs) -> as ++ take 1 bs
  where
  isErr x = case tokenType x of
              T_Err -> True
              _     -> False

type Action = AlexPosn -> String -> AnnotToken

emit :: Token -> Action
emit t pos txt = Token { tokenText = txt, tokenPosn = cvt pos, tokenType = t }
  where
  cvt (AlexPn x y z) = LexPos x y z

}

