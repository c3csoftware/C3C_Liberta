@isTest
public with sharing class LeadStatusSelectorTest 
{
    private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();
    
    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('C3C_Lib_Database', Test.createStub(C3C_Lib_IDatabase.class, new C3C_Lib_DatabaseStub()));
    }

    @isTest 
    static void testeBuscarLeadStatusDeStatusConvertido()
    {
        setupInjector();

        new LeadStatusSelector().buscarLeadStatusDeStatusConvertido();
        new LeadStatusSelector().getSObjectType();
        new LeadStatusSelector().getSObjectFieldSetList();

    }

    public class C3C_Lib_DatabaseStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'C3C_Lib_Database';
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
                when 'queryExecute'
                {
                    returnValue = new List<SObject>{
                        Schema.getGlobalDescribe().get(
                            new LeadStatusMapper().getObjectName()
                        ).newSObject()
                    };
                }
            }
            
            return returnValue;
        }
    }
}