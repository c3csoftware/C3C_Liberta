@isTest
public with sharing class ContaDomainFactoryTest 
{
    @isTest 
    static void testeCriarContaDomainPassandoCpfEstaSendoCriado()
    {
        ContaMapper contaMapper = ContaDomainFactory.criarContaDomain('Nome', '000.000.000-00', 'email', 'telefone', true);

        System.assert(contaMapper != null, 'O método deve retornar uma contaMapper preenchida.');
    }

    @isTest 
    static void testeCriarContaDomainPassandoCnpj()
    {
        ContaMapper contaMapper = ContaDomainFactory.criarContaDomain('Nome', '00.000.000/0000-00', 'email', 'telefone', false);

        System.assert(contaMapper != null, 'O método deve retornar uma contaMapper preenchida.');
    }
}