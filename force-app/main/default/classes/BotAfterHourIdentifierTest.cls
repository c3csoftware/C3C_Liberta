@isTest
public with sharing class BotAfterHourIdentifierTest 
{

    @isTest
    static void testRetornarHorarioValido()
    {
        // GIVEN
        BotAfterHourIdentifier.BotInput botInput = new BotAfterHourIdentifier.BotInput();
        botInput.horariosAtendimentoEmString = '9:00|11:30|1|5';

        // THEN
        List<Object> result = BotAfterHourIdentifier.retornarHorarioValido(new List<BotAfterHourIdentifier.BotInput>{
            botInput
        });

        System.assert(!result.isEmpty(), 'A classe não pode retornar uma lista vazia');
    }

    @isTest
    static void testRetornarHorarioInvalido()
    {
        // GIVEN
        BotAfterHourIdentifier.BotInput botInput = new BotAfterHourIdentifier.BotInput();
        botInput.horariosAtendimentoEmString = '11:30|12:00|7|10';

        // THEN
        List<Object> result = BotAfterHourIdentifier.retornarHorarioValido(new List<BotAfterHourIdentifier.BotInput>{
            botInput
        });

        System.assert(!result.isEmpty(), 'A classe não pode retornar uma lista vazia');
    }
}