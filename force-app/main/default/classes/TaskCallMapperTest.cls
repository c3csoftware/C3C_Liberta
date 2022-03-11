@isTest
public with sharing class TaskCallMapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        //WHEN
        String  nomeDaAPIObjeto = new TaskCallMapper().getObjectName();
        
        //THEN
        System.assertEquals('Task', nomeDaAPIObjeto, 'O nome do objeto deveria ser "User"');
    }
    
    @isTest
    public static void testNewInstance()
    {
        //WHEN
        TaskCallMapper userMpp = (TaskCallMapper) new TaskCallMapper().newInstance(Schema.getGlobalDescribe().get(
        	new TaskCallMapper().getObjectName()
        ).newSObject());
        
        //THEN
        System.assert(userMpp != null, 'Deveria retornar uma instância de TaskCallMapper');
    }
}