-- VectorCAST 18.sp5 (03/03/19)
-- Test Case Script
-- 
-- Environment    : ENV_MONITORED_ADA
-- Unit(s) Under Test: UNIT
-- 
-- Script Features
TEST.SCRIPT_FEATURE:MULTIPLE_UUT_SUPPORT
TEST.SCRIPT_FEATURE:MIXED_CASE_NAMES
TEST.SCRIPT_FEATURE:ADA_DIRECT_ARRAY_INDEXING
--

-- Unit: UNIT

-- Subprogram: ISPOSITIVE

-- Test Case: Boundary
TEST.UNIT:UNIT
TEST.SUBPROGRAM:ISPOSITIVE
TEST.NEW
TEST.NAME:Boundary
TEST.BASIS_PATH:2 of 4 (template)
TEST.NOTES:
This is an automatically generated test case.
   Test Path 2
      (1) if X < 0 ==> FALSE
      (3) elsif X > 0 AND X < 100 ==> TRUE
   Test Case Generation Notes:
     Conflict: Cannot resolve multiple comparisons (UNIT.ISPOSITIVE.X) in branches 1/3/3
TEST.END_NOTES:
TEST.VALUE:UNIT.ISPOSITIVE.X:-1,0,1,99,100,101,999,1000,1001
TEST.EXPECTED:UNIT.ISPOSITIVE.return:(2)FALSE,(2)TRUE,FALSE,(2)TRUE,FALSE
TEST.END

-- Test Case: NegativeValue
TEST.UNIT:UNIT
TEST.SUBPROGRAM:ISPOSITIVE
TEST.NEW
TEST.NAME:NegativeValue
TEST.BASIS_PATH:1 of 4
TEST.NOTES:
This is an automatically generated test case.
   Test Path 1
      (1) if X < 0 ==> TRUE
   Test Case Generation Notes:
TEST.END_NOTES:
TEST.VALUE:UNIT.ISPOSITIVE.X:-1
TEST.END

-- Test Case: PositiveValue
TEST.UNIT:UNIT
TEST.SUBPROGRAM:ISPOSITIVE
TEST.NEW
TEST.NAME:PositiveValue
TEST.VALUE:UNIT.ISPOSITIVE.X:2
TEST.EXPECTED:UNIT.ISPOSITIVE.return:TRUE
TEST.END
