@isTest
public with sharing class ContactDomainTest 
{
    @isTest
    public static void testeNewInstanceEnviandoSObject()
    {
        //WHEN
        IContactDomain contaDomain = (IContactDomain) new ContactDomain().newInstance(Schema.getGlobalDescribe().get(
        	'Contact'
        ).newSObject());
        
        //THEN
        System.assert(contaDomain.obterMapper() != null, 'A mapper deveria estar diferente de null');
        System.assert(contaDomain.obterRegistro() != null, 'O registro deveria estar diferente de null');
    }

    @isTest
    public static void testeNewInstanceEnviandoNull()
    {
        //WHEN
        Object resultNull = new ContactDomain().newInstance('');
        
        //THEN
        System.assert(resultNull == null, 'Não deve retornar um registro');
        
    }
}