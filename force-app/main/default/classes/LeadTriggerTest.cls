@isTest
public class LeadTriggerTest 
{
	@isTest
    static void beforeDeleteTeste()
    {
    	C3C_DIContainer_Injector.createInstance('LeadTriggerHandler', LeadTriggerHandler.class, 'LeadTriggerTest.LeadTriggerHandlerStub');
        Test.startTest();
            Lead leadA = new Lead(LastName='Demo', Company='Teste');
            insert leadA; 
        	delete leadA;
        Test.stopTest();
	}

    @isTest
    static void beforeUpdateTeste()
    {
        C3C_DIContainer_Injector.createInstance('LeadTriggerHandler', LeadTriggerHandler.class, 'LeadTriggerTest.LeadTriggerHandlerStub');

        Test.startTest();
            Lead leadB = new Lead(LastName='[None]', Company='[None]');
            insert leadB;
            leadB.LastName = '[none]';
            update leadB;
        Test.stopTest();
    }
    
    public class LeadTriggerHandlerStub implements System.StubProvider
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