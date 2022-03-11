public interface IFunilService 
{
    FunilDomain obterFunilPorIdFunilActiveCampaign(String idFunilActiveCampaign); //Responsável por obter o funil utilizando id funil ActiveCampaign
    FunilDomain criarFunilComIdFunilActiveCampaignENomeFunil(String idFunilActiveCampaign, String nomeFunil); //Responsável por criar funil na base de dados
}