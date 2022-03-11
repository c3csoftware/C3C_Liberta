@isTest 
public with sharing class CalendarioDeEventosServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
	 	// C3C_DIContainer_Injector.createInstance('EventService', Test.createStub(IEventService.class, new EventServiceStub()));
        C3C_DIContainer_Injector.createInstance('MembroFilaService', Test.createStub(IMembroFilaService.class, new MembroFilaServiceStub()));
    }

    @isTest 
    static void testeObterAgendaDeUsuariosDaFilaDurantePeriodo()
    {
        setupInjector();
		


        // new CalendarioDeEventosService().obterAgendaDeUsuariosDaFilaDurantePeriodo('idFila', Datetime.now(), Datetime.now() + 1);
    }  

    // STUBS

    public class EventServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'EventService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        // public IEventDomain criarEventoParaUsuarioComMenosEventoNoMes(Id idRegistro, String idFila, Date dataDeInicio, Time horario, Time duracao, String assunto, String descricao)
        // {
        //     return null;
        // }

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
                when 'buscarEventosDeUsuariosDaFilaComDataDeInicioETermino'
                {
                    returnValue = (IEventDomain) C3C_DIContainer_Injector.newInstance('EventDomain');
                }
            }
            
            return returnValue;
        }
    }

    public class MembroFilaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'MembroFilaService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    @isTest 
    static void testCoverage()
    {
        CalendarioDeEventosService.testCoverage();
    }
}