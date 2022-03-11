@isTest
public class TipoTarefaServiceTest 
{
    private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();
    
    @isTest
    static void testCoverage()
    {
        TipoTarefaService.testCoverage();
    } 
    
    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('TipoTarefaSelector', Test.createStub(ITipoTarefaSelector.class, new TipoTarefaSelectorStub()));
    }
    
	@isTest
    public static void testeObterTipoTarefasPorTipoIgualQualificacaoLead()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        ITipoTarefaDomain listaDeTipoTarefas = new TipoTarefaService().obterTipoTarefasPorTipoIgualQualificacaoLead();
        
        //THEN
        System.assert(mapaDeTesteDaClasse.containsKey('TipoTarefaSelector'), 'A classe TipoTarefaSelector deveria ser chamada nesse método.');
        System.assert(mapaDeTesteDaClasse.get('TipoTarefaSelector').containsMethod('obterTipoTarefasPorTipoIgualQualificacaoLead'), 'O método obterTipoTarefasPorTipoIgualQualificacaoLead da classe TipoTarefaSelector deveria ser chamado nesse método.');
    }
    
    public class TipoTarefaSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TipoTarefaSelector';
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
                when 'obterTipoTarefasPorTipoIgualQualificacaoLead'
                {
                    returnValue = new TipoTarefa__c();
                }
            }
            
            return returnValue;
        }
    }
}