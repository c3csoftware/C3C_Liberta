@isTest
public with sharing class EventTriggerDispatcherTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String,ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('EventTriggerAfterInsertHandler', EventTriggerAfterInsertHandler.class, 'EventTriggerDispatcherTest.EventTriggerAfterInsertHandlerStub');
    }

    @isTest
    static void testeBeforeInsert()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new EventTriggerDispatcher().beforeInsert(new TriggerParameters(new List<SObject>{Schema.getGlobalDescribe().get('Event').newSObject()},null,null,null,false,false,false,false,false,false,false));

        // THEN
    }

    @isTest
    static void testeBulkBefore()
    {
        setupInjector();

        new EventTriggerDispatcher().bulkBefore();
    }

    @isTest
    static void testeAndFinally()
    {
        setupInjector();

        new EventTriggerDispatcher().andFinally();
    }

    public class EventTriggerAfterInsertHandlerStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'EventTriggerAfterInsertHandler';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}