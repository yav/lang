module ParserUtils
  ( RList, rNil, rCons, rOne, list
  , ParseM, ParseError, happyError
  , mkTData
  , mkCaseAlt
  , mkLam, mkApp
  , mkGuard, mkBoolGuard
  , mkTTuple
  , mkLocalBind, mkTopBind
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

mkCaseAlt :: Expr -> Match -> ParseM Alt
mkCaseAlt pe m = do ps <- exprToPat pe
                    return (Alt ps m)

mkLam :: RList Expr -> Expr -> ParseM Expr
mkLam pes e = (`ELam` e) <$> traverse exprToIrrefPat (list pes)

mkApp :: RList Expr -> Expr
mkApp es = foldl1 EApp (list es)

mkGuard :: Expr -> Expr -> ParseM PGuard
mkGuard pe e = do p <- exprToPat pe
                  return (GPat p e)

mkBoolGuard :: Expr -> PGuard
mkBoolGuard e =
  case e of
    EWild -> GWild
    _     -> GBool e

mkTTuple :: Type -> RList Type -> Type
mkTTuple t rts = foldl TApp con ts
  where
  ts  = t : list rts
  con = TCon (tTupName (length ts))

mkLocalBind :: Expr -> Expr -> ParseM LocalBind
mkLocalBind ep e =
  case splitApp [] ep of
    (ep',[])      -> (`BPat` e) <$> exprToIrrefPat ep'
    (EVar x, eps) -> BFun <$> mkFunBind x eps e


mkFunBind :: Name -> [Expr] -> Expr -> ParseM FunBind
mkFunBind nm es e = (\ps -> Fun nm ps e) <$> traverse exprToIrrefPat es


mkTopBind :: Expr -> Expr -> ParseM FunBind
mkTopBind ep e =
  do bnd <- mkLocalBind ep e
     case bnd of
       BPat (PVar f) e -> return (Fun f [] e)
       BPat _ _        -> Left "Invalid top-level declaration"
       BFun f          -> return f

--------------------------------------------------------------------------------

type ParseError = String
type ParseM     = Either ParseError

happyError :: [AnnotToken] -> ParseM a
happyError ts = Left ("Parse error at " ++ loc)
  where loc = case ts of
                []    -> "end of file."
                t : _ -> let LexPos _ l c = tokenPosn t
                         in show l ++ ":" ++ show c ++ "."


exprToIrrefPat :: Expr -> ParseM Pat
exprToIrrefPat expr = irref =<< exprToPat expr
  where
  irref pat =
    case pat of
      PVar {} -> return pat
      PWild   -> return pat
      PRec x fs dots -> (\fs' -> PRec x fs' dots) <$> traverse field fs
        where field (x,y) = (,) x <$> traverse irref y

      PHasType p t -> (`PHasType` t) <$> irref p
      PTuple ps    -> PTuple <$> traverse irref ps

      PCon {} -> Left "Not an irrefutable pattern"
      PLit {} -> Left "Not an irrefutable pattern"



exprToPat :: Expr -> ParseM Pat
exprToPat expr =
  case expr of
    EVar nm -> case nm of
                 VarName {} -> return (PVar nm)
                 ConName {} -> return (PCon nm [])
    EWild             -> return PWild
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
    EWhere {}         -> Left "Invalid pattern"
    EIf {}            -> Left "Invalid pattern"
    EUpd {}           -> Left "Invalid pattern"



splitApp :: [Expr] -> Expr -> (Expr, [Expr])
splitApp xs (EApp e1 e2) = splitApp (e2 : xs) e1
splitApp xs x            = (x, reverse xs)


