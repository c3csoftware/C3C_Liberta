public interface IAccountSelector 
{
    List<SObject> buscarContaPorId(String Id);
    List<SObject> buscarContasPorIds(Set<String> contaIds);
    List<SObject> buscarContasPorDadosLead(List<LeadMapper> listaLeadMapper);
    List<SObject> buscarContasComPesquisaParaHoje();
}