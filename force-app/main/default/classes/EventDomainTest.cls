@isTest
public with sharing class EventDomainTest 
{
    @isTest 
    static void testeNewInstanceEnviandoSObject()
    {
        // WHEN
        IEventDomain eventDomain = (IEventDomain) new EventDomain().newInstance(
            Schema.getGlobalDescribe().get(
                'Event'
            ).newSObject()
        );

        // THEN
        System.assert(eventDomain.obterMapper() != null, 'A mapper deveria estar diferente de null');
        System.assert(eventDomain.obterRegistro() != null, 'O registro deveria estar diferente de null');
    }

    @isTest 
    static void testeNewInstanceEnviandoListSObject()
    {
        List<IEventDomain> eventDomain = (List<IEventDomain>) new EventDomain().newInstance(
            new List<SObject>{
                Schema.getGlobalDescribe().get('Event').newSObject(),
                Schema.getGlobalDescribe().get('Event').newSObject()
            }
        );

        // THEN
        System.assert(eventDomain.size() > 0, 'A lista de domínios deveria vir pelo menos um');
    }

    @isTest
    static void testeNewInstanceEnviandoMapper()
    {
        IEventDomain eventDomain = (IEventDomain) new EventDomain().newInstance((EventMapper) C3C_DIContainer_Injector.newInstance('EventMapper'));

    }

    @isTest
    static void testeNewInstanceEnviandoMapAnalisado()
    {
        new EventDomain().newInstance(new Map<String, Object> {
            'analisadoBatch' => true,
            'idRegistro' => fflib_IDGenerator.generate(Event.sObjectType)
        });

    }

    @isTest
    static void testeNewInstanceEnviandoMap()
    {
        new EventDomain().newInstance(new Map<String, Object> {
            'idRegistro' => fflib_IDGenerator.generate(Event.sObjectType),
            'dataDeInicio' => DateTime.now(),
            'dataDeTermino' => DateTime.now() + 1,
            'duracao' => Datetime.now().time(),
            'assunto' => 'Assunto',
            'descricao' => 'Descricao',
            'proprietario' => 'String',
            'eventoAceito' => false
        });

    }

    @isTest 
    static void testeNewInstanceEnviandoNull()
    {
        // WHEN
        IEventDomain eventDomain = (IEventDomain) new EventDomain().newInstance(null);

        //THEN
        System.assert(eventDomain == null, 'Não deve retornar um domínio ao se passar null');
    }
}