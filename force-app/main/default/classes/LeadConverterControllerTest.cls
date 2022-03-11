@isTest
public with sharing class LeadConverterControllerTest 
{
    // CONTEXT

    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('ConverterLeadService', Test.createStub(IConverterLeadService.class, new ConverterLeadServiceStub()));
    }

    // TESTES

    @isTest 
    static void testeLeadConverterController()
    {
        LeadConverterController.testCoverage();
    }

    // STUBS

    public class ConverterLeadServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'ConverterLeadService';
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
                    when 'pegarLeadPorId'
                    {
                        returnValue = null;
                    }

                    when 'converterLead'
                    {
                        returnValue = new System.Pagereference('https://google.com');
                    }

                }

                return returnValue;
            }
    }
}