module AST where

data Module   = Module
                  { modName     :: Name
                  , modImports  :: () --XXX
                  , modTDecls   :: [TDecl]
                  , modDecls    :: [FunBind]
                  } deriving Show


data Name     = ConName String | VarName String
                deriving Show

tFunName     :: Name
tFunName      = ConName "->"


data Expr     = EVar Name
              | ELit Literal

              | ELam [Alt]
              | EApp Expr Expr

              | ELet [LocalBind] Expr
              | EHasType Expr Type

              | EIf Match
              | ECase [Expr] [Alt]

              | ERec Name [ (Name, Maybe Expr) ] PRec
                -- ^ Record values

              | EUpd Name Expr [ (Name, Maybe Expr) ]
                -- ^ Update a record: @MyRec { e | x = 10 }@

              | ETuple [Expr]   -- ^ Not 1

                deriving Show


data PRec     = PRecDotDot | PRecNoDotDot
                deriving Show


data Literal  = LInteger  Integer NumBase
              | LRational Rational
              | LString   String
                deriving Show

data NumBase  = Base2 | Base8 | Base10 | Base16
                deriving Show


data Pat      = PVar Name
              | PWild
              | PCon Name [Pat]
              | PRec Name [ (Name, Maybe Pat) ] PRec
              | PHasType Pat Type
              | PTuple [Pat]  -- ^ Not 1
              | PLit Literal
                deriving Show


data PGuard   = GPat  Pat Expr
              | GBool Expr
                deriving Show

data Match    = MDone Expr
              | MMatch PGuard Match
              | MFail
              | MOr Match Match
                deriving Show

data Alt      = Alt [Pat] Match
                deriving Show


data LocalBind  = BPat Pat Expr
                | BFun FunBind


data FunBind  = Fun Name [Pat] Expr




data Type     = TApp Type Type
              | TCon Name
              | TVar TVar
                deriving Show

data TVar     = TV String -- XXX
                deriving Show

data TDecl    = TDData Name [Name] TDef
                deriving Show


data TDef     = TSum [ (Name, [Type]) ]     -- ^ Constructor, fields
              | TProd [ (Name, Type) ]      -- ^ Record fields
              | TSyn Type                   -- ^ Type synonym
                deriving Show


