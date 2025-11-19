import os
from vector.manage.system_tests import DefaultSystemTests
from vector.manage.system_tests import getShell
from vector.manage.system_tests_factory import ManualTestCase
from vector.manage.system_tests_factory import Component
from vector.manage.system_tests_factory import SystemTestsFactory
from vector.manage.system_tests_factory import TestCase

''' 
The following configuration data needs to be modified to enable the 
build and execute commands for a particular environment.

NOTE: When setting up path strings on windows, make sure that you
      either use the raw string modifier like this:  r'v:\myDirectory'
      or you double the backslashes, like this:  'v:\\myDirectory'
'''

class SystemTestsConfiguration(object):
    def __init__(self):
        currDir = os.getenv("WORKSPACE",os.getcwd())
        currDir = currDir.split("@",1)[0]
        working_dir = os.path.join(currDir,"Project_vcast_pipeline/working_dir")

        # Set the environment's variables for spawned processes
        self.environmentVariables = {'PATH': os.pathsep.join([r'C:/VCAST/2018sp5/MinGW/bin', os.environ['PATH']])}

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
        # the _get_*_component members.)
        # 
        # When component coverage is active, the instrumentation of the
        # application is performed for one component at a time, and the full set
        # of tests are run for each component.  This feature is useful when the
        # fully instrumented application will not fit on the target.
        # 
        # Refer to the User Guide for a complete explanation of the component coverage
        # feature.
        # self.components = [self._get_manager_component(), self._get_database_component()]

    def getManualTestCaseSteps(self):
        filename = os.path.join(self.locationWhereWeRunTests, 'manual_test_case_steps.txt')
        steps = []
        steps.append('In shell provided, run %s without any args.' % self.nameOfTestExecutable)
        steps.append('EXPECTED: Usage is displayed.\n')
        with open(filename, 'w') as file:
              file.write("\n".join(steps))

        return filename

    def commandToRunATest (self, test_case):
        '''
        This user defined function should contain the logic to compute the 
        command needed to execute a test.

        By default, we invoke commandToRunTest and pass it a TestCase
        '''
        return './' + self.nameOfTestExecutable + ' ' + test_case.get_name()

    def interpretTestResults (self, testName, returnCode):
        '''
        This user defined function should interpret the results of running a test
        It may be necessary to parse a file, or just to check the return code

        By default, we simply check the return code to indicate pass or fail
        '''
        if returnCode==0:
            return 1,1
        else:
            return 0,1

    def _get_manager_component(self):
        out = Component("manager_component")
        out.sources.append(os.path.join(self.locationWhereWeRunMake, 'manager.c'))
        out.sources.append(os.path.join(self.locationWhereWeRunMake, 'manager_driver.c'))
        out.testcases = self.masterListOfTestCases

        return out

    def _get_database_component(self):
        out = Component("database_component")
        out.sources.append(os.path.join(self.locationWhereWeRunMake, 'database.c'))
        out.sources.append(os.path.join(self.locationWhereWeRunMake, 'manager_driver.c'))
        out.testcases = self.masterListOfTestCases

        return out

# Register the class with VectorCAST
SystemTestsFactory.register({'default': DefaultSystemTests(SystemTestsConfiguration())})
