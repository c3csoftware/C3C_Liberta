public interface IConfigRoteamentoFilaService 
{
    //Responsável por obter a configuração de roteamento fila com o "DeveloperName" informado.
    ConfigRoteamentoFilaDomain obterConfigRoteamentoFilaComNomeDesenvolvedor(String nomeDesenvolvedor);
    //Responsável por obter a configuração de roteamento fila com o "Id" informado.
    ConfigRoteamentoFilaDomain obterConfigRoteamentoFilaComIdRegistro(String idConfigRoteamentoFila);
    //Responsável por obter uma lista de configurações de roteamento fila com uma lista de "DeveloperName" informado.
    List<ConfigRoteamentoFilaDomain> obterConfigRoteamentoFilaComListaNomeDesenvolvedor(Set<String> listaNomesDesenvolvedor);
    //Responsável por obter uma lista de configurações de roteamento fila com uma lista de "Id" informado.
    List<ConfigRoteamentoFilaDomain> obterConfigRoteamentoFilaComListaIdRegistro(Set<String> listaIdConfigRoteamentoFila);
}