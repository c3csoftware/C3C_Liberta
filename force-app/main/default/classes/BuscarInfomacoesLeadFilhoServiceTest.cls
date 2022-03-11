@isTest
public with sharing class BuscarInfomacoesLeadFilhoServiceTest 
{
    private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('LeadFilhoSelector', Test.createStub(LeadFilhoSelector.class, new LeadFilhoSelectorStub()));

        C3C_DIContainer_Injector.createInstance('LeadFilhoDomain', ILeadFilhoDomain.class, '.BuscarInfomacoesLeadFilhoServiceTest.LeadFilhoDomainStub');
    }

    @isTest 
    public static void testeObterLeadFilhoPorId()
    {
        // GIVEN
        setupInjector();

        // WHEN
        // ILeadFilhoDomain leadFilhoDomain = new BuscarInfomacoesLeadFilhoService().obterLeadFilhoPorId('');

        // // THEN
        // System.assert(mapaDeTesteDaClasse.containsKey('LeadFilhoSelector'), 'A classe LeadFilhoSelector deveria ser chamada nesse método');
        // System.assert(mapaDeTesteDaClasse.get('LeadFilhoSelector').containsMethod('obterLeadFilhoPorId'), 'O método  obterLeadFilhoPorId da classe LeadFilhoSelector deveria ser chamado nesse método');
    }

    @isTest
    public static void testeObterMapaLeadFilhoComLead()
    {
        // GIVEN
        setupInjector();

        // WHEN
        // Map<String,Object> listaLeadFilho = new BuscarInfomacoesLeadFilhoService().obterMapaLeadFilhoComLead(new List<String> {
        //     Schema.getGlobalDescribe().get('Lead').newSObject().id
        //   });

        // // THEN
        // System.assert(mapaDeTesteDaClasse.containsKey('LeadFilhoSelector'), 'A classe LeadFilhoSelector deveria ser chamada nesse método');
    }

    // STUBS
    public class LeadFilhoSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadFilhoSelector';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapaDeTesteDaClasse;
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
                when 'obterLeadFilhoPorId'
                {
                    returnValue = Schema.getGlobalDescribe().get('LeadFilho__c').newSObject();
                }

                when 'obterMapaLeadFilhoComLead'
                {
                    returnValue = new List<SObject>{
                        Schema.getGlobalDescribe().get('LeadFilho__c').newSObject(),
                        Schema.getGlobalDescribe().get('LeadFilho__c').newSObject()
                    };
                }

                when 'obterLeadFilhoPorListaIdLeadFilho'
                {
                    returnValue = new List<SObject>{
                        Schema.getGlobalDescribe().get('LeadFilho__c').newSObject(),
                        Schema.getGlobalDescribe().get('LeadFilho__c').newSObject()
                    };
                }
            }

            return returnValue;
        }
    }

    public class LeadFilhoDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadFilhoDomain';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapaDeTesteDaClasse;
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
                when 'obterContasPorCodigosXP'
                {
                    returnValue = new List<SObject>();
                }
            }

            return returnValue;
        }
    }

    @isTest 
    static void testCoverage()
    {
        BuscarInfomacoesLeadFilhoService.testCoverage();
    }
}