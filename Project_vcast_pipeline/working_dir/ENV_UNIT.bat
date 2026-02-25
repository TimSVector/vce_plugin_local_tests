del commands.tmp
echo options ASSEMBLER_CMD  >> commands.tmp
echo options COMREADER_ENABLED FALSE >> commands.tmp
echo options C_ALT_COMPILE_CMD gcc -c -g >> commands.tmp
echo options C_ALT_EDG_FLAGS -w --gcc --gnu_version 40900 >> commands.tmp
echo options C_ALT_PREPROCESS_CMD gcc -E -C >> commands.tmp
echo options C_COMPILER_CFG_SOURCE PY_CONFIGURATOR >> commands.tmp
echo options C_COMPILER_FAMILY_NAME GNU_Native >> commands.tmp
echo options C_COMPILER_HIERARCHY_STRING GNU Native_4.9_C++ >> commands.tmp
echo options C_COMPILER_OUTPUT_FLAG -o >> commands.tmp
echo options C_COMPILER_PY_ARGS --lang c++ --version 4.9 >> commands.tmp
echo options C_COMPILER_TAG GNU_CPP_49 >> commands.tmp
echo options C_COMPILER_VERSION_CMD g++ --version >> commands.tmp
echo options C_COMPILE_CMD g++ -c -g >> commands.tmp
echo options C_COMPILE_CMD_FLAG -c >> commands.tmp
echo options C_COMPILE_EXCLUDE_FLAGS -o** >> commands.tmp
echo options C_DEBUG_CMD gdb >> commands.tmp
echo options C_DEBUG_HELP_FILE  >> commands.tmp
echo options C_DEFINE_FLAG -D >> commands.tmp
echo options C_DEFINE_LIST VCAST_NO_PTR_TO_UNCON_ARRAY_SUPPORT >> commands.tmp
echo options C_EDG_FLAGS -w --g++ --gnu_version 40900 --type_info_in_std --type_traits_helpers >> commands.tmp
echo options C_EXECUTE_CMD  >> commands.tmp
echo options C_EXEC_HELP_FILE  >> commands.tmp
echo options C_INCLUDE_FLAG -I >> commands.tmp
echo options C_LINKER_VERSION_CMD ld --version >> commands.tmp
echo options C_LINK_CMD g++ -g >> commands.tmp
echo options C_LINK_OPTIONS  >> commands.tmp
echo options C_OBJECT_EXT .o >> commands.tmp
echo options C_OUTPUT_FLAG -o >> commands.tmp
echo options C_PREPROCESS_CMD g++ -E -C >> commands.tmp
echo options C_PREPROCESS_FILE  >> commands.tmp
echo options EXECUTABLE_EXTENSION  >> commands.tmp
echo options MAX_VARY_RANGE 20 >> commands.tmp
echo options PRECOMPILE_CMD  >> commands.tmp
echo options PRECOMPILE_EXT  >> commands.tmp
echo options SBF_LOC_MEMBER_IN_NSP DECL_NAMESPACE >> commands.tmp
echo options SBF_LOC_MEMBER_OUTSIDE_NSP DECL_NAMESPACE >> commands.tmp
echo options SBF_LOC_NONMEMBER_IN_NSP DECL_NAMESPACE >> commands.tmp
echo options SBF_LOC_NONMEMBER_OUTSIDE_NSP DECL_NAMESPACE >> commands.tmp
echo options SOURCE_EXTENSION .cpp >> commands.tmp
echo options SUBSTITUTE_CODE_FOR_C_FILE FALSE >> commands.tmp
echo options TARGET_VARIANT HOST >> commands.tmp
echo options VCAST_ALT_WB_METHOD FALSE >> commands.tmp
echo options VCAST_ASSEMBLY_FILE_EXTENSIONS s >> commands.tmp
echo options VCAST_ASSIGN_WITHOUT_COPY_CTOR TRUE >> commands.tmp
echo options VCAST_AUTO_CLEAR_TEST_USER_CODE FALSE >> commands.tmp
echo options VCAST_AVOID_COMMA_OPERATOR FALSE >> commands.tmp
echo options VCAST_BUFFER_OUTPUT FALSE >> commands.tmp
echo options VCAST_COLLAPSE_STD_HEADERS COLLAPSE_SYSTEM_HEADERS >> commands.tmp
echo options VCAST_COMMAND_LINE_DEBUGGER TRUE >> commands.tmp
echo options VCAST_COMPILER_SUPPORTS_CPP_CASTS TRUE >> commands.tmp
echo options VCAST_COVERAGE_FOR_AGGREGATE_INIT TRUE >> commands.tmp
echo options VCAST_DISABLE_CPP_EXCEPTIONS FALSE >> commands.tmp
echo options VCAST_DISABLE_STD_STRING_DETECTION FALSE >> commands.tmp
echo options VCAST_DISABLE_STD_WSTRING_DETECTION TRUE >> commands.tmp
echo options VCAST_DISABLE_TI_BITFIELD FALSE >> commands.tmp
echo options VCAST_DISABLE_TI_STRING FALSE >> commands.tmp
echo options VCAST_DISPLAY_UNINST_EXPR FALSE >> commands.tmp
echo options VCAST_DUMP_BUFFER FALSE >> commands.tmp
echo options VCAST_ENABLE_FUNCTION_CALL_COVERAGE FALSE >> commands.tmp
echo options VCAST_ENVIRONMENT_FILES  >> commands.tmp
echo options VCAST_ESCAPE_LINE_DIRECTIVES FALSE >> commands.tmp
echo options VCAST_EXECUTE_WITH_STDIO FALSE >> commands.tmp
echo options VCAST_EXECUTE_WITH_STDOUT FALSE >> commands.tmp
echo options VCAST_FAR_STDIN_DATA FALSE >> commands.tmp
echo options VCAST_FILE_INDEX FALSE >> commands.tmp
echo options VCAST_FILE_PREFIX  >> commands.tmp
echo options VCAST_FORCE_ELAB_TYPE_SPEC TRUE >> commands.tmp
echo options VCAST_FORCE_NO_USERGLOBALS FALSE >> commands.tmp
echo options VCAST_GH_INTEX_CMD  >> commands.tmp
echo options VCAST_GH_INT_FILE  >> commands.tmp
echo options VCAST_HAS_LONGLONG TRUE >> commands.tmp
echo options VCAST_INST_FILE_MAX_LINES 0 >> commands.tmp
echo options VCAST_MAIN FALSE >> commands.tmp
echo options VCAST_MAX_COVERED_SUBPROGRAMS 1000 >> commands.tmp
echo options VCAST_MAX_HEAP_SIZE 1000 >> commands.tmp
echo options VCAST_MAX_MCDC_STATEMENTS 1000 >> commands.tmp
echo options VCAST_MAX_STRING_LENGTH 1000 >> commands.tmp
echo options VCAST_MICROSOFT_LONG_LONG FALSE >> commands.tmp
echo options VCAST_MINIMAL_TERMINATION FALSE >> commands.tmp
echo options VCAST_NO_EXIT FALSE >> commands.tmp
echo options VCAST_NO_FFLUSH FALSE >> commands.tmp
echo options VCAST_NO_FLOAT FALSE >> commands.tmp
echo options VCAST_NO_LIMITS FALSE >> commands.tmp
echo options VCAST_NO_LONG_DOUBLE TRUE >> commands.tmp
echo options VCAST_NO_MALLOC FALSE >> commands.tmp
echo options VCAST_NO_SETJMP FALSE >> commands.tmp
echo options VCAST_NO_SIGNAL FALSE >> commands.tmp
echo options VCAST_NO_STDIN FALSE >> commands.tmp
echo options VCAST_NO_STDLIB FALSE >> commands.tmp
echo options VCAST_NO_STD_FILES FALSE >> commands.tmp
echo options VCAST_OUTPUT_BUFFER_SIZE 20000 >> commands.tmp
echo options VCAST_PREPEND_TO_PATH_DIRS  >> commands.tmp
echo options VCAST_PREPROCESS_PREINCLUDE $(VECTORCAST_DIR)/DATA/gnu_native/49/intrinsics.h >> commands.tmp
echo options VCAST_REMOVE_PREPROCESSOR_COMMENTS TRUE >> commands.tmp
echo options VCAST_STDIO FALSE >> commands.tmp
echo options VCAST_TYPEOF_OPERATOR TRUE >> commands.tmp
echo options VCAST_USE_COMPOUND_FOR_BATCH FALSE >> commands.tmp
echo options VCAST_USE_EDG_PREPROCESSOR FALSE >> commands.tmp
echo options VCAST_USE_STATIC_MEMORY FALSE >> commands.tmp
echo options VCAST_USE_STD_STRING TRUE >> commands.tmp
echo options VCAST_USE_VCPP FALSE >> commands.tmp
echo options VCAST_VXWORKS FALSE >> commands.tmp
echo options WHITEBOX NO >> commands.tmp
echo environment build ENV_UNIT.env >> commands.tmp
echo /E:ENV_UNIT tools script run ENV_UNIT.tst >> commands.tmp
echo /E:ENV_UNIT execute batch >> commands.tmp
echo /E:ENV_UNIT reports custom management ENV_UNIT_management_report.html >> commands.tmp
"%VECTORCAST_DIR%\CLICAST"  /L:CPLUSPLUS tools execute commands.tmp false
