public interface IOportunidadeService
{
   void inserirAtualizarOportunidadePorActiveCampaignId(String lead, String activeCampaignId, String etapaOportunidade, String nome, String funil, String fase, Decimal valor, Date dataFechamento);
   OportunidadeMapper criarOportunidadeRelacionadoLead(String leadId, String nome); //Responsável por criar oportunidade relacionada ao lead
   OportunidadeMapper criarOportunidadeRelacionadoConta(String contaId, String nome); //Responsável por criar oportunidade relacionada à conta
}