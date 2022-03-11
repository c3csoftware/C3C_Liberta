@isTest
public class BuscarInformacoesContaServiceTest {
    private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('ContaSelector', Test.createStub(IContaSelector.class, new ContaSelectorStub()));
    }

    @isTest
    public static void testeObterContasPorCodigosXP()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        List<IContaDomain>  listaContasDomains = new BuscarInformacoesContaService().obterContasPorCodigosXP(new List<String>());
        
        //THEN
        System.assert(mapaDeTesteDaClasse.containsKey('ContaSelector'), 'A classe ContaSelector deveria ser chamada nesse método');
        System.assert(mapaDeTesteDaClasse.get('ContaSelector').containsMethod('obterContasPorCodigosXP'), 'O método obterContasPorCodigosXP da classe ContaSelector deveria ser chamado nesse método.');
        System.assertEquals(0, listaContasDomains.size(), 'Método não deveria retornar nenhuma pergunta.');

    }

    public class ContaSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'ContaSelector';
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
}