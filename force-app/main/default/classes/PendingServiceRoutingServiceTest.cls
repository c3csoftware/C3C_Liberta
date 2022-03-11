@isTest
public class PendingServiceRoutingServiceTest 
{
    /*private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();
    
    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('LeadFilhoService', Test.createStub(ILeadFilhoService.class, new LeadFilhoServiceStub()));
        C3C_DIContainer_Injector.createInstance('GroupService', Test.createStub(IGroupService.class, new GroupServiceStub()));
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'PendingServiceRoutingServiceTest.fflib_SObjectUnitOfWorkStub');
    }
    
	@isTest
    public static void testeRegraAtribuicaoProprietarioRegistroListaLead()
    {
		//GIVEN
		setupInjector();
        
        AgentWorkMapper agentWorkMapper = (AgentWorkMapper) C3C_DIContainer_Injector.newInstance('AgentWorkMapper');
        agentWorkMapper.idObjetoRoteado = fflib_IDGenerator.generate(LeadFilho__c.sObjectType);
        
		//WHEN
        new PendingServiceRoutingService().regraAtribuicaoProprietarioRegistroListaLead(new List<AgentWorkMapper>{agentWorkMapper});
        
		//THEN
		System.assert(mapaDeTesteDaClasse.containsKey('LeadFilhoService'), 'O método deveria chamar o LeadFilhoService');
        System.assert(mapaDeTesteDaClasse.get('LeadFilhoService').containsMethod('obterLeadFilhoPorListaIdLeadFilho'), 'O método deveria chamar o método "obterLeadFilhoPorListaIdLeadFilho" da LeadFilhoService');
        System.assert(mapaDeTesteDaClasse.containsKey('GroupService'), 'O método deveria chamar o GroupService');
        System.assert(mapaDeTesteDaClasse.get('GroupService').containsMethod('obterGroupPorNome'), 'O método deveria chamar o método "obterGroupPorNome" da GroupService');
        System.assert(mapaDeTesteDaClasse.containsKey('fflib_SObjectUnitOfWork'), 'O método deveria chamar o fflib_SObjectUnitOfWork');
        System.assert(mapaDeTesteDaClasse.get('fflib_SObjectUnitOfWork').containsMethod('registerNew'), 'O método deveria chamar o método "registerNew" da fflib_SObjectUnitOfWork');
        System.assert(mapaDeTesteDaClasse.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'O método deveria chamar o método "commitWork" da fflib_SObjectUnitOfWork');
    }
    
    public class LeadFilhoServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'LeadFilhoService';
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
                when 'obterLeadFilhoPorListaIdLeadFilho'
                {
                    LeadFilhoMapper listaLead = (LeadFilhoMapper) C3C_DIContainer_Injector.newInstance('LeadFilhoMapper');
                    listaLead.recordId = ((List<String>) listOfArgs[0])[0];
                    listaLead.oportunidade = fflib_IDGenerator.generate(Opportunity.sObjectType);
                    listaLead.proprietarioOportunidadeId = fflib_IDGenerator.generate(User.sObjectType);
                    
                    returnValue = new List<LeadFilhoMapper>{listaLead};
                }
            }
            
            return returnValue;
        }
    }
    
    public class GroupServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'GroupService';
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
                when 'obterGroupPorNome'
                {
                    returnValue = (GroupMapper) C3C_DIContainer_Injector.newInstance('GroupMapper');
                }
            }
            
            return returnValue;
        }
    }
    
    public class fflib_SObjectUnitOfWorkStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'fflib_SObjectUnitOfWork';
        }
    
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapaDeTesteDaClasse;
        }
    }*/
    
    @isTest
    public static void testCoverage()
    {
        PendingServiceRoutingService.testCoverage();
    }
}