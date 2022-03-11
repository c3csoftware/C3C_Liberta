@isTest
public class AccountTriggerTest 
{
	@isTest
    static void insertTest()
    {
    	C3C_DIContainer_Injector.createInstance('AccountTriggerHandler', AccountTriggerHandler.class, 'AccountTriggerTest.AccountTriggerHandlerStub');
        Test.startTest();
            User usuario = [SELECT id FROM User Where Email = 'mauro.araripe@c3csoftware.com.br' AND LastName = 'Araripe' LIMIT 1];
            Account accA =new Account(Name='Demo', OwnerId=usuario.Id);
            insert accA; 
        Test.stopTest();
	}  
    
    public class AccountTriggerHandlerStub implements System.StubProvider
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