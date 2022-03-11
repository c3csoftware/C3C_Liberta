@isTest
public with sharing class AccountDomainTest 
{
    @isTest 
    static void testeNewInstancePassandoList()
    {
        List<AccountDomain> listaAccountDomain = (List<AccountDomain>) new AccountDomain().newInstance(new List<SObject> {
            Schema.getGlobalDescribe().get(new AccountMapper().getObjectName()).newSObject()
        });

        System.assert(listaAccountDomain.size() > 0, 'A lista de AccountDomain não pode está vazia.');
    }

    @isTest 
    static void testeNewInstancePassandoMap()
    {
        new AccountDomain().newInstance(new Map<String, Object> {
            'idRegistro' => 'Teste',
            'leadConvertido' => (LeadMapper) C3C_DIContainer_Injector.newInstance('LeadMapper')
        });
    }

    @isTest 
    static void testeNewInstancePassandoSobject()
    {
        IAccountDomain leadStatus = (IAccountDomain) new AccountDomain().newInstance(
            Schema.getGlobalDescribe().get(new AccountMapper().getObjectName()).newSObject()
        );

        leadStatus.atribuirNovoIdDoRegistro();
        leadStatus.obterMapper();
        leadStatus.obterRegistro();
    }

    @isTest 
    static void testeNewInstancePassandoAccountMapper()
    {
        new AccountDomain().newInstance(new AccountMapper());
    }
}