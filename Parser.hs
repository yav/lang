{-# OPTIONS_GHC -w #-}
module Parser where

import Lexer
import AST
import Control.Applicative(Applicative(..))

-- parser produced by Happy Version 1.19.4

data HappyAbsSyn t20 t28 t29
	= HappyTerminal (AnnotToken)
	| HappyErrorToken Int
	| HappyAbsSyn7 (TDecl)
	| HappyAbsSyn8 (RList Name)
	| HappyAbsSyn9 ((Name, [Type]))
	| HappyAbsSyn10 (RList (Name, [Type]))
	| HappyAbsSyn11 ((Name, Type))
	| HappyAbsSyn12 (RList (Name, Type))
	| HappyAbsSyn13 (RList Type)
	| HappyAbsSyn14 (Type)
	| HappyAbsSyn17 (Expr)
	| HappyAbsSyn20 t20
	| HappyAbsSyn22 (RList (Name, Maybe Expr))
	| HappyAbsSyn23 ((Name, Maybe Expr))
	| HappyAbsSyn24 (Alt)
	| HappyAbsSyn25 (PGuard)
	| HappyAbsSyn28 t28
	| HappyAbsSyn29 t29

action_0 (38) = happyShift action_25
action_0 (50) = happyShift action_26
action_0 (51) = happyShift action_27
action_0 (14) = happyGoto action_22
action_0 (15) = happyGoto action_23
action_0 (16) = happyGoto action_24
action_0 _ = happyFail

action_1 (33) = happyShift action_12
action_1 (34) = happyShift action_13
action_1 (38) = happyShift action_14
action_1 (50) = happyShift action_15
action_1 (51) = happyShift action_16
action_1 (17) = happyGoto action_6
action_1 (18) = happyGoto action_7
action_1 (19) = happyGoto action_21
action_1 (27) = happyGoto action_11
action_1 _ = happyFail

action_2 (30) = happyShift action_18
action_2 (31) = happyShift action_19
action_2 (32) = happyShift action_20
action_2 (7) = happyGoto action_17
action_2 _ = happyFail

action_3 (33) = happyShift action_12
action_3 (34) = happyShift action_13
action_3 (38) = happyShift action_14
action_3 (50) = happyShift action_15
action_3 (51) = happyShift action_16
action_3 (17) = happyGoto action_6
action_3 (18) = happyGoto action_7
action_3 (19) = happyGoto action_8
action_3 (24) = happyGoto action_9
action_3 (25) = happyGoto action_10
action_3 (27) = happyGoto action_11
action_3 _ = happyFail

action_4 (30) = happyShift action_5
action_4 _ = happyFail

action_5 (50) = happyShift action_45
action_5 _ = happyFail

action_6 _ = happyReduce_33

action_7 (38) = happyShift action_14
action_7 (50) = happyShift action_15
action_7 (51) = happyShift action_16
action_7 (17) = happyGoto action_44
action_7 _ = happyReduce_36

action_8 (48) = happyShift action_43
action_8 _ = happyReduce_49

action_9 (53) = happyAccept
action_9 _ = happyFail

action_10 (33) = happyShift action_12
action_10 (45) = happyShift action_41
action_10 (47) = happyShift action_42
action_10 (27) = happyGoto action_40
action_10 _ = happyFail

action_11 _ = happyReduce_34

action_12 (42) = happyShift action_39
action_12 _ = happyFail

action_13 (33) = happyShift action_12
action_13 (34) = happyShift action_13
action_13 (38) = happyShift action_14
action_13 (50) = happyShift action_15
action_13 (51) = happyShift action_16
action_13 (17) = happyGoto action_6
action_13 (18) = happyGoto action_7
action_13 (19) = happyGoto action_37
action_13 (20) = happyGoto action_38
action_13 (27) = happyGoto action_11
action_13 _ = happyFail

action_14 (33) = happyShift action_12
action_14 (34) = happyShift action_13
action_14 (38) = happyShift action_14
action_14 (50) = happyShift action_15
action_14 (51) = happyShift action_16
action_14 (17) = happyGoto action_6
action_14 (18) = happyGoto action_7
action_14 (19) = happyGoto action_35
action_14 (21) = happyGoto action_36
action_14 (27) = happyGoto action_11
action_14 _ = happyFail

action_15 (40) = happyShift action_34
action_15 _ = happyReduce_27

action_16 _ = happyReduce_26

action_17 (53) = happyAccept
action_17 _ = happyFail

action_18 (50) = happyShift action_33
action_18 _ = happyFail

action_19 (50) = happyShift action_32
action_19 _ = happyFail

action_20 (50) = happyShift action_31
action_20 _ = happyFail

action_21 (53) = happyAccept
action_21 _ = happyFail

action_22 _ = happyReduce_23

action_23 (38) = happyShift action_25
action_23 (47) = happyShift action_30
action_23 (50) = happyShift action_26
action_23 (51) = happyShift action_27
action_23 (14) = happyGoto action_29
action_23 _ = happyReduce_25

action_24 (53) = happyAccept
action_24 _ = happyFail

action_25 (38) = happyShift action_25
action_25 (50) = happyShift action_26
action_25 (51) = happyShift action_27
action_25 (14) = happyGoto action_22
action_25 (15) = happyGoto action_23
action_25 (16) = happyGoto action_28
action_25 _ = happyFail

action_26 _ = happyReduce_20

action_27 _ = happyReduce_19

action_28 (39) = happyShift action_64
action_28 _ = happyFail

action_29 _ = happyReduce_22

action_30 (38) = happyShift action_25
action_30 (50) = happyShift action_26
action_30 (51) = happyShift action_27
action_30 (14) = happyGoto action_22
action_30 (15) = happyGoto action_23
action_30 (16) = happyGoto action_63
action_30 _ = happyFail

action_31 (8) = happyGoto action_62
action_31 _ = happyReduce_10

action_32 (8) = happyGoto action_61
action_32 _ = happyReduce_10

action_33 (8) = happyGoto action_60
action_33 _ = happyReduce_10

action_34 (33) = happyShift action_12
action_34 (34) = happyShift action_13
action_34 (38) = happyShift action_14
action_34 (50) = happyShift action_15
action_34 (51) = happyShift action_59
action_34 (17) = happyGoto action_6
action_34 (18) = happyGoto action_7
action_34 (19) = happyGoto action_56
action_34 (22) = happyGoto action_57
action_34 (23) = happyGoto action_58
action_34 (27) = happyGoto action_11
action_34 _ = happyFail

action_35 (49) = happyShift action_55
action_35 _ = happyReduce_40

action_36 (39) = happyShift action_54
action_36 _ = happyFail

action_37 _ = happyReduce_38

action_38 (33) = happyShift action_52
action_38 (45) = happyShift action_53
action_38 _ = happyFail

action_39 (33) = happyShift action_12
action_39 (34) = happyShift action_13
action_39 (38) = happyShift action_14
action_39 (50) = happyShift action_15
action_39 (51) = happyShift action_16
action_39 (17) = happyGoto action_6
action_39 (18) = happyGoto action_7
action_39 (19) = happyGoto action_8
action_39 (24) = happyGoto action_50
action_39 (25) = happyGoto action_10
action_39 (26) = happyGoto action_51
action_39 (27) = happyGoto action_11
action_39 _ = happyFail

action_40 _ = happyReduce_46

action_41 (33) = happyShift action_12
action_41 (34) = happyShift action_13
action_41 (38) = happyShift action_14
action_41 (50) = happyShift action_15
action_41 (51) = happyShift action_16
action_41 (17) = happyGoto action_6
action_41 (18) = happyGoto action_7
action_41 (19) = happyGoto action_8
action_41 (24) = happyGoto action_49
action_41 (25) = happyGoto action_10
action_41 (27) = happyGoto action_11
action_41 _ = happyFail

action_42 (33) = happyShift action_12
action_42 (34) = happyShift action_13
action_42 (38) = happyShift action_14
action_42 (50) = happyShift action_15
action_42 (51) = happyShift action_16
action_42 (17) = happyGoto action_6
action_42 (18) = happyGoto action_7
action_42 (19) = happyGoto action_48
action_42 (27) = happyGoto action_11
action_42 _ = happyFail

action_43 (33) = happyShift action_12
action_43 (34) = happyShift action_13
action_43 (38) = happyShift action_14
action_43 (50) = happyShift action_15
action_43 (51) = happyShift action_16
action_43 (17) = happyGoto action_6
action_43 (18) = happyGoto action_7
action_43 (19) = happyGoto action_47
action_43 (27) = happyGoto action_11
action_43 _ = happyFail

action_44 _ = happyReduce_32

action_45 (8) = happyGoto action_46
action_45 _ = happyFail

action_46 (51) = happyShift action_66
action_46 _ = happyFail

action_47 _ = happyReduce_48

action_48 _ = happyReduce_47

action_49 _ = happyReduce_45

action_50 _ = happyReduce_51

action_51 (43) = happyShift action_76
action_51 (44) = happyShift action_77
action_51 _ = happyFail

action_52 (42) = happyShift action_75
action_52 _ = happyFail

action_53 (33) = happyShift action_12
action_53 (34) = happyShift action_13
action_53 (38) = happyShift action_14
action_53 (50) = happyShift action_15
action_53 (51) = happyShift action_16
action_53 (17) = happyGoto action_6
action_53 (18) = happyGoto action_7
action_53 (19) = happyGoto action_74
action_53 (27) = happyGoto action_11
action_53 _ = happyFail

action_54 _ = happyReduce_31

action_55 (38) = happyShift action_25
action_55 (50) = happyShift action_26
action_55 (51) = happyShift action_27
action_55 (14) = happyGoto action_22
action_55 (15) = happyGoto action_23
action_55 (16) = happyGoto action_73
action_55 _ = happyFail

action_56 (37) = happyShift action_72
action_56 _ = happyFail

action_57 (41) = happyShift action_70
action_57 (45) = happyShift action_71
action_57 _ = happyFail

action_58 _ = happyReduce_42

action_59 (36) = happyShift action_69
action_59 (41) = happyReduce_44
action_59 (45) = happyReduce_44
action_59 _ = happyReduce_26

action_60 (36) = happyShift action_68
action_60 (51) = happyShift action_66
action_60 _ = happyReduce_4

action_61 (36) = happyShift action_67
action_61 (51) = happyShift action_66
action_61 _ = happyReduce_6

action_62 (36) = happyShift action_65
action_62 (51) = happyShift action_66
action_62 _ = happyFail

action_63 _ = happyReduce_24

action_64 _ = happyReduce_21

action_65 (38) = happyShift action_25
action_65 (50) = happyShift action_26
action_65 (51) = happyShift action_27
action_65 (14) = happyGoto action_22
action_65 (15) = happyGoto action_23
action_65 (16) = happyGoto action_93
action_65 _ = happyFail

action_66 _ = happyReduce_9

action_67 (51) = happyShift action_92
action_67 (11) = happyGoto action_90
action_67 (12) = happyGoto action_91
action_67 _ = happyFail

action_68 (50) = happyShift action_89
action_68 (9) = happyGoto action_87
action_68 (10) = happyGoto action_88
action_68 _ = happyFail

action_69 (33) = happyShift action_12
action_69 (34) = happyShift action_13
action_69 (38) = happyShift action_14
action_69 (50) = happyShift action_15
action_69 (51) = happyShift action_16
action_69 (17) = happyGoto action_6
action_69 (18) = happyGoto action_7
action_69 (19) = happyGoto action_86
action_69 (27) = happyGoto action_11
action_69 _ = happyFail

action_70 _ = happyReduce_28

action_71 (46) = happyShift action_85
action_71 (51) = happyShift action_83
action_71 (23) = happyGoto action_84
action_71 _ = happyFail

action_72 (51) = happyShift action_83
action_72 (22) = happyGoto action_82
action_72 (23) = happyGoto action_58
action_72 _ = happyFail

action_73 _ = happyReduce_39

action_74 _ = happyReduce_37

action_75 (33) = happyShift action_12
action_75 (34) = happyShift action_13
action_75 (38) = happyShift action_14
action_75 (50) = happyShift action_15
action_75 (51) = happyShift action_16
action_75 (17) = happyGoto action_6
action_75 (18) = happyGoto action_7
action_75 (19) = happyGoto action_79
action_75 (27) = happyGoto action_11
action_75 (28) = happyGoto action_80
action_75 (29) = happyGoto action_81
action_75 _ = happyFail

action_76 (33) = happyShift action_12
action_76 (34) = happyShift action_13
action_76 (38) = happyShift action_14
action_76 (50) = happyShift action_15
action_76 (51) = happyShift action_16
action_76 (17) = happyGoto action_6
action_76 (18) = happyGoto action_7
action_76 (19) = happyGoto action_8
action_76 (24) = happyGoto action_78
action_76 (25) = happyGoto action_10
action_76 (27) = happyGoto action_11
action_76 _ = happyFail

action_77 _ = happyReduce_52

action_78 _ = happyReduce_50

action_79 (33) = happyShift action_12
action_79 (47) = happyShift action_104
action_79 (27) = happyGoto action_103
action_79 _ = happyFail

action_80 _ = happyReduce_56

action_81 (43) = happyShift action_101
action_81 (44) = happyShift action_102
action_81 _ = happyFail

action_82 (41) = happyShift action_99
action_82 (45) = happyShift action_100
action_82 _ = happyFail

action_83 (36) = happyShift action_69
action_83 _ = happyReduce_44

action_84 _ = happyReduce_41

action_85 (41) = happyShift action_98
action_85 _ = happyFail

action_86 _ = happyReduce_43

action_87 _ = happyReduce_13

action_88 (37) = happyShift action_97
action_88 _ = happyReduce_5

action_89 (13) = happyGoto action_96
action_89 _ = happyReduce_18

action_90 _ = happyReduce_16

action_91 (37) = happyShift action_95
action_91 _ = happyReduce_7

action_92 (49) = happyShift action_94
action_92 _ = happyFail

action_93 _ = happyReduce_8

action_94 (38) = happyShift action_25
action_94 (50) = happyShift action_26
action_94 (51) = happyShift action_27
action_94 (14) = happyGoto action_22
action_94 (15) = happyGoto action_23
action_94 (16) = happyGoto action_110
action_94 _ = happyFail

action_95 (51) = happyShift action_92
action_95 (11) = happyGoto action_109
action_95 _ = happyFail

action_96 (38) = happyShift action_25
action_96 (50) = happyShift action_26
action_96 (51) = happyShift action_27
action_96 (14) = happyGoto action_108
action_96 _ = happyReduce_11

action_97 (50) = happyShift action_89
action_97 (9) = happyGoto action_107
action_97 _ = happyFail

action_98 _ = happyReduce_29

action_99 _ = happyReduce_30

action_100 (51) = happyShift action_83
action_100 (23) = happyGoto action_84
action_100 _ = happyFail

action_101 (33) = happyShift action_12
action_101 (34) = happyShift action_13
action_101 (38) = happyShift action_14
action_101 (50) = happyShift action_15
action_101 (51) = happyShift action_16
action_101 (17) = happyGoto action_6
action_101 (18) = happyGoto action_7
action_101 (19) = happyGoto action_79
action_101 (27) = happyGoto action_11
action_101 (28) = happyGoto action_106
action_101 _ = happyFail

action_102 _ = happyReduce_35

action_103 _ = happyReduce_54

action_104 (33) = happyShift action_12
action_104 (34) = happyShift action_13
action_104 (38) = happyShift action_14
action_104 (50) = happyShift action_15
action_104 (51) = happyShift action_16
action_104 (17) = happyGoto action_6
action_104 (18) = happyGoto action_7
action_104 (19) = happyGoto action_105
action_104 (27) = happyGoto action_11
action_104 _ = happyFail

action_105 _ = happyReduce_53

action_106 _ = happyReduce_55

action_107 _ = happyReduce_12

action_108 _ = happyReduce_17

action_109 _ = happyReduce_15

action_110 _ = happyReduce_14

happyReduce_4 = happySpecReduce_3  7 happyReduction_4
happyReduction_4 (HappyAbsSyn8  happy_var_3)
	(HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_2 }))
	_
	 =  HappyAbsSyn7
		 (tData happy_var_2 happy_var_3 (TSum [])
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happyReduce 5 7 happyReduction_5
happyReduction_5 ((HappyAbsSyn10  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_2 })) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (tData happy_var_2 happy_var_3 (TSum (list happy_var_5))
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_3  7 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_3)
	(HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_2 }))
	_
	 =  HappyAbsSyn7
		 (tData happy_var_2 happy_var_3 (TProd [])
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happyReduce 5 7 happyReduction_7
happyReduction_7 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_2 })) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (tData happy_var_2 happy_var_3 (TProd (list happy_var_5))
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 5 7 happyReduction_8
happyReduction_8 ((HappyAbsSyn14  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_2 })) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (tData happy_var_2 happy_var_3 (TSyn happy_var_5)
	) `HappyStk` happyRest

