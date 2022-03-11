public interface IListaActiveCampaignService 
{
	void inserirAtualizarListaActivePorIdListaComNomeFila(String idLista, String nomeLista);
	List<ListaActiveCampaignMapper> obterListaActivePorIdsLista(Set<String> idsLista);
}