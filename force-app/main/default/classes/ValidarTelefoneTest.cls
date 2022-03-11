@isTest
public with sharing class ValidarTelefoneTest 
{
    @isTest
    static void testCriarPesquisa()
    {
        // GIVEN
        ValidarTelefone.BotInput botInput = new ValidarTelefone.BotInput();
        botInput.telefoneInput = '(99) 99999-9999';

        // THEN
        List<Object> result = ValidarTelefone.retornarTelefoneValido(new List<ValidarTelefone.BotInput>{
            botInput
        });

        System.assert(!result.isEmpty(), 'A classe não pode retornar uma lista vazia');
    }    
}