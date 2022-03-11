public interface IListaActiveCampaignDomain 
{
	List<ListaActiveCampaignMapper> construirListListaActiveCampaignMapper(List<SObject> listListaActiveCampaign);
	ListaActiveCampaignMapper criarListaActiveCampaignPorIdLista(String idLista, String nomeLista, String nomeFila);
	String verificarNomeListaLibertaOuLS(String nomeLista);
	String tratarNomeListaActiveCampaign(String nomeLista);
}