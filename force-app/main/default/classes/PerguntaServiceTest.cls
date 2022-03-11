@isTest
public class PerguntaServiceTest 
{
    private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();
    
    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('PerguntaSelector', Test.createStub(IPerguntaSelector.class, new PerguntaSelectorStub()));
    }
    
	@isTest
    public static void testeObterPerguntasPorTipoTarefa()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        List<IPerguntaDomain> listaDePerguntas = new PerguntaService().obterPerguntasPorTipoTarefa('');
        
        //THEN
        System.assert(mapaDeTesteDaClasse.containsKey('PerguntaSelector'), 'A classe PerguntaSelector deveria ser chamada nesse método.');
        System.assert(mapaDeTesteDaClasse.get('PerguntaSelector').containsMethod('obterPerguntasPorTipoTarefa'), 'O método obterPerguntasPorTipoTarefa da classe PerguntaSelector deveria ser chamado nesse método.');
        System.assertEquals(0, listaDePerguntas.size(), 'Método não deveria retornar nenhuma pergunta.');
    }
    
    public class PerguntaSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'PerguntaSelector';
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
                when 'obterPerguntasPorTipoTarefa'
                {
                    returnValue = new List<SObject>{};
                }
            }
            
            return returnValue;
        }
    }
}