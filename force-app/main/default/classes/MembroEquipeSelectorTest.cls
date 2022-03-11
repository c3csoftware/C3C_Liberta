@isTest
public class MembroEquipeSelectorTest 
{
    public static Map<String, ClassTested> mapaClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('C3C_Lib_Database', Test.createStub(C3C_Lib_IDatabase.class, new C3C_Lib_DatabaseStub()));
    }

	@isTest
    static void obterMembroEquipePorEquipesTeste()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new MembroEquipeSelector().obterMembroEquipePorEquipes(new List<String>());

        // THEN
    } 

	@isTest
    static void obterMembroEquipePorListaIdEquipeTeste()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new MembroEquipeSelector().obterMembroEquipePorListaIdEquipe(new List<String>());

        // THEN
    } 

	@isTest
    static void obterMembroEquipePorUsuarioIdTeste()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new MembroEquipeSelector().obterMembroEquipePorUsuarioId('');

        // THEN
    } 

    public class C3C_Lib_DatabaseStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'C3C_Lib_Database';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapaClassTested;
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
                    returnValue = new List<SObject>{Schema.getGlobalDescribe().get('MembroEquipe__c').newSObject()}; 
                }
            }
            
            return returnValue;
        }
    }
}