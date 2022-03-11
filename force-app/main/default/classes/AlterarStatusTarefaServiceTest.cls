@isTest
public with sharing class AlterarStatusTarefaServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'AlterarStatusTarefaServiceTest.fflib_SObjectUnitOfWorkStub');

        C3C_DIContainer_Injector.createInstance('TaskDomain', ITaskDomain.class, 'AlterarStatusTarefaServiceTest.TaskDomainStub');

    }

    @isTest
    static void testeMudarStatusTask()
    {
        setupInjector();

        new AlterarStatusTarefaService().mudarStatusTask(new Map<String, Object>{
            'idTask' => 'status'
        });
    }

    public class fflib_SObjectUnitOfWorkStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'fflib_SObjectUnitOfWork';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class TaskDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TaskDomain';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}