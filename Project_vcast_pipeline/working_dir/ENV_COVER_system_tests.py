'''
TEMPLATE: Default

DESCRIPTION: This template allows the user to configure their own test cases
for execution. The user provides the steps to build their application, the names
of the test cases to run, and the steps to run the given test cases.
'''

import os
from vector.lib.core import system
from vector.lib.core.system import getFilesInDirectory
from vector.lib.core.system import getShell
from vector.lib.core.system import remove_file_if_it_exists
from vector.manage.manualTestDialog import manualTest
from vector.manage.system_tests_factory import Component
from vector.manage.system_tests_factory import ManualTestCase
from vector.manage.system_tests_factory import SystemTests
from vector.manage.system_tests_factory import TestCase
from vector.manage.system_tests_factory import implementation_needed_warning

'''
START OF USER-MODIFIABLE SECTION OF FILE ------------------------------------------

The following configuration data needs to be modified to enable the 
build and execute commands for a particular environment.

NOTE: When setting up path strings on windows, make sure that you
      either use the raw string modifier like this:  r'v:\myDirectory'
      or you double the backslashes, like this:  'v:\\myDirectory'
'''

class SystemTestsConfiguration(object):

    def __init__(self):
        currDir = os.getenv("WORKSPACE",os.getcwd())
        #currDir = currDir.split("@",1)[0]
        working_dir = os.path.join(currDir,"Project_vcast_pipeline/working_dir")

        # These are the environment's variables for spawned processes
        # For example: self.environmentVariables = {}
        self.environmentVariables = {}

        # This is the path to where the build or make command should be executed
        # For example: self.locationWhereWeRunMake = r'd:\vector\sandbox\jenkins\working_dir'
        self.locationWhereWeRunMake = working_dir

        # This is the top level make command needed to build the application
        # For example: self.topLevelMakeCommand = 'make'
        self.topLevelMakeCommand = 'mingw32-make'

        # This is the location where we should run the tests.
        # For example: self.locationWhereWeRunTests = r'd:\vector\sandbox\jenkins\working_dir'
        self.locationWhereWeRunTests = working_dir

        # This is the name of the test application to be invoked when running a test
        # For example: self.nameOfTestExecutable = 'c_executable.exe'
        self.nameOfTestExecutable = 'c_executable.exe'

        # List of TestCase to run against the instrumented executable
        # For example: self.masterListOfTestCases = [TestCase('source_a'), TestCase('source_b')]
        self.masterListOfTestCases = [TestCase('source_a'), TestCase('source_b')]

        # If you have your instrumented application configured to use file output
        # The coverage data will be in the TESTINSS.DAT file after the test is run
        # If you use some other technique to capture the coverage data you will need
        # to update the location and the name of the coverageDataFile
        self.nameOfCoverageDataFile = 'TESTINSS.DAT'

        # Un-comment the following assignment to activate "component coverage."
        # The self.components member is a list of VectorCAST components, where
        # each component is a subset of the files in the application (built in
        # the self._get_component member.)
        # 
        # When component coverage is active, the instrumentation of the
        # application is performed for one component at a time, and the full set
        # of tests are run for each component.  This feature is useful when the
        # fully instrumented application will not fit on the target.
        # 
        # Refer to the User Guide for a complete explanation of the component coverage
        # feature.
        # self.components = [self._get_component()]

    def commandToRunATest(self, test_case):
        '''
        This user defined function should contain the logic to compute the 
        command needed to execute a test.

        By default, we invoke commandToRunTest and pass it a TestCase
        '''
        return './' + self.nameOfTestExecutable + ' ' + test_case.get_name()

    def interpretTestResults(self, testName, returnCode):
        '''
        This user defined function should interpret the results of running a test
        It may be necessary to parse a file, or just to check the return code

        By default, we simply check the return code to indicate pass or fail
        '''
        if returnCode==0:
            return 1,1
        else:
            return 0,1

    def _get_component(self):
        out = Component("example_component")
        out.sources.append('/path/to/source_file.c')
        out.sources.append('/path/to/source_file2.c')
        out.testcases = self.masterListOfTestCases

        return out

