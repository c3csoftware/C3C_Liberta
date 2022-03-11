@istest
public with sharing class EventTriggerAfterInsertServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    @isTest
    static void testCoverage()
    {
        EventTriggerAfterInsertService.testCoverage();
    } 

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('AlterarStatusLeadService', Test.createStub(AlterarStatusLeadService.class, new AlterarStatusLeadServiceStub()));
    }

    @isTest
    static void testeMudarStatusLeadParaEmAndamento()
    {
        // GIVEN
        setupInjector();
        
        IEventDomain eventDomain = (IEventDomain) C3C_DIContainer_Injector.newInstance('EventDomain', Schema.getGlobalDescribe().get('Event').newSObject());

        eventDomain.obterMapper().eventoGeradoPorRoletagem = true;


        // WHEN
        new EventTriggerAfterInsertService().mudarStatusLeadParaEmAndamento(new List<IEventDomain>{
            eventDomain
        });

        // THEN
    }

    public class AlterarStatusLeadServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'AlterarStatusLeadService';
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
                    when 'mudarStatusLead'
                    {
                        returnValue = null;
                    }

                }

                return returnValue;
            }
    }
}