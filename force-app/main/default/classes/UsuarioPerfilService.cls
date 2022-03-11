public without sharing virtual class UsuarioPerfilService implements IUsuarioPerfilService
{
    //
    //Métodos
    //

    //Responsável por buscar os usuários pelo id com informação do perfil
    public List<UserDomain> obterListaUsuarioPeloIdComNomePerfil(List<String> listaDeIdRegistro)
    {
        return (List<UserDomain>) DomainFactory.buildListDomainWithListSObject('UserDomain', this.instanciaUserSelector.obterUsuariosComListaDeId(listaDeIdRegistro));
    }

    //
    //Atributos
    //

    private IUserSelector instanciaUserSelector
    {
        get
        {
            if(this.instanciaUserSelector == null)
                this.instanciaUserSelector = (IUserSelector) C3C_DIContainer_Injector.getInstance('UserSelector');

            return this.instanciaUserSelector;
        }
        set;
    }
}