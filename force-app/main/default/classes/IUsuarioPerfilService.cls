public interface IUsuarioPerfilService 
{
    //Responsável por buscar os usuários pelo id com informação do perfil
    List<UserDomain> obterListaUsuarioPeloIdComNomePerfil(List<String> listaDeIdRegistro);
}