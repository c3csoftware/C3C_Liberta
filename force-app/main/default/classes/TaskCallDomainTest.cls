@isTest
public with sharing class TaskCallDomainTest 
{
    @isTest
    public static void testeNewInstanceEnviandoSObject()
    {
        //WHEN
        ITaskCallDomain userDomain = (ITaskCallDomain) new TaskCallDomain().newInstance(Schema.getGlobalDescribe().get(
        	'Task'
        ).newSObject());
        
        //THEN
        System.assert(userDomain.obterMapper() != null, 'A mapper deveria estar diferente de null');
        System.assert(userDomain.obterRegistro() != null, 'O registro deveria estar diferente de null');
    }

    @isTest
    public static void testeNewInstanceEnviandoNull()
    {
        //WHEN
        Object resultNull = new TaskCallDomain().newInstance('');
        
        //THEN
        System.assert(resultNull == null, 'Não deve retornar um registro');
        
    }
}