@isTest
public with sharing class MonitoramentoAceiteEventoJobTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('TarefaConversaoLeadService', Test.createStub(ITarefaConversaoLeadService.class, new TarefaConversaoLeadServiceStub()));

        C3C_DIContainer_Injector.createInstance('EventRelationService', Test.createStub(IEventRelationService.class, new EventRelationServiceStub()));

        C3C_DIContainer_Injector.createInstance('MonitoramentoAceiteEventoJob', MonitoramentoAceiteEventoJob.class, 'MonitoramentoAceiteEventoJobTest.MonitoramentoAceiteEventoJobStub');
        
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_SObjectUnitOfWork.class, 'MonitoramentoAceiteEventoJobTest.fflib_SObjectUnitOfWorkStub');
    }

    // Testes

    @isTest 
    static void testeExecute()
    {
        MonitoramentoAceiteEventoJob.testCoverage();
    }

    // STUBS

    public class TarefaConversaoLeadServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TarefaConversaoLeadService';
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
                    when 'criarListaTarefasConversaoLead'
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
                    when 'obterListaEventosDeRoletagemRelacionadoQueForamAceitados'
                    {
                         IEventRelationDomain eventRelationDomain = (IEventRelationDomain) C3C_DIContainer_Injector.newInstance('EventRelationDomain');

                         EventRelationMapper eventRelationMpp = eventRelationDomain.obterMapper();

                         eventRelationMpp.idRelacao = 'qualquer';
                         eventRelationMpp.leadRelacionadoEvento = 'qualquer';

                        returnValue = new List<IEventRelationDomain> {
                            eventRelationDomain,
                            eventRelationDomain
                        };
                    }

                }

                return returnValue;
            }
    }

    public class MonitoramentoAceiteEventoJobStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'MonitoramentoAceiteEventoJob';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
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
}