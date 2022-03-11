@isTest
public with sharing class CasoServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('CasoSelector', Test.createStub(ICasoSelector.class, new CasoSelectorStub()));

        C3C_DIContainer_Injector.createInstance('CasoDomain', CasoDomain.class, 'CasoServiceTest.CasoDomainStub');
    }

    // TESTES

    @isTest 
    static void buscarCasosDeOrigemAssessorTeste()
    {
        // GIVEN
        setupInjector();

        // WHEN
        List<CasoDomain> listaCaso = new CasoService().buscarCasosDeOrigemAssessor('Assessor');

        // THEN
        System.assert(listaCaso.size() > 0, 'A lista não pode vir vazia.');
    }


    // STUBS

    public class CasoSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'CasoSelector';
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
                when 'buscarCasosDeOrigemAssessor'
                {
                    returnValue = new List<SObject>{
                        Schema.getGlobalDescribe().get('Case').newSObject()
                    };
                }
            }
            
            return returnValue;
        }
    }

    public class CasoDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'CasoDomain';
        }

    }
}