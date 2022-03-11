@isTest
public with sharing class AlterarStatusCasoServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInject()
    {
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'AlterarStatusCasoServiceTest.fflib_SObjectUnitOfWorkStub');

        C3C_DIContainer_Injector.createInstance('CasoSelector', Test.createStub(ICasoSelector.class, new CasoSelectorStub()));
    }

    @isTest
    static void mudarStatusCasoResolvidoParaEncerradoTest()
    {
        // GIVEN
        setupInject();

        // WHEN
        new AlterarStatusCasoService().mudarStatusCasoResolvidoParaEncerrado(new Map<String, Object>{
            'ids' => 'Status'
        });

        // THEN

    }

    public class fflib_SObjectUnitOfWorkStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override String getClassName()
        {
            return 'fflib_SObjectUnitOfWork';
        }
    }

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
                when 'obterCasoComStatusResolvidoPorIdsDoCaso'
                {
                    returnValue = new List<SObject>{
                        Schema.getGlobalDescribe().get('Case').newSObject()
                    };
                }
            }
            
            return returnValue;
        }
    }
}