'''
END OF USER-MODIFIABLE SECTION OF FILE --------------------------------------------

You should not have the modify the logic below this line but are free to do so.
'''

class DefaultSystemTests(SystemTests):
    '''
    Each instance of this class is capable of building an instrumented
    executable for a VectorCAST/Cover environment and running all of the
    system tests for that environment. 
    '''
    def __init__(self):
        super(DefaultSystemTests, self).__init__()
        self.configuration = SystemTestsConfiguration()
        self.process_environment.update(self.configuration.environmentVariables)

    def build(self):
        '''
        Build an executable for system testing.

        @return
        This function will return 0 upon success or non-zero otherwise.
        '''
        if self._build_implementation_needed():
            implementation_needed_warning() 

            return 1

        # The following example code should help you understand the code to add.

        # cd to the place where make should be run
        with system.cd(self.configuration.locationWhereWeRunMake):
            # The self.run() command will log the stdout from the make
            return self.run(self.configuration.topLevelMakeCommand)

    def get_test_cases(self):
        '''
        Return a list of TestCase for this VectorCAST/Cover environment.
        These test cases will be passed into the run_test_cases() method when 
        VectorCAST needs to run a test.

        @return
        A list of TestCase.
        '''
        if self._test_implementation_needed():
            implementation_needed_warning()

            return []                          

        # The following example code should help you understand the code to add

        return self.configuration.masterListOfTestCases

    def run_test_cases(self, test_cases):
        '''
        Run the given TestCases for system testing.

        @return
        This function will return 0 upon success or non-zero otherwise.
        '''
        status = 0
        for test_case in test_cases:
            status = self.run_test_case(test_case) or status

        return status

    def run_test_case(self, test_case):
        '''
        Run the given TestCase

        @return
        This function gets called one for each test to run
        it should return 0 upon success or non-zero otherwise.
        '''
        if self._test_implementation_needed():
            implementation_needed_warning()

            return 1

        # The following example code should help you understand the code to add

        with system.cd(self.configuration.locationWhereWeRunTests):
            # If you have your instrumented application configured to use file output
            # The coverage data will be in the TESTINSS.DAT file after the test is run
            remove_file_if_it_exists(self._get_coverage_data_file_path())

            # Run the correct test, based on the TestCase type
            if test_case.is_manual():
                commandStatus = manualTest(
                    test_case.get_name(),
                    self.configuration.locationWhereWeRunTests,
                    test_case.get_command(),
                    test_case.get_steps())
                # -1 means a manual test was cancelled so we do not process status or coverage
                if commandStatus == -1:
                    return commandStatus
            else:
                # Show a custom 'running test' message
                commandStatus = self.run(
                    self.configuration.commandToRunATest(test_case),
                    "Running test: " + test_case.get_name())

            # Interpret the test results
            passed_count, total_count = self.configuration.interpretTestResults(
                test_case.get_name(),
                commandStatus)

            # The call to save_test_case_result() stores the coverage
            # data and pass / fail status for the test
            addTestinssExitCode = self.save_test_case_result(
                test_name=test_case.get_name(),
                testinss=self._get_coverage_data_file_path(),
                passed=passed_count,
                total=total_count)

            return commandStatus or addTestinssExitCode

    def get_components(self):
        '''Return the components for this VectorCAST/Cover environment.

        @return
        A list of Component.
        '''
        if hasattr(self.configuration, 'components'):
            return self.configuration.components

        return []

    def _build_implementation_needed(self):
        return not (self.configuration.locationWhereWeRunMake and
                    self.configuration.topLevelMakeCommand)

    def _test_implementation_needed(self):
        return not (self.configuration.masterListOfTestCases and
                    self.configuration.locationWhereWeRunTests and
                    self.configuration.nameOfCoverageDataFile and
                    self.configuration.nameOfTestExecutable)

    def _get_coverage_data_dir(self):
        cfg_dir = self.get_config_coverage_results_dir()
        if cfg_dir:
            return cfg_dir
        else:
            return self.configuration.locationWhereWeRunTests

    def _get_coverage_data_file_path(self):
        return os.path.join(
            self._get_coverage_data_dir(),
            self.configuration.nameOfCoverageDataFile)
