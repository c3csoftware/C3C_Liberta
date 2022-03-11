public interface IOportunidadeSelector
{
    SObject obterOportunidadePorActiveCampaignId(String activeCampaignId);
    List<SObject> obterOportunidadePorListaChaveExterna(List<String> listaChaveExterna);
    List<SObject> obterOportunidadePorIdsDeOportunidade(List<String> idsOportunidade); //Responsável por obter oportunidades por ids
}