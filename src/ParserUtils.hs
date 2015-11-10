module ParserUtils
  ( RList, rNil, rCons, rOne, list
  , ParseM, ParseError, happyError
  , mkTData, mkCaseAlt, mkGuard
  ) where

import AST
import Lexer


newtype RList a = RList [a]

rCons :: RList a -> a -> RList a
rCons (RList xs) x = RList (x : xs)

rOne :: a -> RList a
rOne x = RList [x]

rNil :: RList a
rNil = RList []

list :: RList a -> [a]
list (RList a) = reverse a


--------------------------------------------------------------------------------


mkTData :: String -> RList Name -> TDef -> TDecl
mkTData x xs d = TDData (ConName x) (list xs) d

mkCaseAlt :: RList Expr -> Match -> ParseM Alt
mkCaseAlt pes m = do ps <- mapM exprToPat (list pes)
                     return (Alt ps m)


mkGuard :: Expr -> Expr -> ParseM PGuard
mkGuard pe e = do p <- exprToPat pe
                  return (GPat p e)

mkLocalDecl :: Expr -> Expr -> ParseM LocalBind
mkLocalDecl = undefined

--------------------------------------------------------------------------------

type ParseError = String
type ParseM     = Either ParseError

happyError :: [AnnotToken] -> ParseM a
happyError ts = Left ("Parse error at " ++ loc)
  where loc = case ts of
                []    -> "end of file."
                t : _ -> let LexPos _ l c = tokenPosn t
                         in show l ++ ":" ++ show c ++ "."


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

    ETuple es         -> PTuple <$> traverse exprToPat es

    ELam {}           -> Left "Invalid pattern"
    ELet {}           -> Left "Invalid pattern"
    EIf {}            -> Left "Invalid pattern"
    EUpd {}           -> Left "Invalid pattern"


  where
  splitApp xs (EApp e1 e2) = splitApp (e2 : xs) e1
  splitApp xs x           = (x, reverse xs)


