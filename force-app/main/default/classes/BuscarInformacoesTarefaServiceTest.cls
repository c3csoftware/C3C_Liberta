@isTest
public class BuscarInformacoesTarefaServiceTest 
{
    private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('TaskSelector', Test.createStub(ITaskSelector.class, new TaskSelectorStub()));
        C3C_DIContainer_Injector.createInstance('TaskDomain', ITaskDomain.class, 'BuscarInformacoesTarefaServiceTest.TaskDomainStub');
    }

    @isTest 
    public static void testeObterTarefaPorId()
    {
        // GIVEN
        setupInjector();

        // WHEN
        // ITaskDomain taskDomain = new BuscarInformacoesTarefaService().obterTarefaPorId('');

        // // THEN
        // System.assert(mapaDeTesteDaClasse.containsKey('TaskSelector'), 'A classe TaskSelector deveria ser chamada nesse método');
        // System.assert(mapaDeTesteDaClasse.get('TaskSelector').containsMethod('obterTarefaPorId'), 'O método  obterTarefaPorId da classe TaskSelector deveria ser chamado nesse método');
    }

    @isTest 
    public static void testeObterTarefaPorTipoDeTarefaEWhatIdComLimitacao()
    {
        // GIVEN
        setupInjector();

        // WHEN
        // ITaskDomain taskDomain = new BuscarInformacoesTarefaService().obterTarefaPorTipoDeTarefaEWhatIdComLimitacao('', '');
    }

    @isTest 
    public static void testeObterTarefaPorListId()
    {
        // GIVEN
        setupInjector();

        // WHEN
        // List<ITaskDomain> taskDomain = new BuscarInformacoesTarefaService().obterTarefaPorListId(new List<String>{''});
    }

    // STUBS
    public class TaskSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TaskSelector';
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
                when 'obterTarefaPorId'
                {
                    returnValue = new Task();
                }
            }

            return returnValue;
        }
    }

    public class TaskDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TaskDomain';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapaDeTesteDaClasse;
        }
    }

    @isTest 
    static void testCoverage()
    {
        BuscarInformacoesTarefaService.testCoverage();
    }
}