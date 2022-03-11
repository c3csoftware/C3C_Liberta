@isTest
public with sharing class EventServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('EventSelector', Test.createStub(IEventSelector.class, new EventSelectorStub()));
        
        C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_SObjectUnitOfWork.class, 'EventServiceTest.fflib_SObjectUnitOfWorkStub');

        C3C_DIContainer_Injector.createInstance('EventDomain', IEventDomain.class, 'EventServiceTest.EventDomainStub');
    }

    // TESTES

    @isTest
    static void testeBuscarEventosDeUsuariosDaFilaComDataDeInicioETermino()
    {
        setupInjector();

        // new EventService().buscarEventosDeUsuariosDaFilaComDataDeInicioETermino('', DateTime.now(), Datetime.now() + 1);

        // System.assert(mapClassTested.containsKey('EventSelector'), 'O método deve chamar o EventSelector');
        // System.assert(mapClassTested.get('EventSelector').containsMethod('buscarEventosDeUsuariosDaFilaComDataDeInicioETermino'), 'O método deve ter o método "buscarEventosDeUsuariosDaFilaComDataDeInicioETermino"');
    }


    @isTest
    static void testeCriarEvento()
    {
        setupInjector();

        // new EventService().criarEvento(new List<IEventDomain>{
        //     (IEventDomain) C3C_DIContainer_Injector.newInstance('EventDomain', Schema.getGlobalDescribe().get('Event').newSObject()),
        //     (IEventDomain) C3C_DIContainer_Injector.newInstance('EventDomain',Schema.getGlobalDescribe().get('Event').newSObject())
        // });

        // System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'O método deve chamar a classe fflib_SObjectUnitOfWork');
        // System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'O método deve chamar o método "comitWork" da classe "fflib_SObjectUnitOfWork"');
    }

    @isTest
    static void testeCriarEventoError()
    {
        setupInjector();
        // EventMapper inst = new EventMapper();
        // inst.idRegistro = fflib_IDGenerator.generate(Event.sObjectType);

        // IEventDomain eventDomain = (IEventDomain) C3C_DIContainer_Injector.newInstance('EventDomain', inst); 

        // new EventService().criarEvento(new List<IEventDomain>{
        //     eventDomain,
        //     eventDomain
        // });

    }

    // @isTest 
    // static void testeBuscarEventosDeUsuariosDaFilaDoMesAtual()
    // {
    //     setupInjector();

    //     new EventService().buscarEventosDeUsuariosDaFilaDoMesAtual('');



    // }

    

    // STUBS
    public class fflib_SObjectUnitOfWorkStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'fflib_SObjectUnitOfWork';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class EventDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'EventDomain';
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
                    when 'obterMapper'
                    {
                        returnValue = (EventMapper) C3C_DIContainer_Injector.newInstance('EventMapper');
                    }

                }

                return returnValue;
            }
    }

    public class EventSelectorStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'EventSelector';
        }

        public override Map<String, ClassTested> getMapClassTested(){
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
                when 'buscarEventosDeUsuariosDaFilaComDataDeInicioETermino'
                {
                    returnValue = (List<SObject>) new List<SObject>
                    {
                        Schema.getGlobalDescribe().get(
                            'Event'
                        ).newSObject(),
                        Schema.getGlobalDescribe().get(
                            'Event'
                        ).newSObject()
                    };
                }
                when 'buscarEventosDeUsuariosDaFilaDoMesAtual'
                {
                    returnValue = (List<SObject>) new List<SObject>
                    {
                        Schema.getGlobalDescribe().get(
                            'Event'
                        ).newSObject(),
                        Schema.getGlobalDescribe().get(
                            'Event'
                        ).newSObject()
                    };
                }

            }
            
            return returnValue;
        }
    }

    @isTest 
    static void testCoverage()
    {
        EventService.testCoverage();
    }

}