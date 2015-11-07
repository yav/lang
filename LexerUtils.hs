module LexerUtils where


data LexPos = LexPos Int Int Int
                deriving Show

data AnnotToken = Token { tokenText :: String
                        , tokenPosn :: LexPos
                        , tokenType :: Token
                        } deriving Show

data Token =
    T_Data
  | T_Record
  | T_Type
  | T_If
  | T_Case
  | T_Of

  | T_Eq
  | T_Bar
  | T_Comma
  | T_DotDot
  | T_ColCol
  | T_Paren_L
  | T_Paren_R
  | T_Brace_L
  | T_Brace_R
  | T_Arrow_L
  | T_Arrow_R

  | T_Con
  | T_Id
  | T_Op

  | T_Num2
  | T_Num8
  | T_Num10
  | T_Num16

  | T_Virt_L
  | T_Virt_R
  | T_Virt_Sep

  | T_Err
    deriving Show

--------------------------------------------------------------------------------

layout :: [AnnotToken] -> [AnnotToken]
layout = go [-1]
  where
  col (LexPos _ _ c) = c
  colOf = col . tokenPosn

  virt x t = Token { tokenText = "", tokenPosn = tokenPosn t, tokenType = x }
  eof = LexPos (-1) (-1) (-1)

  doesNotClose _ []       = True
  doesNotClose t (c : _)  = colOf t > c

  go stack ts

    -- End: less indented than the current block
    | t1 : _         <- ts
    , c  : cs        <- stack
    , colOf t1 < c
    = virt T_Virt_R t1 : go cs ts

    -- Start: token after @of@ or @if@.
    | t1 : t2 : more <- ts
    , tok            <- tokenType t1
    , tok == T_Of || tok == T_If
    , doesNotClose t2 stack
    = t1 : virt T_Virt_L t1 : t2 : go (colOf t2 : stack) more

    -- Start: A bar in a layout block that is more indented than the block
    | t1 : more      <- ts
    , T_Bar          <- tokenType t1
    , c : _          <- stack
    , d              <- colOf t1
    , d > c
    = virt T_Virt_L t1 : t1 : go (d : stack) more

    -- Sep: same indentation as the current block
    | t1 : _        <- ts
    , c : cs        <- stack
    , colOf t1 == c
    = virt T_Virt_Sep t1 : t1 : go cs ts

    -- Pass through
    | t1 : more      <- ts
    = t1 : go stack more

    -- End: end of file closes all open layout blocks
    | otherwise
    = [ Token { tokenText = ""
              , tokenPosn = eof
              , tokenType = T_Virt_R } | x <- stack ]




