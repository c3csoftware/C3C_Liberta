@isTest 
public with sharing class InstanciaRespostaTriggerTest 
{
    @isTest 
    static void testeInserir()
    {
        C3C_DIContainer_Injector.createInstance('InstancRespTriggerAfterInsertHandler', InstancRespTriggerAfterInsertHandler.class, 'InstanciaRespostaTriggerTest.InstancRespTriggerAfterInsertHandlerStub');
        Test.startTest();
            InstanciaResposta__c acc = new InstanciaResposta__c();
            insert acc; 
        Test.stopTest();
    }

    @isTest 
    static void testeUpdate()
    {
        C3C_DIContainer_Injector.createInstance('InstancRespTriggerAfterUpdateHandler', InstancRespTriggerAfterUpdateHandler.class, 'InstanciaRespostaTriggerTest.InstancRespTriggerAfterUpdateHandlerStub');
        Test.startTest();
            InstanciaResposta__c acc = new InstanciaResposta__c();
            insert acc; 
            acc.RespostaDissertativa__c = 'oux';
            update acc; 
        Test.stopTest();
    }
    
    public class InstancRespTriggerAfterInsertHandlerStub implements System.StubProvider
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

    public class InstancRespTriggerAfterUpdateHandlerStub implements System.StubProvider
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