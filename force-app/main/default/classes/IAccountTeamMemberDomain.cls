public interface IAccountTeamMemberDomain 
{
    AccountTeamMemberMapper construirAccountTeamMemberMapper(SObject accountTeamMember);
    List<AccountTeamMemberMapper> construirListAccountTeamMemberMapper(List<SObject> listAccountTeam);
    AccountTeamMemberMapper criarAccountTeamMemberMapperComPermissaoEdit(String idUsuario, String idConta, String papelMembro);
}