@isTest
public with sharing class BotCriarPesquisaTest 
{
    @isTest
    static void testCriarPesquisa()
    {
        // GIVEN
        BotCriarPesquisa.BotInput botInput = new BotCriarPesquisa.BotInput();
        botInput.codigoCliente = '123';
        botInput.notaPesquisa = '5';
        botInput.entidadePesquisa = 'Bot Liberta';
        botInput.nomeCliente = 'Teste';

        // THEN
        BotCriarPesquisa.criarPesquisa(new List<BotCriarPesquisa.BotInput>{
            botInput
        });
    }
}