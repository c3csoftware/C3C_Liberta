@isTest
public with sharing class ContactMapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        //WHEN
        String  nomeDaAPIObjeto = new ContactMapper().getObjectName();
        
        //THEN
        System.assertEquals('Contact', nomeDaAPIObjeto, 'O nome do objeto deveria ser "Contact"');
    }
    
    @isTest
    public static void testNewInstance()
    {
        //WHEN
        ContactMapper userMpp = (ContactMapper) new ContactMapper().newInstance(Schema.getGlobalDescribe().get(
        	new ContactMapper().getObjectName()
        ).newSObject());
        
        //THEN
        System.assert(userMpp != null, 'Deveria retornar uma instância de ContactMapper');
    }
}