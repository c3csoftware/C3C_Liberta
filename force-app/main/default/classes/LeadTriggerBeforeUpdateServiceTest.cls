@isTest
public with sharing class LeadTriggerBeforeUpdateServiceTest 
{
    public static Map<String,ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('LeadDomain', ILeadDomain.class, 'LeadTriggerBeforeUpdateServiceTest.LeadDomainStub');
    }

    @isTest
    static void testeAtualizarLeads()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new LeadTriggerBeforeUpdateService().atualizarLeads(new List<ILeadDomain>{
            (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain'),
            (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain')
        });

        // THEN
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
                when 'obterMapper'
                {
                    LeadMapper leadMpp = (LeadMapper) C3C_DIContainer_Injector.newInstance('LeadMapper');

                    leadMpp.sobrenome = '[none]';
                    leadMpp.empresa = '[None]';

                    returnValue = leadMpp;
                }
            }
            
            return returnValue;
        }
    }
}