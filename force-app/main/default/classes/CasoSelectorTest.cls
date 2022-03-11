@isTest
public with sharing class CasoSelectorTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();
    
    static void setupInjector()
    {
		C3C_DIContainer_Injector.createInstance('C3C_Lib_Database', Test.createStub(C3C_Lib_IDatabase.class, new C3C_Lib_DatabaseStub()));
    }

    // TESTES

    @isTest
    static void buscarCasosDeOrigemAssessor()
    {
        // GIVEN
        setupInjector();

        // WHEN 
        new CasoSelector().buscarCasosDeOrigemAssessor('Assessor');

        // THEN 
        
    }

    @isTest
    static void obterCasoComStatusResolvidoPorIdsDoCaso()
    {
        // GIVEN
        setupInjector();

        // WHEN 
        new CasoSelector().obterCasoComStatusResolvidoPorIdsDoCaso(new List<String>{
            'teste'
        });

        // THEN 

    }


    // STUBS
    public class C3C_Lib_DatabaseStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'C3C_Lib_Database';
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
                when 'queryExecute'
                {
                    returnValue = new List<SObject>{Schema.getGlobalDescribe().get('Case').newSObject()}; 
                }
            }
            
            return returnValue;
        }
    }
}