public interface IAccountTriggerService 
{
    void atribuirNomeConta(List<ContaMapper> listaContaMapper);
    void atribuirPerfilClienteNaConta(List<ContaMapper> listaContaMapper);
    void atribuirMembrosConta(List<ContaMapper> listaContaMapper);
    void atribuirCpfOuCnpjEmIdChaveExterna(List<ContaMapper> listaContaMapper);
    void tratarCodigoAssessor(List<ContaMapper> listaContaMapper);
    void atribuirProprietarioContaPeloCodigoAssessor(List<ContaMapper> listaContaMapper);
    void atribuirProdutoLsEmConta(List<ContaMapper> listaContaMapper);
}