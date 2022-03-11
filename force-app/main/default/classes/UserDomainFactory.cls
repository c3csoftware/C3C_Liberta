public without sharing class UserDomainFactory 
{
    //Resposável por construir uma lista de User Domain a partir de uma lista de SObject
    public static List<UserDomain> construirListaUserDomainAPartirListaSobject(List<SObject> listaUserSObject)
    {
        List<UserDomain> listaUser = new List<UserDomain>();

        for (SObject negocio : listaUserSObject)
        {
            listaUser.add((UserDomain) C3C_DIContainer_Injector.newInstance('UserDomain', negocio));
        }
        
        return listaUser;
    }

    public static Map<String, UserDomain> construirMapUserDomainAPartirListaSobject(List<SObject> listaUserSObject)
    {
        Map<String, UserDomain> mapUser = new Map<String, UserDomain>();

        for (SObject negocio : listaUserSObject)
        {
            User userNegocio =(User) negocio;
            mapUser.put(String.valueOf(userNegocio.CodigoAssessor__c), (UserDomain) C3C_DIContainer_Injector.newInstance('UserDomain', negocio));
        }
        
        return mapUser;
    }
}