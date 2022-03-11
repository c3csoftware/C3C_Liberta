public interface IEventRelationService
{
    IEventRelationDomain criarRelacaoDoEvento(String idEvento, String idRelacao);
    void excluirRelacaoDoEvento(List<IEventRelationDomain> listaRelacaoDoEvento);
    List<IEventRelationDomain> obterListaEventosDeRoletagemRelacionadoQueForamRespondidos(); //Método responsável por retornar a lista de eventos de roletagem relacionados, que acabaram de ser aceitos
}