public interface IAccountTeamMemberService 
{
    List<AccountTeamMemberMapper> inserirAtualizarAccountTeamMemberPorChaveUsuarioConta(List<AccountTeamMemberMapper> listAccountTeamMemberMapper);
    void deletarAccountTeamMemberPorIdConta(Set<String> listaIdConta);
    List<AccountTeamMemberMapper> obterAccountTeamMemberPorIdConta(Set<String> listaIdConta);
}