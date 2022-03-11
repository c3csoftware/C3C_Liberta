@isTest
public with sharing class EVT_CadastrarAcessoAoCallboxTriggerTest 
{    
    @isTest
    static void insertTest()
    {
    	C3C_DIContainer_Injector.createInstance('CadAcessoCallboxTriggerHandler', CadAcessoCallboxTriggerHandler.class, 'EVT_CadastrarAcessoAoCallboxTriggerTest.CadAcessoCallboxTriggerHandlerStub');
        Test.startTest();
        	
        Test.stopTest();
	}  
    
    public class CadAcessoCallboxTriggerHandlerStub implements System.StubProvider
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