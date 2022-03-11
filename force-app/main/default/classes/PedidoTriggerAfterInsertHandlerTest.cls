@isTest
public with sharing class PedidoTriggerAfterInsertHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();
    
    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('PedidoTriggerService', Test.createStub(PedidoTriggerService.class, new PedidoTriggerServiceStub()));
    }

    @isTest 
    static void testeMainEntry()
    {
        setupInjector();

        new PedidoTriggerAfterInsertHandler().mainEntry(new TriggerParameters(null,new List<SObject>{
            Schema.getGlobalDescribe().get('Pedido__c').newSObject()
        },null,null,false,true,false,true,false,false,false));
    }

    @isTest 
    static void testeInProgressEntry()
    {
        new PedidoTriggerAfterInsertHandler().inProgressEntry(new TriggerParameters(null,new List<SObject>{
            Schema.getGlobalDescribe().get('Pedido__c').newSObject()
        },null,null,false,true,false,true,false,false,false));
    }

    @isTest 
    static void testeUpdateObjects()
    {
        new PedidoTriggerAfterInsertHandler().updateObjects();
    }


    // STUBS
    public class PedidoTriggerServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'PedidoTriggerService';
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
                when 'criarContasParaPedidos'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }
}