public interface IContaService 
{
    ContaMapper obterContaPorId(String idConta);
    List<ContaMapper> obterContaPorEquipe(List<String> listaEquipe);
}