happyReduce_9 = happySpecReduce_2  8 happyReduction_9
happyReduction_9 (HappyTerminal (Token { tokenType = T_Id,  tokenText = happy_var_2 }))
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (rCons happy_var_1 (VarName happy_var_2)
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_0  8 happyReduction_10
happyReduction_10  =  HappyAbsSyn8
		 (rNil
	)

happyReduce_11 = happySpecReduce_2  9 happyReduction_11
happyReduction_11 (HappyAbsSyn13  happy_var_2)
	(HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_1 }))
	 =  HappyAbsSyn9
		 ((ConName happy_var_1, list happy_var_2)
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  10 happyReduction_12
happyReduction_12 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (rCons happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  10 happyReduction_13
happyReduction_13 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (rOne happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  11 happyReduction_14
happyReduction_14 (HappyAbsSyn14  happy_var_3)
	_
	(HappyTerminal (Token { tokenType = T_Id,  tokenText = happy_var_1 }))
	 =  HappyAbsSyn11
		 ((VarName happy_var_1, happy_var_3)
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  12 happyReduction_15
happyReduction_15 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (rCons happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  12 happyReduction_16
happyReduction_16 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 (rOne happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_2  13 happyReduction_17
happyReduction_17 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (rCons happy_var_1 happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_0  13 happyReduction_18
happyReduction_18  =  HappyAbsSyn13
		 (rNil
	)

happyReduce_19 = happySpecReduce_1  14 happyReduction_19
happyReduction_19 (HappyTerminal (Token { tokenType = T_Id,  tokenText = happy_var_1 }))
	 =  HappyAbsSyn14
		 (TVar (TV happy_var_1)
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  14 happyReduction_20
happyReduction_20 (HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_1 }))
	 =  HappyAbsSyn14
		 (TCon (ConName happy_var_1)
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  14 happyReduction_21
happyReduction_21 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (happy_var_2
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_2  15 happyReduction_22
happyReduction_22 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (TApp happy_var_1 happy_var_2
	)
happyReduction_22 _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  15 happyReduction_23
happyReduction_23 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  16 happyReduction_24
happyReduction_24 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (TApp (TApp (TCon tFunName) happy_var_1) happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  16 happyReduction_25
happyReduction_25 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  17 happyReduction_26
happyReduction_26 (HappyTerminal (Token { tokenType = T_Id,  tokenText = happy_var_1 }))
	 =  HappyAbsSyn17
		 (EVar (VarName happy_var_1)
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  17 happyReduction_27
happyReduction_27 (HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_1 }))
	 =  HappyAbsSyn17
		 (EVar (ConName happy_var_1)
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happyReduce 4 17 happyReduction_28
happyReduction_28 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_1 })) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (ERec (ConName happy_var_1) (list happy_var_3) PRecNoDotDot
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 6 17 happyReduction_29
happyReduction_29 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_1 })) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (ERec (ConName happy_var_1) (list happy_var_3) PRecDotDot
	) `HappyStk` happyRest

happyReduce_30 = happyReduce 6 17 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token { tokenType = T_Con, tokenText = happy_var_1 })) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (EUpd (ConName happy_var_1) happy_var_3 (list happy_var_5)
	) `HappyStk` happyRest

happyReduce_31 = happySpecReduce_3  17 happyReduction_31
happyReduction_31 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (happy_var_2
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  18 happyReduction_32
happyReduction_32 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (EApp happy_var_1 happy_var_2
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  18 happyReduction_33
happyReduction_33 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  19 happyReduction_34
happyReduction_34 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn17
		 (EIf happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happyReduce 6 19 happyReduction_35
happyReduction_35 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (
	) `HappyStk` happyRest

happyReduce_36 = happySpecReduce_1  19 happyReduction_36
happyReduction_36 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  20 happyReduction_37
happyReduction_37 _
	_
	_
	 =  HappyAbsSyn20
		 (
	)

happyReduce_38 = happySpecReduce_1  20 happyReduction_38
happyReduction_38 _
	 =  HappyAbsSyn20
		 (
	)

happyReduce_39 = happySpecReduce_3  21 happyReduction_39
happyReduction_39 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (EHasType happy_var_1 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  21 happyReduction_40
happyReduction_40 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  22 happyReduction_41
happyReduction_41 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (rCons happy_var_1 happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  22 happyReduction_42
happyReduction_42 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 (rOne happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  23 happyReduction_43
happyReduction_43 (HappyAbsSyn17  happy_var_3)
	_
	(HappyTerminal (Token { tokenType = T_Id,  tokenText = happy_var_1 }))
	 =  HappyAbsSyn23
		 ((VarName happy_var_1, Just happy_var_3)
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  23 happyReduction_44
happyReduction_44 (HappyTerminal (Token { tokenType = T_Id,  tokenText = happy_var_1 }))
	 =  HappyAbsSyn23
		 ((VarName happy_var_1, Nothing)
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  24 happyReduction_45
happyReduction_45 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 (PMatch happy_var_1 happy_var_3
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  24 happyReduction_46
happyReduction_46 (HappyAbsSyn24  happy_var_2)
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 (PMatch happy_var_1 happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  24 happyReduction_47
happyReduction_47 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn24
		 (PMatch happy_var_1 (PDone happy_var_3)
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happyMonadReduce 3 25 happyReduction_48
happyReduction_48 ((HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_1) `HappyStk`
	happyRest) tk
	 = happyThen (( (`GPat` happy_var_3) `fmap` exprToPat happy_var_1)
	) (\r -> happyReturn (HappyAbsSyn25 r))

happyReduce_49 = happySpecReduce_1  25 happyReduction_49
happyReduction_49 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn25
		 (GBool happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  26 happyReduction_50
happyReduction_50 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (POr happy_var_1 happy_var_3
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  26 happyReduction_51
happyReduction_51 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happyReduce 4 27 happyReduction_52
happyReduction_52 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (happy_var_2
	) `HappyStk` happyRest

happyReduce_53 = happySpecReduce_3  28 happyReduction_53
happyReduction_53 _
	_
	_
	 =  HappyAbsSyn28
		 (
	)

happyReduce_54 = happySpecReduce_2  28 happyReduction_54
happyReduction_54 _
	_
	 =  HappyAbsSyn28
		 (
	)

happyReduce_55 = happySpecReduce_3  29 happyReduction_55
happyReduction_55 _
	_
	_
	 =  HappyAbsSyn29
		 (
	)

happyReduce_56 = happySpecReduce_1  29 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn29
		 (
	)

happyNewToken action sts stk [] =
	action 53 53 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	Token { tokenType = T_Data                } -> cont 30;
	Token { tokenType = T_Record              } -> cont 31;
	Token { tokenType = T_Type                } -> cont 32;
	Token { tokenType = T_If                  } -> cont 33;
	Token { tokenType = T_Case                } -> cont 34;
	Token { tokenType = T_Of                  } -> cont 35;
	Token { tokenType = T_Eq                  } -> cont 36;
	Token { tokenType = T_Bar                 } -> cont 37;
	Token { tokenType = T_Paren_L             } -> cont 38;
	Token { tokenType = T_Paren_R             } -> cont 39;
	Token { tokenType = T_Brace_L             } -> cont 40;
	Token { tokenType = T_Brace_R             } -> cont 41;
	Token { tokenType = T_Virt_L              } -> cont 42;
	Token { tokenType = T_Virt_Sep            } -> cont 43;
	Token { tokenType = T_Virt_R              } -> cont 44;
	Token { tokenType = T_Comma               } -> cont 45;
	Token { tokenType = T_DotDot              } -> cont 46;
	Token { tokenType = T_Arrow_R             } -> cont 47;
	Token { tokenType = T_Arrow_L             } -> cont 48;
	Token { tokenType = T_ColCol              } -> cont 49;
	Token { tokenType = T_Con, tokenText = happy_dollar_dollar } -> cont 50;
	Token { tokenType = T_Id,  tokenText = happy_dollar_dollar } -> cont 51;
	 -> cont 52;
	_ -> happyError' (tk:tks)
	}

happyError_ 53 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

happyThen :: () => Either ParseError a -> (a -> Either ParseError b) -> Either ParseError b
happyThen = (>>=)
happyReturn :: () => a -> Either ParseError a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Either ParseError a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(AnnotToken)] -> Either ParseError a
happyError' = happyError

parseType tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn14 z -> happyReturn z; _other -> notHappyAtAll })

parseExpr tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_1 tks) (\x -> case x of {HappyAbsSyn17 z -> happyReturn z; _other -> notHappyAtAll })

parseTDecl tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_2 tks) (\x -> case x of {HappyAbsSyn7 z -> happyReturn z; _other -> notHappyAtAll })

parseMatch tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_3 tks) (\x -> case x of {HappyAbsSyn24 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4










































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 46 "templates/GenericTemplate.hs" #-}








{-# LINE 67 "templates/GenericTemplate.hs" #-}

{-# LINE 77 "templates/GenericTemplate.hs" #-}

{-# LINE 86 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 256 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 322 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
