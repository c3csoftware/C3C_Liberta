public interface IConfigRoteamentoFilaSelector 
{
    //Responsável por buscar a configuração de roteamento fila com o "DeveloperName" informado.
    SObject buscarConfigRoteamentoFilaComNomeDesenvolvedor(String nomeDesenvolvedor);
    //Responsável por buscar a configuração de roteamento fila com o "Id" informado.
    SObject buscarConfigRoteamentoFilaComIdRegistro(String idConfigRoteamentoFila);
    //Responsável por buscar uma lista de configurações de roteamento fila com uma lista de "DeveloperName" informado.
    List<SObject> buscarConfigRoteamentoFilaComListaNomeDesenvolvedor(Set<String> listaNomesDesenvolvedor);
    //Responsável por buscar uma lista de configurações de roteamento fila com uma lista de "Id" informado.
    List<SObject> buscarConfigRoteamentoFilaComListaIdRegistro(Set<String> listaIdConfigRoteamentoFila);
}