public interface ILeadFilhoService
{
    List<LeadFilhoMapper> inserirAtualizarLeadFilhoPorChaveLeadLista(List<LeadFilhoMapper> listLeadFilhoMapper);
    void deletarLeadFilhoPorListaIdLead(List<String> listaIdLead);
    List<LeadFilhoMapper> obterLeadFilhoPorListaIdLeadFilho(List<String> listaIdLeadFilho);
    List<LeadFilhoMapper> obterLeadFilhoPorListaIdLeadIdOportunidade(List<String> listaIdLeadIdOportunidade);
    void voltarListaLeadParaFilaCorrespondete(String idListaLead);
    ILeadFilhoDomain obterLeadFilhoPorIdDoRegistro(String idLead);
    List<LeadFilhoDomain> obterLeadFilhoPorListaIdLead(List<String> listaIdLead);
}