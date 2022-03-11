public without sharing class UserDomain implements IUserDomain, C3C_DI_IProvider
{
    //Exception
    public class UserDomainException extends Exception {}

    //Atributos
    private UserMapper userMapper 
    {
        get
        {
            if(this.userMapper == null)
                this.userMapper = (userMapper) C3C_DIContainer_Injector.newInstance('UserMapper');

            return this.userMapper;
        }
        set;
    }

    //Contrutores
    public UserDomain() 
    {}
    
    private UserDomain(SObject usuarioSObject)
    {
        this.construirDomainComSObject(usuarioSObject);
    }

    private UserDomain(List<SObject> listUsuariosSObject)
    {
        this.construirListaDomainComListaSObject(listUsuariosSObject);
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return new UserDomain((List<SObject>) params);

        if(params instanceOf SObject)
            return new UserDomain((SObject) params);

        

        return null;
    }

    //Responsável por retornar a mapper
    public UserMapper obterMapper()
    {
        return this.userMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.userMapper.record;
    }

    //Responsável por preencher um novo id no mapper
    public void preencherNovoId()
    {
        this.userMapper.idRegistro = this.userMapper.record.Id;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject usuarioSObject)
    {
        this.userMapper = (UserMapper) C3C_DIContainer_Injector.newInstance('UserMapper', usuarioSObject);
    }

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<UserDomain> construirListaDomainComListaSObject(List<SObject> listaUsuariosSObject)
    {
        List<UserDomain> listaDeUsuariosDomain = new List<UserDomain>();

        for(SObject usuarioSObject : listaUsuariosSObject)
            listaDeUsuariosDomain.add(new UserDomain(usuarioSObject));

        return listaDeUsuariosDomain;
    }
}