@isTest
public with sharing class InstanciaRespostaTriggerDispatcherTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String,ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('InstancRespTriggerAfterInsertHandler', InstancRespTriggerAfterInsertHandler.class, 'InstanciaRespostaTriggerDispatcherTest.InstancRespTriggerAfterInsertHandlerStub');

        C3C_DIContainer_Injector.createInstance('InstancRespTriggerAfterUpdateHandler', InstancRespTriggerAfterUpdateHandler.class, 'InstanciaRespostaTriggerDispatcherTest.InstancRespTriggerAfterUpdateHandlerStub');

    }

    @isTest
    static void testeAfterInsert()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new InstanciaRespostaTriggerDispatcher().afterInsert(new TriggerParameters(new List<SObject>{Schema.getGlobalDescribe().get('AgentWork').newSObject()},null,null,null,false,true,false,true,false,false,false));

        // THEN
    }

    @isTest
    static void testeAfterUpdate()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new InstanciaRespostaTriggerDispatcher().afterUpdate(new TriggerParameters(new List<SObject>{Schema.getGlobalDescribe().get('AgentWork').newSObject()},null,null,null,false,true,false,false,true,false,false));

        // THEN
    }

    @isTest
    static void testeBulkBefore()
    {
        setupInjector();

        new InstanciaRespostaTriggerDispatcher().bulkBefore();
    }

    @isTest
    static void testeAndFinally()
    {
        setupInjector();

        new InstanciaRespostaTriggerDispatcher().andFinally();
    }

    // STUBS

    public class InstancRespTriggerAfterInsertHandlerStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'InstancRespTriggerAfterInsertHandler';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class InstancRespTriggerAfterUpdateHandlerStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'InstancRespTriggerAfterUpdateHandler';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}