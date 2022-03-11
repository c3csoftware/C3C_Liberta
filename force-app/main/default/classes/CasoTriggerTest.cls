@isTest
public with sharing class CasoTriggerTest 
{

    @isTest
    static void beforeInsertTeste()
    {
        C3C_DIContainer_Injector.createInstance('CasoTriggerBeforeInsertHandler', CasoTriggerBeforeInsertHandler.class, 'LeadTriggerTest.CasoTriggerBeforeInsertHandlerStub');

        Test.startTest();
            Case caseA = new Case(CategoriaAtendimento__c='Backoffice', TipoAtendimento__c='Aluguel de ativos - BTC', Status = 'Open', Origin = 'Web');
            insert caseA;
            // leadB.LastName = '[none]';
            // update leadB;
        Test.stopTest();
    }

    @isTest
    static void beforeUpdateTeste()
    {
        C3C_DIContainer_Injector.createInstance('CasoTriggerBeforeUpdateHandler', CasoTriggerBeforeUpdateHandlerStub.class, 'LeadTriggerTest.CasoTriggerBeforeUpdateHandlerStub');

        Test.startTest();
            Case caseA = new Case(CategoriaAtendimento__c='Backoffice', TipoAtendimento__c='Aluguel de ativos - BTC', Status = 'Open', Origin = 'Web');
            insert caseA;
            caseA.Status = 'Encerrado';
            update caseA;
        Test.stopTest();
    }

    @isTest
    static void afterUpdateTeste()
    {
        C3C_DIContainer_Injector.createInstance('CasoTriggerAfterUpdateHandler', CasoTriggerAfterUpdateHandlerStub.class, 'LeadTriggerTest.CasoTriggerAfterUpdateHandlerStub');

        Test.startTest();
            Case caseA = new Case(CategoriaAtendimento__c='Backoffice', TipoAtendimento__c='Aluguel de ativos - BTC', Status = 'Open', Origin = 'Web');
            insert caseA;
            caseA.Status = 'Encerrado';
            update caseA;
        Test.stopTest();
    }

    public class CasoTriggerBeforeInsertHandlerStub implements System.StubProvider
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

    public class CasoTriggerAfterUpdateHandlerStub implements System.StubProvider
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

    public class CasoTriggerBeforeUpdateHandlerStub implements System.StubProvider
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