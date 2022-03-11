public interface IAccountTeamMemberSelector 
{
    List<SObject> obterAccountTeamMembers();
    List<SObject> buscarAccountTeamMemberPorIdConta(Set<String> listaIdConta);
}