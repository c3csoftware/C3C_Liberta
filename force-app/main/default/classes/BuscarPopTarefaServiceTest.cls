@isTest 
public with sharing class BuscarPopTarefaServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('TaskSelector', Test.createStub(ITaskSelector.class, new TaskSelectorStub()));

        C3C_DIContainer_Injector.createInstance('TaskDomain', ITaskDomain.class, 'BuscarPopTarefaServiceTest.TaskDomainStub');

    }

    @isTest 
    static void testeObterTarefaPorIdComPop()
    {
        setupInjector();

        new BuscarPopTarefaService().obterTarefaPorIdComPop('idRegistro');
    }

    public class TaskSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TaskSelector';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override Object methodCall(
            Object stubbedObject,
            String stubbedMethodName,
            Type returnType,
            List<System.Type> listOfParamTypes,
            List<String> listOfParamNames,
            List<Object> listOfArgs
            )
            {
                Object returnValue;

                switch on stubbedMethodName
                {
                    when 'obterTarefaPorIdComPop'
                    {
                        returnValue = Schema.getGlobalDescribe().get(new TaskMapper().getObjectName()).newSObject();
                    }

                }

                return returnValue;
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

        public override Object methodCall(
            Object stubbedObject,
            String stubbedMethodName,
            Type returnType,
            List<System.Type> listOfParamTypes,
            List<String> listOfParamNames,
            List<Object> listOfArgs
            )
            {
                Object returnValue;

                switch on stubbedMethodName
                {
                    when 'obterMapper'
                    {
                        returnValue = new TaskMapper();
                    }

                }

                return returnValue;
            }
    }
}