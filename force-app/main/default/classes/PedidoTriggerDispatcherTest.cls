@isTest
public with sharing class PedidoTriggerDispatcherTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('PedidoTriggerBeforeInsertHandler', PedidoTriggerBeforeInsertHandler.class, 'PedidoTriggerDispatcherTest.PedidoTriggerBeforeInsertHandlerStub');
        C3C_DIContainer_Injector.createInstance('PedidoTriggerAfterInsertHandler', PedidoTriggerAfterInsertHandler.class, 'PedidoTriggerDispatcherTest.PedidoTriggerAfterInsertHandlerStub');
    }

    @isTest
    static void testeBeforeInsert()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new PedidoTriggerDispatcher().beforeInsert(new TriggerParameters(new List<SObject>{Schema.getGlobalDescribe().get('Pedido__c').newSObject()},null,null,null,false,false,false,false,false,false,false));

        // THEN
    }

    @isTest
    static void testeAfterInsert()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new PedidoTriggerDispatcher().afterInsert(new TriggerParameters(new List<SObject>{Schema.getGlobalDescribe().get('Pedido__c').newSObject()},null,null,null,false,false,false,false,false,false,false));

        // THEN
    }

    @isTest
    static void testeBulkBefore()
    {
        setupInjector();

        new PedidoTriggerDispatcher().bulkBefore();
    }

    @isTest
    static void testeAndFinally()
    {
        setupInjector();

        new PedidoTriggerDispatcher().andFinally();
    }

    // STUBS

    public class PedidoTriggerBeforeInsertHandlerStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'PedidoTriggerBeforeInsertHandler';
        }
    }
    public class PedidoTriggerAfterInsertHandlerStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'PedidoTriggerAfterInsertHandler';
        }
    }
}