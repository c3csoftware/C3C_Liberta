@isTest
public with sharing class LeadTriggerBeforeInsertHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('LeadTriggerBeforeInsertService', Test.createStub(ILeadTriggerBeforeInsertService.class, new LeadTriggerBeforeInsertServiceStub()));
    }

    @isTest
    static void testeMainEntry()
    {
        setupInjector();

        new LeadTriggerBeforeInsertHandler().mainEntry(new TriggerParameters(null,new List<SObject>{
            Schema.getGlobalDescribe().get('Lead').newSObject(), Schema.getGlobalDescribe().get('Lead').newSObject()
        },null,null,false,false,false,false,false,false,false)
        );
    }

    public class LeadTriggerBeforeInsertServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadTriggerBeforeInsertService';
        }

        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class LeadDomainStub  extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadDomain';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class TriggerParametersStub  extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TriggerParameters';
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
                when 'newList'
                {
                    returnValue = new List<SObject>{
                        Schema.getGlobalDescribe().get('Lead').newSObject(),
                        Schema.getGlobalDescribe().get('Lead').newSObject()
                    };
                }

            }
            
            return returnValue;
        }
    }
}