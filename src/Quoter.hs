module Quoter where

import Language.Haskell.TH.Quote(QuasiQuoter(..))
import Language.Haskell.TH hiding (Name,Type)
import qualified Language.Haskell.TH as TH

import AST
import Lexer(lexer)
import Parser(parseModule)

lang :: QuasiQuoter
lang = QuasiQuoter { quoteExp  = \_ -> fail "Use at top level, not expression."
                   , quotePat  = \_ -> fail "Use at top level, not pattern."
                   , quoteType = \_ -> fail "Use at top level, not type."
                   , quoteDec  = quoteLang
                   }


quoteLang :: String -> Q [Dec]
quoteLang txt =
  case parseModule tokens of
    Left err -> fail err
    Right a  -> exportModule (a (ConName ""))
  where tokens = lexer True txt


exportModule :: Module -> Q [Dec]
exportModule m = do tds <- mapM exportTDecl (modTDecls m)
                    eds <- mapM exportDecl  (modDecls m)
                    return (concat (tds ++ eds))

exportName :: Name -> TH.Name
exportName nm =
  case nm of
    ConName x -> mkName x
    VarName x -> mkName x

exportType :: Type -> Q TH.Type
exportType ty =
  case ty of
    TVar (TV x) -> return (VarT (mkName x))
    TCon tc     -> return (ConT (exportName tc))
    TApp t1 t2  -> AppT <$> exportType t1 <*> exportType t2
    TQual {}    -> fail "Invalid type"

-- XXX: Newtypes
-- XXX: Selectors..
exportTDecl :: TDecl -> Q [Dec]
exportTDecl (TDData nm ps def) =
  case def of
    TSyn t   -> (one . TySynD n params) <$> exportType t
    TSum cs  -> (\cs -> one $ DataD [] n params cs []) <$> mapM con cs
{-
    TProd fs -> one $ DataD [] n params [ NormalC n <$> mapM fieldTy ts
-}
  where
  n           = exportName nm
  params      = [ PlainTV (exportName x) | x <- ps ]
  fieldTy t   = (,) NotStrict <$> exportType t
  con (c,ts)  = NormalC (exportName c) <$> mapM fieldTy ts
  one x       = [x]

exportDecl :: FunBind -> Q [Dec]
exportDecl = undefined

