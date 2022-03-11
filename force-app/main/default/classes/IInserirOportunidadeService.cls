public interface IInserirOportunidadeService 
{
    IOportunidadeDomain gerarOportunidadeComNome(String nome, String contaId);
    List<IOportunidadeDomain> gerarOportunidadePorListaDomain(List<IOportunidadeDomain> listaOportunidadeDomain);
}