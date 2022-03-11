public interface ILeadFilhoSelector 
{
    SObject obterLeadFilhoPorChaveLeadLista(String chaveLeadListaActive);
    SObject obterLeadFilhoPorId(String idRegistro);
    List<SObject> obterLeadFilhoPorListaIdLead(List<String> listaIdLead);
    List<SObject> obterLeadFilhoPorListaIdLeadFilho(List<String> listaIdLeadFilho);
    List<SObject> obterLeadFilhoPorIdsDaListaEIdContatoActive(Set<String> listaIdDaLista, String idContatoActive);
    List<SObject> obterLeadFilhoPorListaChaveExterna(List<String> listaChaveLeadLista);
    List<SObject> buscarLeadFilhoPorListaIdLeadIdOportunidade(List<String> listaIdLeadIdOportunidade);
}