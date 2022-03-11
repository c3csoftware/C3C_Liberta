@isTest
public class ProdutoTriggerTest 
{
	@isTest
    static void insertTest()
    {
    	C3C_DIContainer_Injector.createInstance('ProdutoTriggerHandler', ProdutoTriggerHandler.class, 'ProdutoTriggerTest.ProdutoTriggerHandlerStub');
        Test.startTest();
        	Account acc =new Account(Name='Demo');
            insert acc; 
            Produto__c prod = new Produto__c(Conta__c = acc.Id);
            insert prod; 
        Test.stopTest();
	}  
    
    public class ProdutoTriggerHandlerStub implements System.StubProvider
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