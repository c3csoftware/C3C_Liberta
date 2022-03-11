@isTest
public with sharing class AccountMapperTest 
{
    @isTest 
    static void testeNewInstancePassandoSobject()
    {
        new AccountMapper().newInstance(Schema.getGlobalDescribe().get(new AccountMapper().getObjectName()).newSObject());
    }

    @isTest 
    static void testeNewInstancePassandoMap()
    {
        new AccountMapper().newInstance(new Map<String, Object> {
            'idRegistro' => 'teste',
            'nomeConta' => 'teste',
            'idChaveExterna' => 'teste'
        });
    }
}