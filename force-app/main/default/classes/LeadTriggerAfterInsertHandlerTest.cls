@isTest
public with sharing class LeadTriggerAfterInsertHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('LeadTriggerAfterInsertService', Test.createStub(LeadTriggerAfterInsertService.class, new LeadTriggerAfterInsertServiceStub()));
    }

    @isTest
    static void testeMainEntry()
    {
        setupInjector();

        new LeadTriggerAfterInsertHandler().mainEntry(new TriggerParameters(null,new List<SObject>{
            Schema.getGlobalDescribe().get('Lead').newSObject()
        },null,null,false,true,false,true,false,false,false));
    }

    public class LeadTriggerAfterInsertServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadTriggerAfterInsertService';
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
                when 'converterLeadCasoPossuaContaNaBase'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }
}