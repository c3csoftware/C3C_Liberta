@isTest
public class InstanciaRespostaServiceTest 
{
    private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();
    private static Boolean realizarCriaOuAtualizaListaExcecao = false;
    
    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'InstanciaRespostaServiceTest.fflib_SObjectUnitOfWorkStub');
        C3C_DIContainer_Injector.createInstance('IInstanciaRespostaDomain', IInstanciaRespostaDomain.class, 'InstanciaRespostaServiceTest.InstanciaRespostaDomainStub');
        C3C_DIContainer_Injector.createInstance('InstanciaRespostaSelector', Test.createStub(InstanciaRespostaSelector.class, new InstanciaRespostaSelectorStub()));
    }
    
	@isTest
    public static void testeObterInstanciaRespostasPorTipoTarefa()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        new InstanciaRespostaService().obterInstanciaRespostaPorIdTarefa('');
        //THEN
    }

    @isTest
    static void testCriarOuAtualizarListaDeInstanciaResposta()
    {
        setupInjector();
        
        new InstanciaRespostaService().criarOuAtualizarListaDeInstanciaResposta(new List<IInstanciaRespostaDomain>{
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain'),
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain'),
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain')
        });
    }
    
    @isTest
    static void testCriarOuAtualizarListaDeInstanciaRespostaTratarExcecao()
    {
        setupInjector();

        realizarCriaOuAtualizaListaExcecao = true;
        
        new InstanciaRespostaService().criarOuAtualizarListaDeInstanciaResposta(new List<IInstanciaRespostaDomain>{
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain'),
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain'),
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain')
        });
    }

    @isTest
    static void testDeleteListaDeInstanciaResposta()
    {
        setupInjector();

        new InstanciaRespostaService().deleteListaDeInstanciaResposta(new List<IInstanciaRespostaDomain>{
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain'),
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain'),
            (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain')
        });
    }

    @isTest
    static void testDeleteListaDeInstanciaRespostaError()
    {
        setupInjector();
        InstanciaRespostaMapper inst = new InstanciaRespostaMapper();
        inst.idRegistro = fflib_IDGenerator.generate(InstanciaResposta__c.sObjectType);

        InstanciaRespostaDomain variable = (InstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain', inst);

        new InstanciaRespostaService().deleteListaDeInstanciaResposta(new List<IInstanciaRespostaDomain>{
            (IInstanciaRespostaDomain) variable,
            (IInstanciaRespostaDomain) variable
        });
    }

    public class fflib_SObjectUnitOfWorkException extends Exception {}
    
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
                when 'commitWork'
                {
                    if(realizarCriaOuAtualizaListaExcecao)
                    	throw new fflib_SObjectUnitOfWorkException('FIELD_CUSTOM_VALIDATION_EXCEPTION,');
                }
            }
            
            return returnValue;
        }
    }
    
    public class InstanciaRespostaSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'InstanciaRespostaSelector';
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
                when 'obterInstanciaRespostaPorIdTarefa'
                {
                    returnValue = new List<SObject>();
                }
            }
            
            return returnValue;
        }
    }

    public class InstanciaRespostaDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'IInstanciaRespostaDomain';
        }
    
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapaDeTesteDaClasse;
        }
    }
}