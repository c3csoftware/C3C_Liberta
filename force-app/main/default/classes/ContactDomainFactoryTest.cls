@isTest
public with sharing class ContactDomainFactoryTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('ContactDomain', ContactDomain.class, 'ContactDomainFactoryTest.ContactDomainStub');
    }

    @isTest 
    static void testeNovaInstanciaContatoComNumeroCelular()
    {
        setupInjector();

        ContactDomainFactory.novaInstanciaContatoComNumeroCelular('numero');
    }

    public class ContactDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'ContactDomain';
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
                    when 'obterMapper'
                    {
                        returnValue = (ContactMapper) C3C_DIContainer_Injector.newInstance('ContactMapper');
                    }

                }

                return returnValue;
            }
    }
}