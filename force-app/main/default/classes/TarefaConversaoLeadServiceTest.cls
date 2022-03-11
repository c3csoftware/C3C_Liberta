@isTest
public with sharing class TarefaConversaoLeadServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('TipoTarefaService', Test.createStub(ITipoTarefaService.class, new TipoTarefaServiceStub()));
        C3C_DIContainer_Injector.createInstance('TaskService', Test.createStub(ITaskService.class, new TaskServiceStub()));
    }

    @isTest 
    static void testeCriarTarefaConversaoLead()
    {
        setupInjector();

        new TarefaConversaoLeadService().criarTarefaConversaoLead(' ', ' ');
    }

    @isTest 
    static void testeCriarListaTarefasConversaoLead()
    {
        setupInjector();

        new TarefaConversaoLeadService().criarListaTarefasConversaoLead(new List<Map<String, Object>>{
            new Map<String, Object> {
                'idResponsavelTarefa' => 'Teste',
                'idLead' => 'Teste'
            }
        });
    }

    public class TipoTarefaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TipoTarefaService';
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
                    when 'obterTipoTarefaComNome'
                    {
                        returnValue = (ITipoTarefaDomain) C3C_DIContainer_Injector.newInstance('TipoTarefaDomain', Schema.getGlobalDescribe().get('TipoTarefa__c').newSObject());
                    }

                }

                return returnValue;
            }
    }

    public class TaskServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TaskService';
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
                    when 'inserirListaTarefa'
                    {
                        returnValue = null;
                    }

                }

                return returnValue;
            }
    }
}