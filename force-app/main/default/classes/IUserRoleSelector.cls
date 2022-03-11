public interface IUserRoleSelector 
{
    List<SObject> buscarPapeisPeloNome(Set<String> nomesPapeis); //Responsável por buscar o papel pelo nome informado
    SObject buscarPapelPorId(String idDoPapel);
}