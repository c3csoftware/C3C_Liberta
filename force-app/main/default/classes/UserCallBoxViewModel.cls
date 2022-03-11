public without sharing class UserCallBoxViewModel implements C3C_DI_IProvider
{
    //
    //Atributos
    //

    @AuraEnabled
    public String ramalCallbox {get;set;}
    @AuraEnabled
    public String senhaCallbox {get;set;}
    @AuraEnabled
    public String serverCallbox {get;set;}

    //
    //Construtores
    //

    public UserCallBoxViewModel()
    {}

    private UserCallBoxViewModel(IUserDomain usuario)
    {
        UserMapper usuarioMapper = usuario.obterMapper();

        this.ramalCallbox = usuarioMapper.ramal;
        this.senhaCallbox = usuarioMapper.senhaCallbox;
        this.serverCallbox = usuarioMapper.serverCallbox;
    }

    //
    //Métodos
    //

    public Object newInstance(Object params)
    {
        if(params instanceOf IUserDomain)
            return new UserCallBoxViewModel((IUserDomain) params);

        return null;
    }
}