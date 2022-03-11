@isTest
public with sharing class EventTriggerAfterInsertHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('EventTriggerAfterInsertService', Test.createStub (EventTriggerAfterInsertService.class, new EventTriggerAfterInsertServiceStub()));

        C3C_DIContainer_Injector.createInstance('EventTriggerBeforeInsertService', Test.createStub (EventTriggerBeforeInsertService.class, new EventTriggerBeforeInsertServiceStub()));
    }

    @isTest
    static void testeMainEntry()
    {
        setupInjector();
        
        new EventTriggerAfterInsertHandler().mainEntry(new TriggerParameters(null,new List<SObject>{
            Schema.getGlobalDescribe().get('Event').newSObject()
        },null,null,false,true,false,true,false,false,false));
    }

    public class EventTriggerAfterInsertServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'EventTriggerAfterInsertService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
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
                when 'mudarStatusLeadParaEmAndamento'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }

    public class EventTriggerBeforeInsertServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'EventTriggerBeforeInsertService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
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
                when 'atualizarCamposDeEvento'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }
}