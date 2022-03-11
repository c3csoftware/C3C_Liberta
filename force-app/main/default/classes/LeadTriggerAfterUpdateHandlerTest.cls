@isTest
public with sharing class LeadTriggerAfterUpdateHandlerTest 
{
    public static Map<String,ClassTested> mapClassTested = new Map<String,ClassTested>();

    public static void setupInjector()
    {
        // C3C_DIContainer_Injector.createInstance('LeadDomain', ILeadDomain.class, 'LeadTriggerAfterUpdateHandlerTest.LeadDomainStub');
        C3C_DIContainer_Injector.createInstance('LeadTriggerAfterUpdateService', Test.createStub(ILeadTriggerAfterUpdateService.class, new LeadTriggerAfterUpdateServiceStub()));
    }

    @isTest 
    static void testeMainEntry()
    {
        setupInjector();

        new LeadTriggerAfterUpdateHandler().mainEntry(new TriggerParameters(
            null, new List<SObject>{Schema.getGlobalDescribe().get('Lead').newSObject(), Schema.getGlobalDescribe().get('Lead').newSObject()}, null, null, false, true, false, false, true, false, false
        ));
    }

    // Stubs
    public class LeadTriggerAfterUpdateServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadTriggerAfterUpdateService';
        }

        public override Map<String,ClassTested> getMapClassTested()
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
                    when 'passarDadosLeadParaConta'
                    {
                        returnValue = null;
                    }

                }

                return returnValue;
            }
    }

    public class LeadDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadDomain';
        }

        public override Map<String,ClassTested> getMapClassTested()
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
                    when 'newInstance'
                    {
                        returnValue = new List<ILeadDomain>{
                            (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain')
                        };
                    }

                }

                return returnValue;
            }

    }
}