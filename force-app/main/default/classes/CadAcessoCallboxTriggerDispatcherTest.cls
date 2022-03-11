@isTest
public with sharing class CadAcessoCallboxTriggerDispatcherTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String,ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('CadAcessoCallboxTriggerHandler', CadAcessoCallboxTriggerHandler.class, 'CadAcessoCallboxTriggerDispatcherTest.CadAcessoCallboxTriggerHandlerStub');
    }

    @isTest 
    static void testeAfterInsert()
    {
        setupInjector();

        new CadAcessoCallboxTriggerDispatcher().afterInsert(new TriggerParameters(
            new List<SObject>{
                Schema.getGlobalDescribe().get('CadastrarAcessoAoCallbox__e').newSObject()
            }, null, null,null,false,false,false,false,false,false,false
        ));
    }

    public class CadAcessoCallboxTriggerHandlerStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'CadAcessoCallboxTriggerHandler';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}