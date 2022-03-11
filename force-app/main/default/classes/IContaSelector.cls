public interface IContaSelector 
{
    SObject obterContaPorId(String idConta);
    List<SObject> obterContaPorEquipe(List<String> listaEquipe);
    List<SObject> obterContasPorCodigosXP(List<String> codigosXP);
    SObject obterContaPorIdChaveExterna(String idChaveExterna);
    List<SObject> obterContasPorIdsChaveExterna(List<String> listaIdChaveExterna);
}