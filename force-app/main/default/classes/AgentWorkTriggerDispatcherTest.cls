@isTest
public with sharing class AgentWorkTriggerDispatcherTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String,ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('AgentWorkTriggerHandler', AgentWorkTriggerHandler.class, 'AgentWorkTriggerDispatcherTest.AgentWorkTriggerHandlerStub');
    }

    @isTest
    static void testeBeforeInsert()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new AgentWorkTriggerDispatcher().beforeInsert(new TriggerParameters(new List<SObject>{Schema.getGlobalDescribe().get('AgentWork').newSObject()},null,null,null,false,false,false,false,false,false,false));

        // THEN
    }

    @isTest
    static void testeBulkBefore()
    {
        setupInjector();

        new AgentWorkTriggerDispatcher().bulkBefore();
    }

    @isTest
    static void testeAndFinally()
    {
        setupInjector();

        new AgentWorkTriggerDispatcher().andFinally();
    }

    public class AgentWorkTriggerHandlerStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'AgentWorkTriggerHandler';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}