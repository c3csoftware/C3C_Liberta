@isTest
public with sharing class AtualizarEventoServiceTest 
{
    // CONTEXT

    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'AtualizarEventoServiceTest.fflib_SObjectUnitOfWorkStub');

    }


    // TESTES

    @isTest 
    static void testeAtualizaAnalisadoBatchDeEvento()
    {
        setupInjector();

        new AtualizarEventoService().atualizaAnalisadoBatchDeEvento(new List<IEventDomain> {
            (IEventDomain) C3C_DIContainer_Injector.newInstance('EventDomain', Schema.getGlobalDescribe().get(new EventMapper().getObjectName()).newSObject())
        });
    }

    // STUBS

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