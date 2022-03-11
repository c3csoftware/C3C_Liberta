@isTest
public class MembroEquipeTriggerTest 
{
	@isTest
    static void insertTest()
    {
    	C3C_DIContainer_Injector.createInstance('MembroEquipeTriggerHandler', MembroEquipeTriggerHandler.class, 'MembroEquipeTriggerTest.MembroEquipeTriggerHandlerStub');
        Test.startTest();
            MembroEquipe__c membroEquipe = new MembroEquipe__c();
            insert membroEquipe; 
        	delete membroEquipe;
        Test.stopTest();
	}  
    
    public class MembroEquipeTriggerHandlerStub implements System.StubProvider
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