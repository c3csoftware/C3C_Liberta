@isTest
public without sharing class UserDomainTest
{
	@isTest
    public static void testeNewInstanceEnviandoSObject()
    {
        //WHEN
        IUserDomain userDomain = (IUserDomain) new UserDomain().newInstance(Schema.getGlobalDescribe().get(
        	'User'
        ).newSObject());
        
        //THEN
        System.assert(userDomain.obterMapper() != null, 'A mapper deveria estar diferente de null');
        System.assert(userDomain.obterRegistro() != null, 'O registro deveria estar diferente de null');
    }

    @isTest
    static void testeNewInstanceEnviandoListSobject()
    {
        new UserDomain().newInstance((List<SObject>) new List<SObject>
        {
            Schema.getGlobalDescribe().get(
                'User'
            ).newSObject(),
            Schema.getGlobalDescribe().get('User').newSObject()
        } );

        // System.assert(listUserDomain.size() > 0, 'O método não deve estar vazio');
    }

    @isTest
    public static void testeNewInstanceEnviandoNull()
    {
        //WHEN
        Object resultNull = new UserDomain().newInstance('');
        
        //THEN
        System.assert(resultNull == null, 'Não deve retornar um registro');
        
    }
}