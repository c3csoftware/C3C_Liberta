public interface INegocioSelector 
{
    SObject buscarNegocioPorIdNegocioActiveCampaign(String idNegocioActiveCampaign); //Responsável por buscar o negócio pelo id ActiveCampaign do negócio 
    List<SObject> buscarListaDeNegociosComListaDeIds(List<String> listaIdsNegocio); //Resposável por buscar uma lista de negócio pelos ids 
}