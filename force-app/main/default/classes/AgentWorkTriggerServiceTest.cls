@isTest
public with sharing class AgentWorkTriggerServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('TipoTarefaService', Test.createStub(ITipoTarefaService.class, new TipoTarefaServiceStub()));

        C3C_DIContainer_Injector.createInstance('InserirTarefaService', Test.createStub(IInserirTarefaService.class, new InserirTarefaServiceStub()));

        C3C_DIContainer_Injector.createInstance('TaskDomain', ITaskDomain.class, 'AgentWorkTriggerServiceTest.TaskDomainStub');

        C3C_DIContainer_Injector.createInstance('BuscarInfomacoesLeadFilhoService', Test.createStub(BuscarInfomacoesLeadFilhoService.class, new BuscarInfomacoesLeadFilhoServiceStub()));
    }

    // @isTest
    // static void testeGerarTarefa()
    // {
    //     setupInjector();
        
    //     IAgentWorkDomain ageDom = (IAgentWorkDomain) C3C_DIContainer_Injector.newInstance('AgentWorkDomain', Schema.getGlobalDescribe().get('AgentWork').newSObject()); 
    //     ageDom.obterMapper().idObjetoRoteado = (String) fflib_IDGenerator.generate(LeadFilho__c.sObjectType);

    //     new AgentWorkTriggerService().gerarTarefa(new List<IAgentWorkDomain>{
    //         ageDom
    //     });
    // }

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
                    when 'obterTipoTarefasPorTipoIgualQualificacaoLead'
                    {
                        ITipoTarefaDomain ale =(ITipoTarefaDomain) C3C_DIContainer_Injector.newInstance('TipoTarefaDomain', Schema.getGlobalDescribe().get('TipoTarefa__c').newSObject());

                        ale.obterMapper().tipo = 'Teste';

                        returnValue = ale;
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
                    when 'newInstance'
                    {
                        returnValue = (ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain', Schema.getGlobalDescribe().get('Task').newSObject());
                    }

                }

                return returnValue;
            }
    }

    public class InserirTarefaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'InserirTarefaService';
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
                    when 'criarListaDeTarefa'
                    {
                        returnValue = null;
                    }

                }

                return returnValue;
            }
    }

    public class BuscarInfomacoesLeadFilhoServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'BuscarInfomacoesLeadFilhoService';
        }

        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    @isTest 
    static void testCoverage()
    {
        AgentWorkTriggerService.testCoverage();
    }
}