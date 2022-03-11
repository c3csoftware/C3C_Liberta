@isTest
public with sharing class PedidoTriggerTest 
{
    @isTest
    static void testeBeforeInsert()
    {
        C3C_DIContainer_Injector.createInstance('PedidoTriggerBeforeInsertHandler', PedidoTriggerBeforeInsertHandler.class, 'PedidoTriggerTest.PedidoTriggerBeforeInsertHandlerStub');

        Test.startTest();
            Pedido__c Pedido = new Pedido__c(Name = 'Test');
            insert Pedido; 
        Test.stopTest();
    }

    @isTest
    static void testeAfterInsert()
    {
        C3C_DIContainer_Injector.createInstance('PedidoTriggerAfterInsertHandler', PedidoTriggerAfterInsertHandler.class, 'PedidoTriggerTest.PedidoTriggerAfterInsertHandlerStub');

        Test.startTest();
            Pedido__c Pedido = new Pedido__c(Name = 'Test');
            insert Pedido; 
        Test.stopTest();
    }

    public class PedidoTriggerBeforeInsertHandlerStub implements System.StubProvider
    {
        public Object handleMethodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> 
            listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {     
            Object returnValue;
            
            return returnValue;
        }
    }

    public class PedidoTriggerAfterInsertHandlerStub implements System.StubProvider
    {
        public Object handleMethodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> 
            listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {     
            Object returnValue;
            
            return returnValue;
        }
    }
}