@isTest
public with sharing class EventMapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        // WHEN
        string nomeDaAPIObjeto = new EventMapper().getObjectName();

        // THEN
        System.assertEquals('Event', nomeDaAPIObjeto, 'O nome do objeto deveria ser "Event"');
    }

    @isTest
    public static void testeNewInstance()
    {
        //WHEN
        EventMapper eventMpp = (EventMapper) new EventMapper().newInstance(
            Schema.getGlobalDescribe().get(
                new EventMapper().getObjectName()
            ).newSObject());

        // THEN
        System.assert(eventMpp != null, 'Deveria retornar uma instância de EventMapper');
    }

    @isTest
    public static void testeNewInstancePassandoMap()
    {
        //WHEN
        new EventMapper().newInstance(new Map<String, Object> {
            'idRegistro' => fflib_IDGenerator.generate(Event.sObjectType),
            'dataDeInicio' => DateTime.now(),
            'dataDeTermino' => DateTime.now() + 1,
            'duracao' => Datetime.now().time(),
            'assunto' => 'Assunto',
            'proprietario' => 'proprietario',
            'duracaoEmMinutos' => 30,
            'eventoGeradoPorRoletagem' => true,
            'descricao' => 'Descricao',
            'proprietario' => 'String',
            'eventoAceito' => false,
            'lead' => 'lead'
        });

    }

    @isTest
    public static void testeNewInstancePassandoMapOportunidade()
    {
        //WHEN
        new EventMapper().newInstance(new Map<String, Object> {
            'idRegistro' => fflib_IDGenerator.generate(Event.sObjectType),
            'dataDeInicio' => DateTime.now(),
            'dataDeTermino' => DateTime.now() + 1,
            'duracao' => Datetime.now().time(),
            'assunto' => 'Assunto',
            'proprietario' => 'proprietario',
            'duracaoEmMinutos' => 30,
            'eventoGeradoPorRoletagem' => true,
            'descricao' => 'Descricao',
            'proprietario' => 'String',
            'eventoAceito' => false,
            'oportunidade' => 'oportunidade'
        });

    }

    @isTest
    public static void testeNewInstancePassandoMapAnalisadoBatch()
    {
        //WHEN
        new EventMapper().newInstance(new Map<String, Object> {
            'idRegistro' => fflib_IDGenerator.generate(Event.sObjectType),
            'dataDeInicio' => DateTime.now(),
            'dataDeTermino' => DateTime.now() + 1,
            'duracao' => Datetime.now().time(),
            'assunto' => 'Assunto',
            'proprietario' => 'proprietario',
            'duracaoEmMinutos' => 30,
            'eventoGeradoPorRoletagem' => true,
            'descricao' => 'Descricao',
            'proprietario' => 'String',
            'eventoAceito' => false,
            'analisadoBatch' => true
        });

    }

    @isTest
    public static void testeNewInstanceNull()
    {
        // WHEN
        EventMapper eventMpp = (EventMapper) new EventMapper().newInstance('');

        // THEN
        System.assert(eventMpp == null, 'Não deveria retornar uma instância de EventMapper');
    }
}