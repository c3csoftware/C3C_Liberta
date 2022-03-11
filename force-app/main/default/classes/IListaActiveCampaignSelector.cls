public interface IListaActiveCampaignSelector 
{
	SObject obterListaActivePorIdLista(String idLista);
	List<SObject> obterListaActivePorIdsLista(Set<String> idsLista);
}