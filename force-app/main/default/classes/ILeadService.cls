public interface ILeadService 
{
    LeadMapper inserirAtualizarLeadPorActiveCampaignId(String activeCampaignId, String nome, String sobrenome, String email, String empresa, String telefone);
    LeadMapper obterLeadPorActiveCampaignId(String activeCampaignId);
    ILeadDomain obterLeadPorId(String idLead);
}