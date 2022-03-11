public interface IUserRoleService 
{
    Set<String> obterIdsPapeisPeloNome(List<String> nomesPapeis); //Responsável por retornar o id papel pelo nome
    String obterPapelPorId(String idPapel); //Responsável por retornar o nome papel pelo id
}