@isTest 
public with sharing class AccountSelectorTest 
{
    private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();
    
    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('C3C_Lib_Database', Test.createStub(C3C_Lib_IDatabase.class, new C3C_Lib_DatabaseStub()));
    }

    @isTest 
    static void testeBuscarContaPorId()
    {
        setupInjector();

        new AccountSelector().buscarContaPorId('contaId');
    }
    
    @isTest
    static void testeBuscarContasPorIds()
    {
        setupInjector();

        new AccountSelector().buscarContasPorIds(new Set<String>{'Teste'});
    }

    @isTest
    static void buscarContasPorDadosLeadTeste()
    {
        setupInjector();

        new AccountSelector().buscarContasPorDadosLead(new List<LeadMapper>{});
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
                            new AccountMapper().getObjectName()
                        ).newSObject()
                    };
                }
            }
            
            return returnValue;
        }
    }
}