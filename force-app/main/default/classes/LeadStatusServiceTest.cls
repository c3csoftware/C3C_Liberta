@isTest
public with sharing class LeadStatusServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('LeadStatusSelector', Test.createStub(ILeadStatusSelector.class, new LeadStatusSelectorStub()));

        C3C_DIContainer_Injector.createInstance('LeadStatusDomain', ILeadStatusDomain.class, 'LeadStatusServiceTest.LeadStatusDomainStub');
    }

    @isTest 
    static void testeRetornarLabelDeLeadConvertido()
    {
        setupInjector();

        new LeadStatusService().retornarLabelDeLeadConvertido();
    }

    public class LeadStatusSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadStatusSelector';
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
                    when 'buscarLeadStatusDeStatusConvertido'
                    {
                        returnValue = new List<SObject> {
                            schema.getGlobalDescribe().get('Lead').newSObject()
                        };
                    }

                }

                return returnValue;
            }
    }

    public class LeadStatusDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadStatusDomain';
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
                    when 'pegarMasterLabel'
                    {
                        returnValue = 'Ouxx';
                    }

                }

                return returnValue;
            }
    }
}