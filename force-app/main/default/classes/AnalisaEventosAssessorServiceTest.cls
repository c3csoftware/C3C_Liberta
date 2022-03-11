@isTest
public with sharing class AnalisaEventosAssessorServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('EventRelationService', Test.createStub(IEventRelationService.class, new EventRelationServiceStub()));

        C3C_DIContainer_Injector.createInstance('TaskService', Test.createStub(ITaskService.class, new TaskServiceStub()));

        C3C_DIContainer_Injector.createInstance('AtualizarEventoService', Test.createStub(AtualizarEventoService.class, new AtualizarEventoServiceStub()));

        C3C_DIContainer_Injector.createInstance('EventDomain', IEventDomain.class, 'AnalisaEventosAssessorServiceTest.EventDomainStub');
    }

    // @isTest 
    // static void testeCriarTarefaParaHunter()
    // {
    //     setupInjector();

    //     new AnalisaEventosAssessorService().criarTarefaParaHunter(new List<IEventRelationDomain>{
    //         (IEventRelationDomain) C3C_DIContainer_Injector.newInstance('EventRelationDomain', Schema.getGlobalDescribe().get(new EventRelationMapper().getObjectName()).newSObject())
    //     });
    // }

    @isTest 
    static void testeCoverage()
    {
        AnalisaEventosAssessorService.testCoverage();
    }

    public class AtualizarEventoServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'AtualizarEventoService';
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
                    when 'atualizaAnalisadoBatchDeEvento'
                    {
                        returnValue = null;
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

    public class EventRelationServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'EventRelationService';
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
                    when 'excluirRelacaoDoEvento'
                    {
                        returnValue = null;
                    }

                }

                return returnValue;
            }
    }

    public class EventDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'EventDomain';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}