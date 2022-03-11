public interface INegocioService
{
    NegocioDomain obterNegocioPorIdNegocioActiveCampaign(String idNegocioActiveCampaign); //Responsável por obter o negócio pelo id ActiveCampaign do negócio 
    List<NegocioDomain> obterListaNegocioPorListaIds(List<String> listaIdsNegocio); //Resposável por obter uma lista de negócio por ids
    void atribuirNegociosAoUsuario(List<String> idsNegocio, String idUsuario); //Responsável por atribuir negócio ao usuário
}