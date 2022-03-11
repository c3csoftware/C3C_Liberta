@isTest
public with sharing class AlterarStatusLeadServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_SObjectUnitOfWork.class, 'AlterarStatusLeadServiceTest.fflib_SObjectUnitOfWorkStub');
        C3C_DIContainer_Injector.createInstance('LeadSelector', Test.createStub (LeadSelector.class, new LeadSelectorStub()));
        C3C_DIContainer_Injector.createInstance('LeadDomain', Test.createStub (LeadDomain.class, new LeadDomainStub()));
    }

    @isTest
    static void testeMudarStatusLead()
    {
        //GIVEN
        setupInjector();

        //WHEN
        new AlterarStatusLeadService().mudarStatusLead(new Map<String, Object>{
            'idLead' => 'teste',
            'status' => 'Teste1'
        });

        //THEN
        System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'O método deveria chamar o fflib_SObjectUnitOfWork');

        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'O método deveria chamar o método "commitWork" da fflib_SObjectUnitOfWork');
    }
    
        @isTest
    static void testeMudarStatusLeadParaPrimeiroContato()
    {
        //GIVEN
        setupInjector();

        //WHEN
        new AlterarStatusLeadService().mudarStatusLeadNovoParaPrimeiroContato(new Map<String, Object>{
            'idLead' => 'teste',
            'status' => 'Teste1'
        });

        //THEN
        System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'O método deveria chamar o fflib_SObjectUnitOfWork');

        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'O método deveria chamar o método "commitWork" da fflib_SObjectUnitOfWork');
    }

    public class fflib_SObjectUnitOfWorkStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'fflib_SObjectUnitOfWork';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
    
    public class LeadSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadSelector';
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
                when 'obterLeadComStatusNovoPorIdsDoLead'
                {
                    returnValue = new List<Lead>{new Lead(LastName = 'Test', Status__c = 'Novo')};
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
                when 'construirMapLeadMapper'
                {
                    returnValue = new Map<String, LeadMapper>{
                        'Test' => new LeadMapper()
                    };
                }
            }
            
            return returnValue;
        }
    }
}