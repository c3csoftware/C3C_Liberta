public interface ILeadSelector 
{
    SObject obterLeadPorActiveCampaignId(String activeCampaignId);
    SObject buscarLeadComNumeroCelular(String numeroCelular); //Responsável por buscar lead com o número de celular informado
    List<SObject> obterLeadPorIdsDoLead(List<String> idsLead);
    SObject obterLeadPorIdDoLead(String idLead);
    List<SObject> obterLeadComStatusNovoPorIdsDoLead(List<String> idsLead);    
}