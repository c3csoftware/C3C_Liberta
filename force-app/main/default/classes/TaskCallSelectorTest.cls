@isTest
public with sharing class TaskCallSelectorTest 
{
    private static Map<String, ClassTested> mapaDeTesteDaClasse = new Map<String, ClassTested>();
    
    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('C3C_Lib_Database', Test.createStub(C3C_Lib_IDatabase.class, new C3C_Lib_DatabaseStub()));
    }
    
	@isTest
    public static void testeGetSObjectType()
    {
        //WHEN
        Schema.SObjectType tipoDoObjeto = new TaskCallSelector().getSObjectType();
        
        //THEN
        System.assertEquals(Task.sObjectType, tipoDoObjeto, 'Tipo do objeto deveria ser Task');
    }
    
    @isTest
    public static void testeGetSObjectFieldList()
    {
        //WHEN
        List<Schema.SObjectField> listaDeCampos = new TaskCallSelector().getSObjectFieldList();
        
        //THEN
        System.assert(listaDeCampos.size() > 0, 'Tamanho da lista de campos deveria ser maior que 0');
    }
    
    @isTest
    public static void testeBuscarTarefasChamadasComIdProprietario()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        List<SObject> listaDeRegistros = new TaskCallSelector().buscarTarefasChamadasComIdProprietario('Teste');
        
        //THEN
        System.assert(mapaDeTesteDaClasse.containsKey('C3C_Lib_Database'), 'A lib C3C_Lib_Database deveria ter sido chamada.');
        System.assert(mapaDeTesteDaClasse.get('C3C_Lib_Database').containsMethod('queryExecute'), 'O método queryExecute da C3C_Lib_Database deveria ter sido chamado.');
        System.assert(listaDeRegistros.size() > 0, 'Tamanho da lista de registro deveria ser maior que 0');
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
                            new TaskCallMapper().getObjectName()
                        ).newSObject()
                    };
                }
            }
            
            return returnValue;
        }
    }
}