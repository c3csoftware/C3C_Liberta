public interface ILeadDomain 
{
    LeadMapper criarLead(String activeCampaignId, String nome, String sobrenome, String email, String empresa, String telefone);
    LeadMapper construirLeadMapper(SObject lead);
    List<LeadMapper> construirListLeadMapper(List<SObject> listLead);
    LeadMapper obterMapper();
    SObject obterRegistro();
    Map<String, LeadMapper> construirMapLeadMapper(List<SObject> listLead);
}