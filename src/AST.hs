module AST where

data Module   = Module
                  { modName     :: Name
                  , modImports  :: () --XXX
                  , modTDecls   :: [TDecl]
                  , modDecls    :: [FunBind]
                  } deriving Show

blankModule :: Name -> Module
blankModule n = Module { modName    = n
                       , modImports = ()
                       , modTDecls  = []
                       , modDecls   = []
                       }

addTDecl :: TDecl -> Module -> Module
addTDecl d m = m { modTDecls = d : modTDecls m }

addDecl :: FunBind -> Module -> Module
addDecl d m = m { modDecls = d : modDecls m }


data Name     = ConName String | VarName String
                deriving Show

tFunName     :: Name
tFunName      = ConName "->"

tTupName     :: Int -> Name
tTupName n    = ConName ("(" ++ replicate m ',' ++ ")")
  where m | n == 0    = 0
          | n >= 2    = n - 1
          | otherwise = error "Invalid tuple name"


data Expr       = EVar Name
                | EWild
                | ELit Literal

                | ELam [IrrefPat] Expr
                | EApp Expr Expr

                | EWhere Expr [LocalBind]
                | EHasType Expr Type

                | EIf Match
                | ECase Expr [Alt]

                | ERec Name [ (Name, Maybe Expr) ] PRec -- ^ Record values
                | EUpd Name Expr [ (Name, Maybe Expr) ]
                  -- ^ Update a record: @MyRec { e | x = 10 }@

                | ETuple [Expr]   -- ^ Not 1

                  deriving Show


data PRec       = PRecDotDot | PRecNoDotDot
                  deriving Show


data Literal    = LInteger  Integer NumBase
                | LRational Rational
                | LString   String
                  deriving Show

data NumBase    = Base2 | Base8 | Base10 | Base16
                  deriving Show


data Pat        = PVar Name
                | PWild
                | PCon Name [Pat]
                | PRec Name [ (Name, Maybe Pat) ] PRec
                | PHasType Pat Type
                | PTuple [Pat]  -- ^ Not 1
                | PLit Literal
                  deriving Show

type IrrefPat   = Pat


data Alt        = Alt Pat Match
                  deriving Show

data Match      = MDone Expr
                | MMatch PGuard Match
                | MFail
                | MOr Match Match
                  deriving Show

data PGuard     = GPat  Pat Expr
                | GBool Expr        -- ^ sugar for: True <- Expr
                | GWild             -- ^ sugar for: True <- True
                  deriving Show



data LocalBind  = BPat IrrefPat Expr
                | BFun FunBind    -- Function has at least 1 argument in locals
                  deriving Show

data FunBind    = Fun Name [IrrefPat] Expr
                  -- ^ 0 or 1 arguments when at top level.
                  deriving Show



data Type       = TApp Type Type
                | TCon Name
                | TVar TVar
                | TQual Type Type
                  deriving Show

data TVar       = TV String -- XXX
                  deriving Show

data TDecl      = TDData Name [Name] TDef
                  deriving Show


data TDef       = TSum [ (Name, [Type]) ]     -- ^ Constructor, fields
                | TProd [ (Name, Type) ]      -- ^ Record fields
                | TSyn Type                   -- ^ Type synonym
                  deriving Show


