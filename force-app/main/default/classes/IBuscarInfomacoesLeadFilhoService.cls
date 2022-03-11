public interface IBuscarInfomacoesLeadFilhoService 
{
    ILeadFilhoDomain obterLeadFilhoPorId(String idRegistro);
    Map<String,Object> obterMapaLeadFilhoComLead(List<String> idsLeadFilho);
    List<ILeadFilhoDomain> obterLeadFilhoPorIdsDaListaEIdContatoActive(Set<String> listaIdDaLista, String idContatoActive);
}