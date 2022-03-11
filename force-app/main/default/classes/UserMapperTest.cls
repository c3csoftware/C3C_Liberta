@isTest
public without sharing class UserMapperTest 
{
	@isTest
    public static void testeGetObjectName()
    {
        //WHEN
        String  nomeDaAPIObjeto = new UserMapper().getObjectName();
        
        //THEN
        System.assertEquals('User', nomeDaAPIObjeto, 'O nome do objeto deveria ser "User"');
    }
    
    @isTest
    public static void testNewInstance()
    {
        //WHEN
        UserMapper userMpp = (UserMapper) new UserMapper().newInstance(Schema.getGlobalDescribe().get(
        	new UserMapper().getObjectName()
        ).newSObject());
        
        //THEN
        System.assert(userMpp != null, 'Deveria retornar uma instância de UserMapper');
    }
}