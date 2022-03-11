@isTest
public with sharing class EventSelectorTest 
{
    public static Map<String, ClassTested> mapaClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('C3C_Lib_Database', Test.createStub(C3C_Lib_IDatabase.class, new C3C_Lib_DatabaseStub()));
    }

    @isTest 
    static void testeBuscarEventosDeUsuariosDaFilaComDataDeInicioETermino()
    {
        // GIVEN
        setupInjector();

        // WHEN
         List<SObject> listSobject = new EventSelector().buscarEventosDeUsuariosDaFilaComDataDeInicioETermino('idFila', Date.today(), Date.today()+1);

        // THEN
        System.assert(listSobject.size() > 0, 'Método deve retornar pelo menos um registro');
    }
    
    @isTest 
    static void testeBuscarEventosDeUsuariosDaFilaSemUsuariosInformadosComDataDeInicioETermino()
    {
        // GIVEN
        setupInjector();

        // WHEN
         List<SObject> listSobject = new EventSelector().buscarEventosDeUsuariosDaFilaSemUsuariosInformadosComDataDeInicioETermino('idFila', new Set<String>(), Date.today(), Date.today()+1);

        // THEN
        System.assert(listSobject.size() > 0, 'Método deve retornar pelo menos um registro');
    }

    @isTest 
    static void testeBuscarEventosDeUsuariosDaFilaDoMesAtual()
    {
        // GIVEN
        setupInjector();

        // WHEN
        List<SObject> listSobject = new EventSelector().buscarEventosDeUsuariosDaFilaDoMesAtual('idFila');

        // THEN
        System.assert(listSobject.size() > 0, 'Método deve retornar pelo menos um registro');
    }

    @isTest 
    static void testeBuscarEventosDoMesComIdRelativoIdProprietario()
    {
        // GIVEN
        setupInjector();

        // WHEN
        List<SObject> listSobject = new EventSelector().buscarEventosDoMesComIdRelativoIdProprietario('idRelativo', 'idProprietario');

        // THEN
        System.assert(listSobject.size() > 0, 'Método deve retornar pelo menos um registro');
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
                    returnValue = new List<SObject>{Schema.getGlobalDescribe().get('Event').newSObject()}; 
                }
            }
            
            return returnValue;
        }
    }
}