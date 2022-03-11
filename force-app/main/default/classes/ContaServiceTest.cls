@IsTest
public class ContaServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('ContaDomain', ContaDomain.class, 'ContaServiceTest.ContaDomainStub');
        C3C_DIContainer_Injector.createInstance('ContaSelector', Test.createStub(ContaSelector.class, new ContaSelectorStub()));
    }

    // Tests

    @isTest
    public static void testObterContaPorId()
    {
        // GIVEN
        setupInjector();
        // WHO
        new ContaService().obterContaPorId('teste');
        // THEN
        System.assert(mapClassTested.containsKey('ContaDomain'));
        System.assert(mapClassTested.get('ContaDomain').containsMethod('construirContaMapper'));

    }

    @isTest
    static void testCoverage()
    {
        ContaService.testCoverage();
    } 
    
    
    // Stubs

    public class ContaDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'ContaDomain';
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
                when 'construirContaMapper'
                {
                    returnValue = (ContaMapper) C3C_DIContainer_Injector.newInstance('ContaMapper');
                }
            }
            
            return returnValue;
        }
    }

    public class ContaSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'ContaSelector';
        }
    
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}