@isTest
public with sharing class EventTriggerTest 
{
    @isTest 
    static void testeInsert()
    {
        C3C_DIContainer_Injector.createInstance('EventTriggerAfterInsertHandler', EventTriggerAfterInsertHandler.class, 'EventTriggerTest.EventTriggerAfterInsertHandler');
        Test.startTest();
            Event acc = new Event(DurationInMinutes=10, ActivityDateTime = Datetime.now() );
            insert acc; 
        Test.stopTest();
    }

    public class EventTriggerAfterInsertHandlerStub implements System.StubProvider
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