@isTest
public class OportunidadeServiceTest
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_SObjectUnitOfWork.class, 'OportunidadeServiceTest.fflib_SObjectUnitOfWorkStub');

        C3C_DIContainer_Injector.createInstance('OportunidadeDomain', OportunidadeDomain.class, 'OportunidadeServiceTest.OportunidadeDomainStub');
    }

    @isTest
    public static void testCoverage()
    {
        OportunidadeService.testCoverage();
    }

    @isTest
    public static void testInserirAtualizarOportunidadePorActiveCampaignId()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        new OportunidadeService().inserirAtualizarOportunidadePorActiveCampaignId('teste', 'teste', 'teste', 'teste', 'teste', 'teste', 10, Date.today());
        
        //THEN

        System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'O método deveria chamar o fflib_SObjectUnitOfWork');

        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('registerUpsertUsingExternalId'), 'O método deveria chamar o método "registerUpsertUsingExternalId" da fflib_SObjectUnitOfWork');

        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'O método deveria chamar o método "commitWork" da fflib_SObjectUnitOfWork');

        System.assert(mapClassTested.containsKey('OportunidadeDomain'), 'Método deveria chamar o OportunidadeDomain');

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

    public class OportunidadeDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'OportunidadeDomain';
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
                when 'criarOportunidade'
                {
                    returnValue = (OportunidadeMapper) C3C_DIContainer_Injector.newInstance('OportunidadeMapper');
                }
            }

            return returnValue;
        }
    }
}