@isTest
public class RespostaServiceTest 
{
    private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();
    
    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('RespostaSelector', Test.createStub(IRespostaSelector.class, new RespostaSelectorStub()));
    }
    
	@isTest
    public static void testeObterRespostasPorTipoTarefa()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        List<IRespostaDomain> listaDeRespostas = new RespostaService().obterRespostasPorListaIdPergunta(new Set<String>());
        
        //THEN
        System.assert(mapaDeTesteDaClasse.containsKey('RespostaSelector'), 'A classe RespostaSelector deveria ser chamada nesse método.');
        System.assert(mapaDeTesteDaClasse.get('RespostaSelector').containsMethod('obterRespostasPorListaIdPergunta'), 'O método obterRespostasPorListaIdPergunta da classe RespostaSelector deveria ser chamado nesse método.');
        System.assertEquals(0, listaDeRespostas.size(), 'Método não deveria retornar nenhuma pergunta.');
    }
    
    public class RespostaSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'RespostaSelector';
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
                when 'obterRespostasPorListaIdPergunta'
                {
                    returnValue = new List<SObject>{};
                }
            }
            
            return returnValue;
        }
    }
}