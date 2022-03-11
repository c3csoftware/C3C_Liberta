@isTest
public with sharing class PedidoDomainTest 
{
    @isTest 
    static void testeFormatarCpfOuCnpjPassandoCpf()
    {
        String retornoCpfFormatado = new PedidoDomain().formatarCpfOuCnpj('00000000000');

        System.assert(retornoCpfFormatado == '000.000.000-00', 'O método deveria retornar o CPF mascarado.');
    }

    @isTest 
    static void testeFormatarCpfOuCnpjPassandoCnpj()
    {
        String retornoCnpjFormatado = new PedidoDomain().formatarCpfOuCnpj('00000000000000');

        System.assert(retornoCnpjFormatado == '00.000.000/0000-00', 'O método deveria retornar o CNPJ mascarado');
    }

    @isTest 
    static void testeFormatarCpfOuCnpjPassandoNull()
    {
        try 
        {
            String retornoNull = new PedidoDomain().formatarCpfOuCnpj('');

        }catch(Exception e)
        {
            System.assert(e.getMessage() != null, 'O método deveria lançar uma excessão.');
        }
        
    }
}