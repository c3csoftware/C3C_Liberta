@isTest
public class LeadServiceTest 
{
	public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();
    
    static void setupInjector()
    {
		C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'LeadServiceTest.fflib_SObjectUnitOfWorkStub');
        C3C_DIContainer_Injector.createInstance('LeadDomain', ILeadDomain.class, 'LeadServiceTest.LeadDomainStub');
        C3C_DIContainer_Injector.createInstance('LeadSelector', Test.createStub(ILeadSelector.class, new LeadSelectorStub()));
    }
    
    @isTest
    public static void testInserirAtualizarLeadPorActiveCampaignId()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        new LeadService().inserirAtualizarLeadPorActiveCampaignId('123', 'Teste', 'Teste', 'teste@teste.com', 'Teste', 'Teste');
        
        //THEN
        System.assert(mapClassTested.containsKey('LeadDomain'), 'O método deveria chamar a domain LeadDomain');
        System.assert(mapClassTested.get('LeadDomain').containsMethod('criarLead'), 'Método deveria chamar o método "criarCliente" da domain LeadDomain');
        System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'O método deveria chamar o fflib_SObjectUnitOfWork');
        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('registerUpsertUsingExternalId'), 'Método deveria chamar o método "registerUpsertUsingExternalId" da fflib_SObjectUnitOfWork');
        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'Método deveria chamar o método "commitWork" da fflib_SObjectUnitOfWork');
    }
    
    @isTest
    public static void testObterLeadPorActiveCampaignId()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        LeadMapper leadMapper = new LeadService().obterLeadPorActiveCampaignId('recordId');
        
        //THEN
        System.assertEquals(null, leadMapper, 'O método deveria retorna "null".');
        System.assert(mapClassTested.containsKey('LeadDomain'), 'O método deveria chamar a domain LeadDomain.');
        System.assert(mapClassTested.get('LeadDomain').containsMethod('construirLeadMapper'), 'Método deveria chamar o método "construirLeadMapper" da domain LeadDomain.');
        System.assert(mapClassTested.containsKey('LeadSelector'), 'O método deveria chamar a LeadSelector.');
        System.assert(mapClassTested.get('LeadSelector').containsMethod('obterLeadPorActiveCampaignId'), 'Método deveria chamar o método "obterLeadPorActiveCampaignId" da LeadSelector.');
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
                when 'criarLead'
                {
                    returnValue = (LeadMapper) C3C_DIContainer_Injector.newInstance('LeadMapper');
                }
            }
            
            return returnValue;
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
    }
}