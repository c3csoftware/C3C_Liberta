public interface IBuscarInformacoesOportunidadeService 
{
    List<IOportunidadeDomain> obterOportunidadePorIdsDeOportunidade(List<String> idsOportunidade); //Responsável por obter oportunidades por ids
}