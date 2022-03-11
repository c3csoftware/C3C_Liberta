@isTest
public with sharing class AgentWorkTriggerHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('AgentWorkTriggerService', Test.createStub(AgentWorkTriggerService.class, new AgentWorkTriggerServiceStub()));
    }

    @isTest
    static void testeMainEntry()
    {
        setupInjector();

        new AgentWorkTriggerHandler().mainEntry(new TriggerParameters(null,new List<SObject>{
            Schema.getGlobalDescribe().get('AgentWork').newSObject()
        },null,null,true,false,false,true,false,false,false));
    }

    public class AgentWorkTriggerServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'AgentWorkTriggerService';
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
                when 'gerarTarefa'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }

    public class AgentWorkDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'AgentWorkDomain';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}