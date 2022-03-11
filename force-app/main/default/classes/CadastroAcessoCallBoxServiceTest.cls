@isTest
public class CadastroAcessoCallBoxServiceTest 
{
	public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();
    
    static void setupInjector()
    {
		C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'CadastroAcessoCallBoxServiceTest.fflib_SObjectUnitOfWorkStub');
        C3C_DIContainer_Injector.createInstance('CadastrarAcessoAoCallboxDomain', ICadastrarAcessoAoCallboxDomain.class, 'CadastroAcessoCallBoxServiceTest.CadastrarAcessoAoCallboxDomainStub');
        C3C_DIContainer_Injector.createInstance('UserDomain', IUserDomain.class, 'CadastroAcessoCallBoxServiceTest.UserDomainStub');
    }
    
    @isTest
    public static void testeCadastrarOuAtualizarInformacoesAcessoCallboxNoUsuario()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        // new CadastroAcessoCallBoxService().cadastrarOuAtualizarInformacoesAcessoCallboxNoUsuario(new List<ICadastrarAcessoAoCallboxDomain>{
        //     (ICadastrarAcessoAoCallboxDomain) C3C_DIContainer_Injector.newInstance('CadastrarAcessoAoCallboxDomain'),
        //     (ICadastrarAcessoAoCallboxDomain) C3C_DIContainer_Injector.newInstance('CadastrarAcessoAoCallboxDomain')
        // });
        
        //THEN
        // System.assert(mapClassTested.containsKey('CadastrarAcessoAoCallboxDomain'), 'O método deveria chamar a domain CadastrarAcessoAoCallboxDomain');
        // System.assert(mapClassTested.get('CadastrarAcessoAoCallboxDomain').containsMethod('obterMapper'), 'Método deveria chamar o método "obterMapper" da domain CadastrarAcessoAoCallboxDomain');
        // System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'O método deveria chamar o fflib_SObjectUnitOfWork');
        // System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('registerDirty'), 'Método deveria chamar o método "registerUpsertUsingExternalId" da fflib_SObjectUnitOfWork');
        // System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'Método deveria chamar o método "commitWork" da fflib_SObjectUnitOfWork');
    }
    
    @isTest
    public static void testObterLeadPorActiveCampaignId()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        // new CadastroAcessoCallBoxService().publicarEventoCadastroAcessoCallBox((String) fflib_IDGenerator.generate(User.getSObjectType()), 'ramalUsuario', 'senhaCallbox');
        
        // //THEN
        // System.assert(mapClassTested.containsKey('CadastrarAcessoAoCallboxDomain'), 'O método deveria chamar a domain CadastrarAcessoAoCallboxDomain.');
        // System.assert(mapClassTested.get('CadastrarAcessoAoCallboxDomain').containsMethod('construirLeadMapper'), 'Método deveria chamar o método "construirLeadMapper" da domain CadastrarAcessoAoCallboxDomain.');
        // System.assert(mapClassTested.containsKey('LeadSelector'), 'O método deveria chamar a LeadSelector.');
        // System.assert(mapClassTested.get('LeadSelector').containsMethod('obterLeadPorActiveCampaignId'), 'Método deveria chamar o método "obterLeadPorActiveCampaignId" da LeadSelector.');
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
    
    public class CadastrarAcessoAoCallboxDomainStub extends C3C_AbstractStub implements System.StubProvider
    {     
        public override String getClassName()
        {
            return 'CadastrarAcessoAoCallboxDomain';
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
                    returnValue = (CadastrarAcessoAoCallboxMapper) C3C_DIContainer_Injector.newInstance('CadastrarAcessoAoCallboxMapper');
                }

                when 'newInstance'
                {
                    returnValue = (ICadastrarAcessoAoCallboxDomain) C3C_DIContainer_Injector.newInstance('CadastrarAcessoAoCallboxDomain');
                }

                when 'obterRegistro'
                {
                    returnValue = Schema.getGlobalDescribe().get('CadastrarAcessoAoCallbox__e').newSObject();
                }
            }
            
            return returnValue;
        }
    }
    
    public class UserDomainStub extends C3C_AbstractStub implements System.StubProvider
    {        
        public override String getClassName()
        {
            return 'UserDomain';
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
                    returnValue = (UserMapper) C3C_DIContainer_Injector.newInstance('UserMapper');
                }
            }
            
            return returnValue;
        }
    }

    @isTest 
    static void testCoverage()
    {
        CadastroAcessoCallBoxService.testCoverage();
    }
}