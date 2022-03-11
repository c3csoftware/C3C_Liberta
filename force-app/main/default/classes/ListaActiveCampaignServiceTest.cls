@isTest 
public class ListaActiveCampaignServiceTest
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_SObjectUnitOfWork.class, 'ListaActiveCampaignServiceTest.fflib_SObjectUnitOfWorkStub');

        C3C_DIContainer_Injector.createInstance('ListaActiveCampaignDomain', ListaActiveCampaignDomain.class, 'ListaActiveCampaignServiceTest.ListaActiveCampaignDomainStub');

        C3C_DIContainer_Injector.createInstance('ListaActiveCampaignSelector', Test.createStub(IListaActiveCampaignSelector.class, new ListaActiveCampaignSelectorStub()));
    }

    //Testes

    @isTest
    public static void testInserirAtualizarListaActivePorIdListaComNomeFila()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new ListaActiveCampaignService().inserirAtualizarListaActivePorIdListaComNomeFila('Teste', 'Teste');

        // THEN
        System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'O método deveria chamar o fflib_SObjectUnitOfWork');
        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('registerUpsertUsingExternalId'), 'Método deveria chamar o método "registerUpsertUsingExternalId" da fflib_SObjectUnitOfWork');
        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'Método deveria chamar o método "commitWork" da fflib_SObjectUnitOfWork');

        System.assert(mapClassTested.containsKey('ListaActiveCampaignDomain'), 'O método deveria chamar o ListaActiveCampaignDomain');
    }

    @isTest
    public static void testObterListaActivePorIdsLista()
    {
        // Given
        setupInjector();

        // WHEN
        new ListaActiveCampaignService().obterListaActivePorIdsLista(new Set<String>{'teste', 'test'});

        // THEN

        System.assert(mapClassTested.containsKey('ListaActiveCampaignDomain'), 'O método deveria chamar o ListaActiveCampaignDomain');

        System.assert(mapClassTested.get('ListaActiveCampaignDomain').containsMethod('construirListListaActiveCampaignMapper'), 'O método deveria chamar o método "construirListListaActiveCampaignMapper" da ListaActiveCampaignDomain');

        System.assert(mapClassTested.containsKey('ListaActiveCampaignSelector'), 'O método deveria chamar a ListaActiveCampaignSelector');
    }


    // Stubs

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

    public class ListaActiveCampaignDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'ListaActiveCampaignDomain';
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
            List<Object> listOrArgs
        )
        {
            Object returnValue;

            switch on stubbedMethodName
            {
                when 'criarListaActiveCampaignPorIdLista'
                {
                    returnValue = (ListaActiveCampaignMapper) C3C_DIContainer_Injector.newInstance('ListaActiveCampaignMapper');
                }

                when 'tratarNomeListaActiveCampaign'
                {
                    returnValue = 'String';
                }

                // when 'construirListListaActiveCampaignMapper'
                // {
                //     returnValue = new List<SObject>{
                //        new SObject()
                //     };
                // }
            }

            return returnValue;
        }
    }

    public class ListaActiveCampaignSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'ListaActiveCampaignSelector';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}