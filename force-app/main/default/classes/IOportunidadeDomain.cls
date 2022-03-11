public interface IOportunidadeDomain
{
   OportunidadeMapper criarOportunidade(String lead, String activeCampaignId, String etapaOportunidade, String nome, String funil, String fase, Decimal valor, Date dataFechamento);
   OportunidadeMapper obterMapper();
   SObject obterRegistro();
   void preencherNovoId();
}