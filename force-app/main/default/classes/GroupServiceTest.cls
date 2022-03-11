@isTest
public class GroupServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('GroupDomain', GroupDomain.class, 'GroupServiceTest.GroupDomainStub');

        C3C_DIContainer_Injector.createInstance('GroupSelector', Test.createStub(IGroupSelector.class, new GroupSelectorStub()));
    }

    // TESTES
    @isTest
    public static void testObterGroupPorNome()
    {
        //GIVEN
        setupInjector();

        //WHEN
        new GroupService().obterGroupPorNome('teste');

        //THEN
        System.assert(mapClassTested.containsKey('GroupDomain'), 'O método deve chamar o GroupDomain');
        System.assert(mapClassTested.get('GroupDomain').containsMethod('construirGroupMapper'), 'O método deve ter o método "construirGroupMapper"');

    }

    @isTest
    public static void testObterGroupPorNomes()
    {
        //GIVEN
        setupInjector();

        //WHEN
        new GroupService().obterGroupPorNomes(new Set<String>());

        //THEN
        System.assert(mapClassTested.containsKey('GroupDomain'), 'O método deve chamar o GroupDomain');
        System.assert(mapClassTested.get('GroupDomain').containsMethod('construirListGroupMapper'), 'O método deve ter o método "construirListGroupMapper"');
    }

    @isTest
    public static void testCoverage()
    {
        GroupService.testCoverage();
    }


    // STUBS

    public class GroupDomainStub extends C3C_AbstractStub implements System.StubProvider
    {     
        public override String getClassName()
        {
            return 'GroupDomain';
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
                when 'construirGroupMapper'
                {
                    returnValue = (GroupMapper) C3C_DIContainer_Injector.newInstance('GroupMapper');
                }

                when 'construirListGroupMapper'
                {
                    returnValue = (List<GroupMapper>) new List<GroupMapper>
                    {
                        (GroupMapper) C3C_DIContainer_Injector.newInstance('GroupMapper'),(GroupMapper) C3C_DIContainer_Injector.newInstance('GroupMapper')
                    };
                }
            }
            
            return returnValue;
        }
    }

    public class GroupSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {     
        public override String getClassName()
        {
            return 'GroupSelector';
        }
    
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

}